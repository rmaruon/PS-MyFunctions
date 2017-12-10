## Setting

`tree`
```
$env:USERPROFILE\Documents\WindowsPowerShell
│  Microsoft.PowerShell_profile.ps1
└─PS-MyFunctions
```

`Microsoft.PowerShell_profile.ps1`
```powershell
$Path_MyFunctions = Join-Path $PSScriptRoot "PS-MyFunctions"
Get-ChildItem $Path_MyFunctions -Include "*.ps1" -Recurse | % {. $_.PSPath}
```

