# Requires an input folder in the same directory as
# this script. The input folder must contain the 
# files you want to translate

Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot
$loc = Get-Location
$loc = "$loc/input"

Write-Host "Working directory: $loc"

Write-Host "Searching for split .wav files"

$files = Get-ChildItem $loc -filter *-0*.wav

if ($files.Length -eq 0) {
    Write-Host "No files match criteria`n"
    $response = Read-Host "Check for all .wav files? y/n"
    if ($response -eq "y") {
        Write-Host "Searching for *.wav"
        $files = Get-ChildItem $loc -filter *.wav
    }
}


foreach ($file in $files) {
    $filepath = "$loc/$file"
    Write-Host ""
    Write-Host "transcribe: $filepath"
    whisper --model medium $filepath --language ja --device cuda --output_dir $loc --output_format srt
}