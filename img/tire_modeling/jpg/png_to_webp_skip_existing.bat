@echo off
setlocal

REM === Paths ===
set "INPUT_DIR=D:\Work folders\Website Files\pngs2convert"
set "OUTPUT_DIR=D:\Work folders\Website Files\WebP_images"

REM === Basic checks ===
echo INPUT : "%INPUT_DIR%"
echo OUTPUT: "%OUTPUT_DIR%"
echo.

if not exist "%INPUT_DIR%\" (
  echo ERROR: Input folder does not exist.
  pause
  exit /b 1
)

REM Check if ImageMagick is available
where magick >nul 2>nul
if errorlevel 1 (
  echo ERROR: ImageMagick not found in PATH.
  echo Install ImageMagick OR add it to PATH, then reopen Command Prompt.
  echo Quick test: open CMD and type: magick -version
  pause
  exit /b 1
)

REM Create output dir if needed
if not exist "%OUTPUT_DIR%\" mkdir "%OUTPUT_DIR%"

REM === Convert (skip existing) ===
set "FOUND_ANY=0"

for %%F in ("%INPUT_DIR%\*.png") do (
  set "FOUND_ANY=1"
  if exist "%OUTPUT_DIR%\%%~nF.webp" (
    echo Skipping  "%%~nxF"  ^(already exists^)
  ) else (
    echo Converting "%%~nxF"
    magick "%%F" -quality 82 "%OUTPUT_DIR%\%%~nF.webp"
  )
)

REM If no .png matched, tell you explicitly
if "%FOUND_ANY%"=="0" (
  echo No PNG files found in: "%INPUT_DIR%"
  echo Make sure the files end with .png and are in that exact folder.
)

echo.
echo Done.
pause
