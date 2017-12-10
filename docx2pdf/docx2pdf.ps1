function docx2pdf {
    <#
    .SYNOPSIS
        Convert from .docx to .pdf

    .DESCRIPTION
        Convert from .docx to .pdf

    .EXAMPLE
        docx2pdf input.pdf

    .EXAMPLE
        (Get-ChildItem *docx) | docx2pdf
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]
        $FileName
    )

    begin {
    }

    process {
        $FileDOCX = Convert-Path $FileName
        $FileDOCX_ext = (Get-ChildItem $FileDOCX).Extension

        if ($FileDOCX_ext -inotmatch ".docx") {
            Write-Host $FileDOCX ": You can convert .docx"
        }
        else {
            $FilePDF = $FileDOCX -ireplace ".docx", ".pdf"

            $word = NEW-OBJECT -COMOBJECT WORD.APPLICATION
            $doc = $word.Documents.OpenNoRepairDialog($FileDOCX)

            try {
                $doc.SaveAs([ref] $FilePDF, [ref] 17)
            }
            catch {
                Write-Host $FileDOCX ":" $_
            }

            $doc.Close()
            $word.Quit()
        }
    }

    end {
    }
}
