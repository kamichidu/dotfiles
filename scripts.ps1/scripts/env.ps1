<#
    .Synopsis
    Utilities for environment variable manipulation.
#>

function Path-ToList {
    [OutputType([System.Collections.ArrayList])]
    param (
        [string] $Path = ''
    )
    process {
        $eles = $Path.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
        return , [System.Collections.ArrayList] $eles
    }
}

function Path-Remove {
    [OutputType([string])]
    param (
        [string] $Path = '',
        [string] $Value = ''
    )
    process {
        $eles = Path-ToList $Path
        $eles.Remove($Value)
        return $eles -join ';'
    }
}

function Path-Append {
    [OutputType([string])]
    param (
        [string] $Path = '',
        [string] $Value = ''
    )
    process {
        $Path = Path-Remove $Path $Value
        $eles = Path-ToList $Path
        $eles.Add($Value)
        return $eles -join ';'
    }
}

function Path-Prepend {
    [OutputType([string])]
    param (
        [string] $Path = '',
        [string] $Value = ''
    )
    process {
        $Path = Path-Remove $Path $Value
        $eles = Path-ToList $Path
        $eles.Insert(0, $Value)
        return $eles -join ';'
    }
}
