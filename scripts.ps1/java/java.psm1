<#
    The powershell script module for java.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

# $BaseDir = Join-Path $env:AppData 'java'
$BaseDir = 'C:\Program Files\Java'

<#
    .Synopsis
    Initialize java environment for the current powershell session.
#>
function Java-Activate {
    param (
        [string] $Version = 'latest',
        [switch] $ListVersions
    )
    process {
        $Versions = @(Get-ChildItem -Directory -Name -Path $BaseDir | % {
            $_ = $_ -replace 'jdk',''
            $_ = $_ -replace 'jre',''
            $_ = $_ -replace '_','.'
            return $_
        } | Sort-Object -Descending {
            try {
                [System.Version] $_
            }
            catch {
                [System.Version]::new()
            }
        })
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

function Java-Install {
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

Export-ModuleMember -Function *
