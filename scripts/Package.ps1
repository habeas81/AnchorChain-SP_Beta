<#
.SYNOPSIS
    Builds Release and assembles the two distributables under dist\:
      dist\AnchorChain_Beta\            Workshop content (AnchorChain.dll + workshop\* files)
      dist\ACPreloader-2.0.0.zip        Manual install: extract into the Sea Power folder (BepInEx\plugins\AnchorChain.Preloader.dll)
#>
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

dotnet build AnchorChain.sln -c Release --nologo -v q
if ($LASTEXITCODE -ne 0) { throw "Build failed." }

$Dist = Join-Path $Root "dist"
$Content = Join-Path $Dist "AnchorChain_Beta"
Remove-Item $Dist -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory $Content -Force | Out-Null
Copy-Item "AnchorChain\bin\Release\netstandard2.1\AnchorChain.dll" $Content
Copy-Item "workshop\*" $Content -Recurse

$Stage = Join-Path $Dist "stage\BepInEx\plugins"
New-Item -ItemType Directory $Stage -Force | Out-Null
Copy-Item "AnchorChain.Preloader\bin\Release\netstandard2.1\AnchorChain.Preloader.dll" $Stage
Compress-Archive -Path (Join-Path $Dist "stage\BepInEx") -DestinationPath (Join-Path $Dist "ACPreloader-2.0.0.zip")
Remove-Item (Join-Path $Dist "stage") -Recurse -Force
Get-ChildItem $Dist -Recurse -File | Select-Object FullName, Length

New-Item -ItemType Directory (Join-Path $Root 'preloader') -Force | Out-Null
Copy-Item (Join-Path $Dist 'ACPreloader-2.0.0.zip') (Join-Path $Root 'preloader') -Force
