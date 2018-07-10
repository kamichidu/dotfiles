<#
    .Synopsis
    Apply dotfiles into current host system.
#>
param (
    [string] $TargetDir = $env:USERPROFILE
)
try {
    $Files = @(
        @{Src='vimrc';         Dest=[System.IO.Path]::Combine($TargetDir, '_vimrc')},
        @{Src='gvimrc';        Dest=[System.IO.Path]::Combine($TargetDir, '_gvimrc')},
        @{Src='vimfiles';      Dest=[System.IO.Path]::Combine($TargetDir, 'vimfiles')},
        @{Src='bundles';       Dest=[System.IO.Path]::Combine($TargetDir, '.hariti', 'bundles')}
    )

    Write-Host "Applying to $TargetDir"
    if (-not (Test-Path $TargetDir)) {
        Write-Host "make directory $TargetDir"
        New-Item -Type Directory -Force $TargetDir >$null
    }

    foreach ($File in $Files) {
        if (Test-Path $File.Dest) {
            Write-Host "[Skip] $($File.Src) ===> $($File.Dest)"
            continue
        }
        # mkdirs for parent dir
        $DestParentDir = Split-Path -Parent $File.Dest
        $DestBaseName = Split-Path -Leaf $File.Dest
        if (-not (Test-Path $DestParentDir)) {
            Write-Host "make directory $DestParentDir"
            New-Item -Type Directory -Force $DestParentDir >$null
        }
        if ((Get-Item $File.Src) -is [System.IO.DirectoryInfo]) {
            Write-Host "[Junction] $($File.Src) ===> $($File.Dest)"
            New-Item -Type Junction -Path $DestParentDir -Name $DestBaseName -Value $File.Src >$null
        } else {
            Write-Host "[HardLink] $($File.Src) ===> $($File.Dest)"
            New-Item -Type HardLink -Path $DestParentDir -Name $DestBaseName -Value $File.Src >$null
        }
    }
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
