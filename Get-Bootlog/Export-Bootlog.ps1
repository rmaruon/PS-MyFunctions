function Export-Bootlog {
    <#
    .SYNOPSIS
        Export Boot log

    .EXAMPLE
        Export-Bootlog -FilePath event.csv

    .EXAMPLE
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    begin {
        . Join-Path $PSScriptRoot "Get-Bootlog.ps1"
    }

    process {
        Get-Bootlog | Export-Csv $FilePath -Encoding UTF8 -NoTypeInformation
    }

    end {
    }
}
