function Send-LINENotify {
    <#
    .SYNOPSIS
        Send a notification to LINE via LINE Notify API.

    .DESCRIPTION

    .EXAMPLE
        Send-LINENotify hello

    .EXAMPLE
        1..10 | Send-LINENotify
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Message
    )

    begin {
        $uri = "https://notify-api.line.me/api/notify"
        $config = (Get-Content (Join-Path $PSScriptRoot "config.json") | ConvertFrom-Json)[0]
        $token = $config.token

        $header = @{Authorization = $token}
    }

    process {
        $body = @{message = $Message}

        try {
            Invoke-RestMethod -Uri $uri -Method Post -Headers $header -Body $body
        }
        catch {
            Write-Host $_
        }

    }

    end {
    }
}
