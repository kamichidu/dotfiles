<#
    The powershell script module for python2.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

<#
    .Synopsis
    Initialize python2 environment for the current powershell session.
#>
function Python2-Activate {
    process {
        $PythonPath= 'C:\system-apps\python\2.7'
        $PythonUserPath= [System.IO.Path]::Combine($env:AppData, 'Python')

        $env:Path = Path-Prepend $env:Path (Join-Path $PythonPath 'Scripts')
        $env:Path = Path-Prepend $env:Path $PythonPath
        $env:Path = Path-Prepend $env:Path (Join-Path $PythonUserPath 'Scripts')
    }
}

Export-ModuleMember -Function Python2-Activate
