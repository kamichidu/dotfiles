$env:Path = "C:\msys64\usr\bin;$env:Path"

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
