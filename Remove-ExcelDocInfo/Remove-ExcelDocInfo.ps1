function Remove-ExcelDocInfo {
    <#
    .SYNOPSIS
        Delete all document informations of Excel file(.xls, .xlsm, .xlsx).

    .DESCRIPTION

    .EXAMPLE
        Remove-ExcelDocInfo

    .EXAMPLE
        (Get-ChildItem *xlsx) | Remove-ExcelDocInfo
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]
        $FileName
    )

    begin {
        Add-Type -AssemblyName Microsoft.Office.Interop.Excel
        $xlRemoveDocType = "Microsoft.Office.Interop.Excel.XlRemoveDocInfoType" -as [type]
    }

    process {
        $FileEXCEL = Convert-Path $FileName
        $FileEXCEL_ext = (Get-ChildItem $FileEXCEL).Extension

        if ($FileEXCEL_ext -inotmatch "\.xls[mx]?$") {
            Write-Host $FileEXCEL ": You can remove document informations of .xls, .xlsm or .xlsx"
        }
        else {
            $excel = New-Object -COMOBJECT EXCEL.APPLICATION
            $excel.visible = $false

            $workbook = $excel.workbooks.open($FileEXCEL)
            $workbook.RemoveDocumentInformation($xlRemoveDocType::xlRDIAll)
            $workbook.Save()

            $excel.Workbooks.close()
            $excel.Quit()
        }
    }

    end {
    }
}
