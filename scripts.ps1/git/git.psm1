<#
    The powershell script module for git.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

<#
    .Synopsis
    Initialize git local repository for the current working directory.
#>
function Git-Initialize {
    param (
        [Parameter(Mandatory=$true)]
        [string] $UserName,
        [Parameter(Mandatory=$true)]
        [string] $Email
    )
    process {
        if (Test-Path '.git') {
            Write-Host "skipping git init"
        } else {
            & git init
            if (-not $?) {
                throw "git init failed with code $LastExitCode"
            }
        }

        & git config user.name "$UserName"
        & git config user.email "$Email"

        & git describe --always 2>&1 >$null
        if ($?) {
            Write-Host "skipping git commit"
        } else {
            & git commit --allow-empty -m 'Initial commit'
        }
    }
}

Export-ModuleMember -Function *
