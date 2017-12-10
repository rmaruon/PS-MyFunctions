function psay {
    <#
    .SYNOPSIS
        Convert text to audible speech

    .DESCRIPTION
        -Lang
            Select language of speech synthesis engine.

            Supproted Languages.
              en | English  | Microsoft Zira Desktop
              ja | Japanese | Microsoft Haruka Desktop

              The default is 'en'.

    .EXAMPLE
        speech "Hello"

    .EXAMPLE
        speech "Hello" -Lang en

    .EXAMPLE
        speech "こんにちは" -Lang ja

    .EXAMPLE
        Get-ChildItem hello.txt | speech

    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$String="",
        [ValidateSet("en", "ja")]$Lang = "en"
    )

    begin {
        $voice = @{
            "en" = "Microsoft Zira Desktop";
            "ja" = "Microsoft Haruka Desktop";
        }

        Add-Type -AssemblyName System.speech
        $speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
        $speaker.SelectVoice($voice[$Lang])
    }

    process {
        $speaker.Speak($String)
    }

    end {
    }
}
