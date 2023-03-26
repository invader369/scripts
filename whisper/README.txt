Translate JP Audio into English
## ======================================================================
## Step 0: Convert Audio to WAV
## ======================================================================












## ======================================================================
## Step 1a: Whisper Py (uses gpu, currently faster)
## ======================================================================

    Available Models (mainly use only base and medium)
    Size 	par 	en-only     multi 	VRAM 	Relative speed
    tiny 	39 M 	tiny.en 	tiny 	~1 GB 	~32x
    base 	74 M 	base.en 	base 	~1 GB 	~16x
    small 	244 M 	small.en 	small 	~2 GB 	~6x
    medium 	769 M 	medium.en 	medium 	~5 GB 	~2x
    large 	1550 M 	N/A     	large 	~10 GB 	1x

    Original/GPU capabilities
    https://github.com/openai/whisper

    Install python 3.8+ 64-bit
    Install PyTorch


    # Usage: Single file
        whisper --model medium input.wav --language ja --device cuda --task translate

    # Usage: Batch
        <script-working-dir>/input
        Make sure wav files are in the input folder

        Run bat or ps1 file, 
        translate-batch-whisper-py.bat
        translate-batch-whisper-py.ps1

## ======================================================================
## Step 1b: Whisper C++ (currently this is slower)
## ======================================================================
    Alternate (C++)
    https://github.com/ggerganov/whisper.cpp
    Download models
    Build or download windows exe

    # Usage: Single file
        ./main -m ./models/ggml-medium.bin -l ja -f './input/<file>.wav' -t 8 --output-srt --output-txt --translate

    # Usage: Batch
        ./translate-batch.sh "./input/RJ320175/troubleshooting/original_full_bad/*.wav"
    





## ======================================================================
## Step 2: Converting the mp3 into mp4
## ======================================================================
    ./ffmpeg.exe -loop 1 -i art.png -i art.mp3 -c:v libx264 -tune stillimage -vf scale=iw/5:ih/5 -c:a copy -shortest out.mp4 -y





## ======================================================================
## Step 3: Use mkvtoolnix-gui to add subtitles to the output mp4
## ======================================================================




split 5
001 0-4:59min
002 5-9:59min
003 10

for file split-n
subs: start=(n-1)*5 end=(n*2)-1sec

