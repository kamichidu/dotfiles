$pathItems = @(
    # msys2 ssh does not support colors, prefer to use Win32-OpenSSH.
    'C:\Windows\System32\OpenSSH',
    'C:\msys64\usr\bin')
$oldPathItems = $env:Path.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
foreach ($p in $oldPathItems) {
    # trim suffix to uniform path form
    $p = $p.TrimEnd('\')
    if ($pathItems -contains $p) {
        continue
    }
    $pathItems = $pathItems + @($p)
}
$env:Path = ($pathItems -join ';')

function Prompt {
    $LastExitCode = $global:LastExitCode
    try {
        $cwd = $PWD.Path
        $Host.UI.RawUI.WindowTitle = Split-Path -Leaf -Path $cwd

        # color prompt
        & {
            Write-Host -NoNewline "`n"
            Write-Host -NoNewline -ForegroundColor Green 'PS'
            Write-Host -NoNewline ' '
            $prefixes = @()
            if ($env:GOPATH) {
                $prefixes += @(@{Name='$GOPATH'; Value=$env:GOPATH})
            }
            $prefixes += @(@{Name='$USERPROFILE'; Value=$env:USERPROFILE})
            $fallback = $true
            foreach ($prefix in $prefixes) {
                $shorten = $cwd -replace [regex]::Escape($prefix.Value), $prefix.Name
                if ($cwd -ne $shorten) {
                    Write-Host -NoNewline -ForegroundColor Yellow $shorten
                    $fallback = $false
                    break
                }
            }
            if ($fallback) {
                Write-Host -NoNewline -ForegroundColor Yellow $cwd
            }
            if (Get-Command -Name git -ErrorAction SilentlyContinue) {
                $branch = git branch 2>$null |
                    Where-Object { $_.StartsWith('* ') } |
                    Select-Object -Property @{Name='Name'; Expression={ $_.Substring(2) }}
                if ($branch -and $branch.Name -ne '') {
                    Write-Host -NoNewline ' '
                    Write-Host -NoNewline -ForegroundColor Cyan "($($branch.Name))"
                }
            }
            Write-Host -NoNewline "`n"
        }
        return "> "
    }
    finally {
        $global:LastExitCode = $LastExitCode
    }
}

Set-PSReadlineOption -HistoryNoDuplicates:$true

# PSReadline module v2 breaks compatibility
$fgcolor = 'Gray'
$bgcolor = 'Black'
$Host.UI.RawUI.ForegroundColor = $fgcolor
$Host.UI.RawUI.BackgroundColor = $bgcolor
if ((Get-Module -Name PSReadline).Version.Major -lt 2) {
    Set-PSReadlineOption -TokenKind None      -ForegroundColor $fgcolor    -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Comment   -ForegroundColor 'DarkGreen' -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Keyword   -ForegroundColor 'Green'     -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind String    -ForegroundColor 'DarkCyan'  -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Operator  -ForegroundColor 'DarkGray'  -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Variable  -ForegroundColor 'Green'     -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Command   -ForegroundColor 'Yellow'    -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Parameter -ForegroundColor 'DarkGray'  -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Type      -ForegroundColor 'Gray'      -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Number    -ForegroundColor $fgcolor    -BackgroundColor $bgcolor
    Set-PSReadlineOption -TokenKind Member    -ForegroundColor $fgcolor    -BackgroundColor $bgcolor
} else {
    Set-PSReadlineOption -Colors @{
        'None'      = $fgcolor;
        'Comment'   = 'DarkGreen';
        'Keyword'   = 'Green';
        'String'    = 'DarkCyan';
        'Operator'  = 'DarkGray';
        'Variable'  = 'Green';
        'Command'   = 'Yellow';
        'Parameter' = 'DarkGray';
        'Type'      = 'Gray';
        'Number'    = $fgcolor;
        'Member'    = $fgcolor;
    }
}
