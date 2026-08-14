<#
    .Synopsis
    Clone and apply dotfiles on Windows.
#>
param (
    [string] $CheckoutDir = $(if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { Join-Path $env:USERPROFILE 'dotfiles' }),
    [string] $RepositoryUrl = $(if ($env:DOTFILES_REPOSITORY_URL) { $env:DOTFILES_REPOSITORY_URL } else { 'https://github.com/kamichidu/dotfiles.git' })
)

$ErrorActionPreference = 'Stop'

try {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw 'git is required. Install Git for Windows first.'
    }

    $RepositoryRoot = Split-Path -Parent $PSScriptRoot
    if (-not (Test-Path (Join-Path $RepositoryRoot 'apply.ps1'))) {
        if (Test-Path (Join-Path $CheckoutDir '.git')) {
            $RepositoryRoot = $CheckoutDir
        } elseif (Test-Path $CheckoutDir) {
            throw "$CheckoutDir already exists but is not a git checkout."
        } else {
            Write-Host "Cloning dotfiles into $CheckoutDir"
            git clone $RepositoryUrl $CheckoutDir
            if ($LASTEXITCODE -ne 0) {
                throw "git clone failed with exit code $LASTEXITCODE."
            }
            $RepositoryRoot = $CheckoutDir
        }
    }

    Push-Location $RepositoryRoot
    try {
        & (Join-Path $RepositoryRoot 'apply.ps1')
    } finally {
        Pop-Location
    }
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
