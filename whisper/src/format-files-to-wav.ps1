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


# set file extension
do {
    $fileExtension = Read-Host "Input extension (ex: mp3, mp4, etc)"
    Write-Host "Using file extension: $fileExtension"
    $files = Get-ChildItem $loc -filter "*.$fileExtension"
    Write-Host "Files found: " $files.count
}
while($fileExtension.Length -eq 0 -or $files.Length -eq 0)

$continue = Read-Host "Continue? (Y/N)"


# try to convert to 16-bit wav file using ffmpeg
if ($continue.ToLower() -eq "y") {
    foreach ($file in $files) {
      $outFile = $file.BaseName + ".wav"
      $inputFilePath = $loc + "\" + $file
      $outputFilePath = $loc + "\" + $outFile
  
      Write-Debug "Full input path: $inputFilePath"
      Write-Debug "Full output path: $outputFilePath"
      Write-Host ""
      Write-Host "Converting: $file | $outfile"
      ../ffmpeg.exe -loglevel quiet -stats -i $inputFilePath -ar 16000 -ac 1 -c:a pcm_s16le $outputFilePath -y
    }
}

Write-Host "Exiting"
