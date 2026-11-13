$ErrorActionPreference='Stop'
$content=Join-Path $PSScriptRoot 'content'
[xml]$manifest=Get-Content -LiteralPath (Join-Path $content 'manifest.xml') -Raw
if($manifest.Manifest.ID -ne 'plastic_water_chemistry'){throw 'Unexpected mod ID.'}
if($manifest.Manifest.ModVersion -ne '0.7.1'){throw 'Unexpected release version.'}
if(@($manifest.Manifest.Assemblies.Assembly).Count -ne 1 -or $manifest.Manifest.Assemblies.Assembly -ne 'ChemistryPrototype.dll'){throw 'Unexpected assembly list.'}
$all=Get-ChildItem -LiteralPath $content -File -Recurse
$dlls=@($all | Where-Object Extension -eq '.dll')
if($dlls.Count -ne 1 -or $dlls[0].Name -ne 'ChemistryPrototype.dll'){throw 'Only the mod assembly may be uploaded.'}
$forbidden=@($all | Where-Object { $_.Extension -in '.cs','.csproj','.pdb','.zip','.vdf','.exe' -or $_.Name -in 'dev.txt','run-smoke-tests.txt','Player.log' })
if($forbidden.Count){throw 'Development files found in Workshop content.'}
$preview=Get-Item -LiteralPath (Join-Path $PSScriptRoot 'preview.png')
if($preview.Length -ge 1MB){throw 'Preview must be under 1MB.'}
Add-Type -AssemblyName System.Drawing
$image=[System.Drawing.Bitmap]::new($preview.FullName)
try{if($image.Width -ne 1024 -or $image.Height -ne 1024){throw 'Expected 1024x1024 preview.'}}finally{$image.Dispose()}
if(!(Test-Path -LiteralPath (Join-Path $content 'preview.png'))){throw 'Offline preview is missing.'}
if($all.Count -lt 10){throw 'Runtime assets are missing.'}
$sums=Join-Path $PSScriptRoot 'SHA256SUMS.txt'
if(Test-Path -LiteralPath $sums){
 $base=[IO.Path]::GetFullPath($content)+[IO.Path]::DirectorySeparatorChar
 foreach($line in Get-Content -LiteralPath $sums){
  $match=[regex]::Match($line,'^([A-Fa-f0-9]{64})  (.+)$')
  if(!$match.Success){throw 'Invalid SHA256SUMS entry.'}
  $target=[IO.Path]::GetFullPath((Join-Path $content $match.Groups[2].Value))
  if(!$target.StartsWith($base,[StringComparison]::OrdinalIgnoreCase)){throw 'Checksum path is outside Workshop content.'}
  if((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $match.Groups[1].Value){throw ('Content changed: '+$match.Groups[2].Value)}
 }
}
Write-Output "PASS: Workshop root, manifest, single mod DLL, runtime assets, clean content and 1024x1024 preview ($($preview.Length) bytes)."
