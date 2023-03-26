# check for ffmpeg 
$ffmpeg = Test-Path ../ffmpeg.exe
if (!$ffmpeg) {
    Write-Host "Missing ffmpeg.exe"
    Write-Host "Copy ffmpeg.exe into relative path ../ffmpeg.exe"
    exit
}

# set path
$loc = Read-Host "Enter path to files"

# default to script location
if ($loc.Length -eq 0) {
    Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot
    $loc = Get-Location
}
Write-Host "Working directory: $loc"


# attempt to create mp4 files
# using still image for all mp3 files in the directory
$files = Get-ChildItem $loc -filter *.mp3
foreach ($file in $files) {
  $outfile = $file.BaseName + ".mp4"
  Write-Host "$file | $outfile"
}

$shouldRun = Read-Host "`nRun on these files? (y/n)"

if ($shouldRun.ToLower() -ne "y") {
    exit
}

$artFile = $loc+"/art.png"
$hasArt = Test-Path $artFile
if (!$hasArt) {
    Write-Host "Missing $artFile"
    exit
}

Write-Host "Enter number to scale image proportionally"
Write-Host "Example: "
Write-Host "1. 1/1 - no change"
Write-Host "2. 1/2 - half size"
Write-Host "3. 1/3 - third size"
Write-Host "4. 1/4 - quarter size"

$scaleNum = Read-Host ">"
$scale = "scale=iw/$scaleNum" + ":ih/$scaleNum"

foreach ($file in $files) {
  $outfile = $file.BaseName + ".mp4"

  $inputFilePath = $loc + "\" + $file
  $outFilePath = $loc + "\" + $outfile
  Write-Debug "$inputFilePath | $outFilePath"
  Write-Host "Creating mp4 from mp3 and image: $file >> $outfile"
  ../ffmpeg.exe -loglevel info -loop 1 -i $artFile -i $inputFilePath -c:v libx264 -tune stillimage -vf $scale -c:a copy -shortest $outFilePath -y
}

