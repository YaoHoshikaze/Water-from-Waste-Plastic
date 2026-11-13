param([ValidateSet('Private','Friends','Public')][string]$Visibility='Private')
$ErrorActionPreference='Stop'
$releaseRoot=$PSScriptRoot
$content=(Resolve-Path -LiteralPath (Join-Path $releaseRoot 'content')).Path
$preview=(Resolve-Path -LiteralPath (Join-Path $releaseRoot 'preview.png')).Path
$vdf=Join-Path $releaseRoot 'workshop.vdf'
$publishedId='0'
if(Test-Path -LiteralPath $vdf){
 $previous=Get-Content -LiteralPath $vdf -Raw
 $idMatch=[regex]::Match($previous,'"publishedfileid"\s+"(\d+)"')
 if($idMatch.Success){$publishedId=$idMatch.Groups[1].Value}
}
$visibilityValue=@{Private='2';Friends='1';Public='0'}[$Visibility]
function Quote-Vdf([string]$value){'"'+$value.Replace('\','\\').Replace('"','\"')+'"'}
$values=[ordered]@{
 appid='4348910'
 publishedfileid=$publishedId
 contentfolder=$content
 previewfile=$preview
 visibility=$visibilityValue
 title=(Get-Content -LiteralPath (Join-Path $releaseRoot 'workshop-title.txt') -Raw).Trim()
 description=(Get-Content -LiteralPath (Join-Path $releaseRoot 'workshop-description.txt') -Raw).Trim()
 changenote=(Get-Content -LiteralPath (Join-Path $releaseRoot 'workshop-changenote.txt') -Raw).Trim()
}
$lines=[System.Collections.Generic.List[string]]::new()
$lines.Add('"workshopitem"');$lines.Add('{')
foreach($pair in $values.GetEnumerator()){$lines.Add('    '+(Quote-Vdf $pair.Key)+' '+(Quote-Vdf $pair.Value))}
$lines.Add('}')
[System.IO.File]::WriteAllText($vdf,($lines -join "`n")+"`n",[System.Text.UTF8Encoding]::new($false))
Write-Output "Prepared $Visibility Workshop configuration; publishedfileid=$publishedId"
