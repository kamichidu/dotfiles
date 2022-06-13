package main

import (
	"bytes"
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"os/user"
	"path/filepath"
	"strings"
	"time"

	"github.com/comail/colog"
	"github.com/mgutz/ansi"
)

func stdoutContext(ctx context.Context, name string, args ...string) string {
	var (
		stdout bytes.Buffer
	)
	cmd := exec.CommandContext(ctx, name, args...)
	cmd.Stdout = &stdout
	if err := cmd.Run(); err != nil {
		log.Printf("error: failed to execute command: %v %v: %v", filepath.Base(cmd.Path), strings.Join(cmd.Args, " "), err)
		return ""
	}
	return strings.TrimSpace(stdout.String())
}

func dirInfo() string {
	wd, err := os.Getwd()
	if err != nil {
		log.Printf("error: failed to get working directory: %v", err)
		return "-"
	}

	return filepath.Base(wd)
}

func gitInfo(ctx context.Context) string {
	username := stdoutContext(ctx, "git", "config", "user.name")
	branch := stdoutContext(ctx, "git", "symbolic-ref", "--short", "HEAD")

	if username == "" {
		username = "-"
	}
	if branch == "" {
		branch = "-"
	}
	return "(" + username + "@" + branch + ")"
}

func main() {
	colog.Register()
	colog.SetDefaultLevel(colog.LInfo)
	log.SetFlags(0)
	log.SetPrefix("git-prompt: ")

	var (
		timeout  = 3 * time.Second
		loglevel = "error"
	)
	flag.DurationVar(&timeout, "timeout", timeout, "command timeout duration")
	flag.StringVar(&loglevel, "loglevel", loglevel, "logging level")
	flag.Parse()

	if lvl, err := colog.ParseLevel(loglevel); err != nil {
		panic(err)
	} else {
		colog.SetMinLevel(lvl)
	}

	ctx := context.Background()
	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	user.Current()
	reset := `\[` + ansi.Reset + `\]`
	base := `\[` + ansi.LightBlack + `\]`
	ps1 := reset + base + `[\u@local ` + dirInfo() + " " + gitInfo(ctx) + `]\$ ` + reset
	fmt.Println(`PS1='` + ps1 + `'`)
}
