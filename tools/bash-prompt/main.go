package main

import (
	"bytes"
	"context"
	"embed"
	"errors"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"text/template"
	"time"

	"github.com/comail/colog"
	"github.com/mgutz/ansi"
)

var (
	//go:embed assets/*
	assetsFS embed.FS
)

func stdoutContext(ctx context.Context, name string, args ...string) (string, error) {
	var (
		stdout bytes.Buffer
		stderr bytes.Buffer
	)
	cmd := exec.CommandContext(ctx, name, args...)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	if err := cmd.Run(); err != nil {
		if ee, ok := err.(*exec.ExitError); ok {
			ee.Stderr = stderr.Bytes()
		}
		return "", err
	}
	return strings.TrimSpace(stdout.String()), nil
}

func dirInfo() string {
	wd, err := os.Getwd()
	if err != nil {
		return err.Error()
	}
	return filepath.Base(wd)
}

func gitInfo(ctx context.Context) string {
	username, err := stdoutContext(ctx, "git", "config", "user.name")
	if ee, ok := err.(*exec.ExitError); ok {
		log.Printf("warning: %v\n%v", ee.Error(), string(ee.Stderr))
	} else if err != nil {
		log.Printf("warning: %v", err)
	}
	if username == "" {
		username = "-"
	}
	branch, err := stdoutContext(ctx, "git", "symbolic-ref", "--short", "HEAD")
	if ee, ok := err.(*exec.ExitError); ok {
		log.Printf("warning: %v\n%v", ee.Error(), string(ee.Stderr))
	} else if err != nil {
		log.Printf("warning: %v", err)
	}
	if branch == "" {
		branch = "-"
	}
	return "(" + username + "@" + branch + ")"
}

func nodeInfo() string {
	v, err := os.Hostname()
	if err != nil {
		log.Printf("warning: %v", err)
	}
	if v == "" {
		v = "???"
	}
	return v
}

func writePrompt(ctx context.Context, w io.Writer) error {
	tpl := template.New("ps1")
	tpl = tpl.Delims("{", "}")
	tpl, err := tpl.Parse(`PS1='{.reset}{.base}[\u@{.nodeInfo} {.dirInfo} {.gitInfo}]\$ {.reset}'`)
	if err != nil {
		return err
	}
	return tpl.Execute(w, map[string]any{
		"reset":    `\[` + ansi.Reset + `\]`,
		"base":     `\[` + ansi.LightBlack + `\]`,
		"nodeInfo": nodeInfo(),
		"dirInfo":  dirInfo(),
		"gitInfo":  gitInfo(ctx),
	})
}

func writeInitScript(w io.Writer) error {
	b, err := assetsFS.ReadFile("assets/init.bash")
	if err != nil {
		return err
	}
	_, err = fmt.Fprintln(w, string(b))
	return err
}

func run(stdout, stderr io.Writer, args []string) int {
	colog.Register()
	colog.SetDefaultLevel(colog.LInfo)
	colog.SetOutput(stderr)

	var (
		timeout  = 3 * time.Second
		loglevel = "error"
	)
	flgs := flag.NewFlagSet("git-prompt", flag.ContinueOnError)
	flgs.DurationVar(&timeout, "timeout", timeout, "command timeout duration")
	flgs.StringVar(&loglevel, "loglevel", loglevel, "logging level")
	if err := flgs.Parse(args[1:]); errors.Is(err, flag.ErrHelp) {
		return 0
	} else if err != nil {
		log.Printf("error: %v", err)
		return 1
	}

	if lvl, err := colog.ParseLevel(loglevel); err != nil {
		log.Printf("error: unable to parse %q: %v", loglevel, err)
		return 1
	} else {
		colog.SetMinLevel(lvl)
	}

	ctx := context.Background()
	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	var err error
	switch flgs.Arg(0) {
	case "init":
		err = writeInitScript(stdout)
	default:
		err = writePrompt(ctx, stdout)
	}
	if err != nil {
		log.Printf("error: %v", err)
		return 1
	}
	return 0
}

func main() {
	os.Exit(run(os.Stdout, os.Stderr, os.Args))
}
