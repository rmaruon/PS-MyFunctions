function Get-Bootlog {
    <#
    .SYNOPSIS
        Get Boot log

    .EXAMPLE
        Get-Bootlog

    .EXAMPLE
        Get-Bootlog | Export-Csv event.csv -Encoding UTF8 -NoTypeInformation

    .EXAMPLE
        Get-Bootlog | ? {$_.Date -GE "2017/11/01" -and  $_.Date -LE "2017/11/30"} | Export-Csv event.csv -Encoding UTF8 -NoTypeInformation
    #>
    [CmdletBinding()]
    param(
    )

    begin {
    }

    process {
        Get-WinEvent System -filterxpath "*[System[Provider[@Name='Microsoft-Windows-Kernel-General'] and (EventID='12' or EventID='13')]]" |
            Select-Object TimeCreated, Id, Message |
            Sort-Object {$_.TimeCreated} |
            ForEach-Object {$_.TimeCreated.ToShortDateString() + "," +
            $_.TimeCreated.ToLongTimeString() + "," +
            $_.Id + "," +
            @("Boot", "Shutdown")[$_.Id -eq 13]
        } |
            ConvertFrom-Csv -Header @("Date", "Time", "ID", "Message")
    }

    end {
    }
}
