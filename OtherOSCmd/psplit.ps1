function psplit {
    <#
    .SYNOPSIS
        Split a file into pieces

    .DESCRIPTION
        Only UTF-8 is supported.

        -Line
            Create smaller files n lines in length.
            The default is 1000 lines.

    .EXAMPLE
        split -Line 10 test.txt
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [int]$Line = 1000
    )

    begin {
    }

    process {
        $LineCount = (Get-Content (Convert-Path $FileName)).Length

        if ($LineCount -gt $Line) {
            $Path = (Get-ChildItem $FileName).DirectoryName
            $Base = (Get-ChildItem $FileName).BaseName

            $PathBase = Join-Path $Path $Base
            $Ext = (Get-ChildItem $FileName).Extension

            $i = 1
            Get-Content $FileName -Encoding UTF8 -ReadCount $Line | ForEach-Object {
                $_ | Set-Content -Encoding UTF8 "${PathBase}_${i}${Ext}";
                $i++
            }
        }

    }

    end {
    }
}
