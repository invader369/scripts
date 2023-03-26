from bs4 import BeautifulSoup # pip install bs4
import re
import subprocess

filePath = input("Enter chapter xml location: ")
print()

if not ".xml" in filePath:
    filePath = filePath + ".xml"

with open(filePath, 'r', encoding='utf-8') as f:
    soup = BeautifulSoup(f.read(), 'html.parser')


chapters = soup.select('editionentry > chapteratom')
chapters_array = []


for chapter in chapters:
    time = re.search(r'(\d{2}):(\d{2}):(\d{2})', str(chapter))
    hrs = int(time.group(1))
    mins = int(time.group(2))
    secs = int(time.group(3))

    minutes = (hrs * 60) + mins
    seconds = secs + (minutes * 60)
    timestamp = (seconds * 1000)
    chap = {
        "title": re.sub(r'(=|;|#|\n)', r'\\\1', chapter.find('chapterstring').text),
        "startTime": timestamp
    }
    chapters_array.append(chap)

text = ";FFMETADATA1\n\n"

for i in range(len(chapters_array)-1):
    chap = chapters_array[i]
    title = chap['title']
    start = chap['startTime']
    end = chapters_array[i+1]['startTime']-1
    text += f"\n[CHAPTER]\nTIMEBASE=1/1000\nSTART={start}\nEND={end}\ntitle={title}\n"

text = text.strip()

with open("FFMETADATAFILE.txt", "a") as myfile:
    myfile.write(text)

inputFilePath = input("Name of input file (mp4): ")
if not ".mp4" in inputFilePath:
    inputFilePath = inputFilePath + ".mp4"

print("\nRunning the following command now: ") 

cmd = "ffmpeg -i \"{}\" -i FFMETADATAFILE.txt -map_metadata 1 -codec copy out.mp4".format(inputFilePath)
print (cmd)
print()
error = subprocess.call(cmd)
print()