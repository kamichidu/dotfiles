<#
    The powershell script module for golang.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

<#
    .Synopsis
    Initialize go environment for the current powershell session.
#>
function Go-Activate {
    param (
        [string] $BaseDir = 'C:\system-apps\go',
        [string] $Version = 'latest',
        [switch] $ListVersions
    )
    process {
        $Versions = @(Get-ChildItem -Directory -Name -Path $BaseDir | Sort-Object -Descending { [System.Version] $_ })
        if ($ListVersions) {
            Write-Host 'available versions:'
            $Versions | ForEach-Object {
                Write-Host "- $_"
            }
            return
        }

        if ($Version -eq 'latest') {
            $Version = $Versions[0]
        }
        if (-not ($Versions -contains $Version))
        {
            throw "no such version $Version, availables: $($Versions -join ', ')"
        }

        # remove unnecessary paths
        foreach ($RemovalVersion in $Versions) {
            $RemovalGoRoot = Join-Path $BaseDir $RemovalVersion
            $env:Path = Path-Remove $env:Path (Join-Path $RemovalGoRoot 'bin')
        }

        $GoRoot = Join-Path $BaseDir $Version

        $env:Path = Path-Prepend $env:Path (Join-Path $GoRoot 'bin')
        $env:GOROOT = $GoRoot
    }
}

Export-ModuleMember -Function Go-Activate
