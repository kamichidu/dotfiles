<#
    The powershell script module for golang.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

$BaseDir = Join-Path $env:AppData 'go'

<#
    .Synopsis
    Initialize go environment for the current powershell session.
#>
function Go-Activate {
    param (
        [string] $Version = 'latest',
        [switch] $ListVersions
    )
    process {
        $Versions = @(Go-Versions)
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
        $GoPath = $env:GOPATH
        if (-not $GoPath) {
            $GoPath = Join-Path $env:USERPROFILE 'local\opt\go'
        }

        $env:Path = Path-Prepend $env:Path (Join-Path $GoRoot 'bin')
        $env:GOROOT = $GoRoot
        $env:GOPATH = $GoPath
    }
}

<#
    .Synopsis
    List installed go versions.
#>
function Go-Versions {
    param (
    )
    process {
        Get-ChildItem -Directory -Name -Path $BaseDir |
        Where-Object { try { [System.Version] $_; $true } catch { $false } } |
        Sort-Object -Descending { [System.Version] $_ }
    }
}

function Go-Install {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Version,
        [switch] $Force
    )
    process {
        $ZipFile = "go$($Version).windows-amd64.zip"
        $ZipUrl = "https://dl.google.com/go/$ZipFile"
        $ZipPath = Join-Path $env:TEMP $ZipFile

        if (-not (Test-Path $ZipPath) -or $Force) {
            Write-Host "downloading $ZipUrl"
            Write-Host "         to $ZipPath"
            $KeepProgressPreference = $ProgressPreference
            try {
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Method Get -Uri $ZipUrl -OutFile $ZipPath
            }
            finally {
                $ProgressPreference = $KeepProgressPreference
            }
        }

        $ExtractDir = Join-Path $env:TEMP ([System.IO.Path]::GetFileNameWithoutExtension($ZipPath))
        if (Test-Path $ExtractDir) {
            Write-Host "deleting $ExtractDir"
            Remove-Item -Recurse $ExtractDir
        }
        Write-Host "extracting $ZipPath"
        Write-Host "        to $ExtractDir"
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipPath, $ExtractDir)

        # moving {zipfile}/go
        $SrcDir = Join-Path $ExtractDir 'go'
        $DestDir = Join-Path $BaseDir $Version
        if (-not (Test-Path $BaseDir)) {
            Write-Host "creating $BaseDir"
            New-Item -Type Directory -Force $BaseDir
        } elseif (Test-Path $DestDir) {
            Write-Host "deleting $DestDir"
            Remove-Item -Recurse $DestDir
        }
        Write-Host "locating go$Version into $BaseDir"
        Move-Item $SrcDir $DestDir | Out-Null
    }
}

Export-ModuleMember -Function Go-*
