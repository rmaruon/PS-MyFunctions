function xlsx2pdf {
    <#
    .SYNOPSIS
        Convert from .xlsx to .pdf
    .DESCRIPTION
        Convert from .xlsx to .pdf
    .EXAMPLE
        xlsx2pdf input.xlsx
    .EXAMPLE
        (Get-ChildItem *xlsx) | xlsx2pdf
    #>
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string[]]$FileName
        )

    begin {
        $xlFixedFormat = "Microsoft.Office.Interop.Excel.xlFixedFormatType" -as [type]

        $objExcel = New-Object -ComObject Excel.Application
        $objExcel.Visible = $False
    }

    process {
        $FileXLSX = Convert-Path $FileName
        $FileXLSX_ext = (Get-ChildItem $FileXLSX).Extension

        if ($FileXLSX_ext -inotmatch ".xlsx") {
            Write-Host $FileXLSX ": You can convert .xlsx"
        }
        else {
            $workbook = $objExcel.workbooks.Open($FileXLSX, 3)
            $workbook.Saved = $True

            $FilePDF = [IO.Path]::ChangeExtension($FileXLSX, ".pdf")

            try {
                $workbook.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $FilePDF)
            }
            catch {
                Write-Host $FileXLSX ":" $_
            }
        }
    }

    end {
        $objExcel.Workbooks.Close()
        [void]$objExcel.Quit
    }
}
