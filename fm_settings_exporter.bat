@echo off
:: (c) Sports Interactive Ltd.
:: Small modifications by John McParland for Football Manager 26 Console.
setlocal

set "GameVersion=Football Manager 26 Console"
set "TempPath=%TEMP%\FM_SettingsBackup"
set "DestPath=%USERPROFILE%\Documents\Sports Interactive\%GameVersion%\crash dumps"
set "ZipPath=%DestPath%\FM_SettingsBackup.zip"

echo Please wait while we collect your settings and preferences...

if exist "%TempPath%" rmdir /S /Q "%TempPath%"
if exist "%TempPath%" (
    echo ERROR: Could not clear temporary directory "%TempPath%".
    exit /b 1
)
mkdir "%TempPath%" || exit /b 1

echo Getting registry settings...
reg export "HKEY_CURRENT_USER\Software\Sports Interactive\%GameVersion%" "%TempPath%\FM_regSettings.reg" /Y
if errorlevel 1 echo WARNING: Registry settings could not be exported.

echo Getting preferences and crash dumps...
if exist "%LOCALAPPDATA%\Sports Interactive\%GameVersion%\" (
    xcopy "%LOCALAPPDATA%\Sports Interactive\%GameVersion%" "%TempPath%\%GameVersion%_Local\" /E /I /Y
    if errorlevel 1 echo WARNING: Some Local files may not have been copied.
) else echo WARNING: Local preferences directory not found.

if exist "%LOCALAPPDATA%Low\Sports Interactive\%GameVersion%\" (
    xcopy "%LOCALAPPDATA%Low\Sports Interactive\%GameVersion%" "%TempPath%\%GameVersion%_LocalLow\" /E /I /Y
    if errorlevel 1 echo WARNING: Some LocalLow files may not have been copied.
) else echo WARNING: LocalLow preferences directory not found.

if not exist "%DestPath%" mkdir "%DestPath%"
if not exist "%DestPath%\" (
    echo ERROR: Could not create destination directory "%DestPath%".
    exit /b 1
)

echo Zipping up your files...
powershell -NoProfile -Command "Compress-Archive -LiteralPath '%TempPath%\*' -DestinationPath '%ZipPath%' -Force"
if errorlevel 1 (
    echo ERROR: Failed to create backup ZIP.
    exit /b 1
)

echo Backup completed successfully!
echo Saved to: "%ZipPath%"
start "" "%DestPath%"
endlocal
