<#
    The powershell script module for python3.
#>

$ModuleRootDir = Split-Path -Parent $PSScriptRoot
$ScriptsDir = Join-Path $ModuleRootDir 'scripts'
Get-ChildItem -Include '*.ps1' -Recurse $ScriptsDir | % { . $_.PSPath }

<#
    .Synopsis
    Initialize python3 environment for the current powershell session.
#>
function Python3-Activate {
    process {
        $PythonPath= [System.IO.Path]::Combine($env:LocalAppData, 'Programs\Python\Python36')
        $PythonUserPath= [System.IO.Path]::Combine($env:AppData, 'Python\Python36')

        $env:Path = Path-Prepend $env:Path (Join-Path $PythonPath 'Scripts')
        $env:Path = Path-Prepend $env:Path $PythonPath
        $env:Path = Path-Prepend $env:Path (Join-Path $PythonUserPath 'Scripts')
    }
}

Export-ModuleMember -Function Python3-Activate
