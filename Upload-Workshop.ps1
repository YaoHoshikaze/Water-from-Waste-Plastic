param(
 [Parameter(Mandatory=$true)][string]$SteamCmdPath,
 [string]$SteamUser,
 [ValidateSet('Private','Friends','Public')][string]$Visibility='Private'
)
$ErrorActionPreference='Stop'
if(!(Test-Path -LiteralPath $SteamCmdPath -PathType Leaf)){throw 'SteamCmdPath must point to your steamcmd.exe.'}
$steamCmd=(Resolve-Path -LiteralPath $SteamCmdPath).Path
if([IO.Path]::GetFileName($steamCmd) -ine 'steamcmd.exe'){throw 'Select steamcmd.exe.'}
& (Join-Path $PSScriptRoot 'Validate-Package.ps1')
& (Join-Path $PSScriptRoot 'Prepare-Workshop.ps1') -Visibility $Visibility
if([string]::IsNullOrWhiteSpace($SteamUser)){$SteamUser=Read-Host 'Steam account name'}
if([string]::IsNullOrWhiteSpace($SteamUser)){throw 'Steam account name is required.'}
Write-Host "SteamCMD will upload with visibility: $Visibility"
Write-Host 'Enter your password and Steam Guard code only in SteamCMD when prompted. They are not written to these files.'
$steamArguments=@('+login',$SteamUser,'+workshop_build_item',(Join-Path $PSScriptRoot 'workshop.vdf'),'+quit')
& $steamCmd @steamArguments
if($LASTEXITCODE -ne 0){throw "SteamCMD exited with code $LASTEXITCODE. Review its output before retrying."}
$vdf=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'workshop.vdf') -Raw
$idMatch=[regex]::Match($vdf,'"publishedfileid"\s+"([1-9]\d*)"')
if(!$idMatch.Success){throw 'No Workshop ID was written. Do not assume the upload succeeded; review SteamCMD output.'}
Write-Host ('Check the Workshop result: https://steamcommunity.com/sharedfiles/filedetails/?id='+$idMatch.Groups[1].Value)
Write-Host 'Keep workshop.vdf. Its publishedfileid is required to update this item rather than create a duplicate.'
