Translate JP Audio into English
## Step 0: Convert Audio to WAV
    format-files-to-wav.bat

## Step 1: Use whisper Py to translate files (uses gpu, currently faster)
    translate-batch-whisper-py.bat

## Step 2: Converting the mp3 into mp4
    audio-to-mp4-still-image