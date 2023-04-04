function runOnTheseFiles($files) {
    if ($files.count -eq 0) {
        return $false
    }

    foreach ($file in $files) {
        Write-Host "$file"
    }
    $shouldRun = Read-Host "`nRun on these files? (y/n)"
    return $shouldRun.ToLower() -eq "y"
}



# Requires whisper to be installed (it's a python software)
# source: https://github.com/openai/whisper

Write-Host "Translating from Japanese [ja] to English [en]"

# set path
$loc = Read-Host "Enter path to wav files"

# default to script location
if ($loc.Length -eq 0) {
    Write-Host "Defaulting to script location"
    Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot
    $loc = Get-Location
    $loc = "$loc/input"
}

Write-Host "Working directory: $loc"
Write-Host "Searching for split .wav files"

$files = Get-ChildItem $loc -filter *-*.wav
$runOnTheseFiles = runOnTheseFiles($files)

if ($files.count -eq 0 -or !$runOnTheseFiles) {
    Write-Host "Split files not found`n"
    Write-Host "Searching for all wav files (*.wav)"
    $files = Get-ChildItem $loc -filter *.wav
    $runOnTheseFiles = runOnTheseFiles($files)

}

if ($runOnTheseFiles) {
    foreach ($file in $files) {
        $filepath = "$loc/$file"
        Write-Host ""
        Write-Host "translating: $filepath"
        whisper --model medium $filepath --language ja --device cuda --task translate --output_dir $loc --output_format srt
        Write-Host "------------------------"
    }
    
}