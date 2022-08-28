@REM Requires 7z.exe to be installed, will fail otherwise

@REM For every folder in the current directory, create a zip file with the same name
@REM Does not delete the orignal files
for /d %%X in (*) do "c:\Program Files\7-Zip\7z.exe" a "%%X.zip" "%%X\"