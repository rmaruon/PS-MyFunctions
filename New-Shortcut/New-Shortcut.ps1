function New-Shortcut {
    <#
    .SYNOPSIS
        Create shortcut (.lnk)

    .DESCRIPTION
        -Target <dir|file>
            shortcut target

        [-SavePath <dir>]
            the directory where the shortcut is saved

    .EXAMPLE
        New-Shortcut $env:USERPROFILE

    .EXAMPLE
        New-Shortcut $env:USERPROFILE -SavePath .\subdir

    .EXAMPLE
        (Get-ChildItem ../).fullname | New-Shortcut

    .EXAMPLE
        (Get-ChildItem ../).fullname | New-Shortcut -SavePath .\subdir

    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]$Target,
        [string]$SavePath = "./"
    )

    begin {
    }

    process {
        try {
            $TargetPath = Convert-Path $Target
            $SavePath = Convert-Path $SavePath

            $TargetBaseName = Split-Path $TargetPath -Leaf
            $LinkName = $TargetBaseName + ".lnk"
            $LinkPath = Join-Path (Convert-Path $SavePath) $LinkName

            $WshShell = New-Object -ComObject WScript.Shell
            $ShortCut = $WshShell.CreateShortcut($LinkPath)
            $Shortcut.TargetPath = $TargetPath
            $Shortcut.Save()
        }
        catch {
            Write-Host $_
        }
    }

    end {
    }
}
