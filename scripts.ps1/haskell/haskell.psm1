<#
    The powershell script module for haskell.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

$StackRoot = 'C:\haskell'
$BaseDir = Join-Path $env:AppData 'haskell'

<#
    .Synopsis
    Initialize haskell environment for the current powershell session.
#>
function Haskell-Activate {
    param ()
    process {
        $HaskellBinDir = Join-Path $BaseDir 'bin'
        # remove unnecessary paths
        $env:Path = Path-Remove $env:Path $HaskellBinDir

        $env:Path = Path-Prepend $env:Path $HaskellBinDir
        $env:STACK_ROOT = $StackRoot
    }
}

Export-ModuleMember -Function Haskell-*
