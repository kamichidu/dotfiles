<#
    The powershell script module for msys2.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

$BaseDir = 'C:\msys64'

function Msys2-Install {
    param (
        [switch] $Force
    )
    process {
        $InstallerFile = "msys2-x86_64-20180531.exe"
        $InstallerUrl = "http://repo.msys2.org/distrib/x86_64/$InstallerFile"
        $InstallerPath = Join-Path $env:TEMP $InstallerFile

        if (-not (Test-Path $InstallerPath) -or $Force) {
            Write-Host "downloading $InstallerUrl"
            Write-Host "         to $InstallerPath"
            Invoke-WebRequest -Method Get -Uri $InstallerUrl -OutFile $InstallerPath
        }

        Write-Host "starting installer now"
        Write-Host "Install it to $BaseDir"
        & $InstallerPath
    }
}

Export-ModuleMember -Function Msys2-*
