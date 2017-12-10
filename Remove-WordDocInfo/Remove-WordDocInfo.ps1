function Remove-WordDocInfo {
    <#
    .SYNOPSIS
        Delete all document informations of Word file(.doc, .docx).

    .DESCRIPTION

    .EXAMPLE
        Remove-WordDocInfo input.docx

    .EXAMPLE
        (Get-ChildItem *docx) | Remove-WordDocInfo
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]
        $FileName
    )

    begin {
        Add-Type -AssemblyName Microsoft.Office.Interop.Word
        $WdRemoveDocType = "Microsoft.Office.Interop.Word.WdRemoveDocInfoType" -as [type]
    }

    process {
        $FileWORD = Convert-Path $FileName
        $FileWORD_ext = (Get-ChildItem $FileWORD).Extension

        if ($FileWORD_ext -inotmatch "\.doc[x]?$") {
            Write-Host $FileWORD ": You can remove document informations of .doc or .docx"
        }
        else {
            $word = New-Object -ComObject WORD.APPLICATION
            $word.visible = $false

            $documents = $word.Documents.Open($FileWORD)
            $documents.RemoveDocumentInformation($WdRemoveDocType::wdRDIAll)
            $documents.Save()

            $word.Quit()
        }
    }

    end {
    }
}
