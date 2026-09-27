@echo off
:: (c) Sports Interactive Ltd.

:: Set game version variable
set "GameVersion=Football Manager 26"

:: Set temp folder path
set "TempPath=%TEMP%\FM_SettingsBackup"
echo Please wait while we collect your settings and preferences....
if exist "%TempPath%" (
    rmdir /S /Q "%TempPath%" >nul 2>&1
)
mkdir "%TempPath%" >nul 2>&1
:: Export registry settings
echo Getting settings... 
reg export "HKEY_CURRENT_USER\Software\Sports Interactive\%GameVersion%" "%TempPath%\FM_regSettings.reg" /Y >nul 2>&1

:: Copy preferences folder
echo Getting preferences...
xcopy "%USERPROFILE%\AppData\Local\Sports Interactive\%GameVersion%" "%TempPath%\%GameVersion%_Local" /E /I /Y >nul 2>&1
xcopy "%USERPROFILE%\AppData\LocalLow\Sports Interactive\%GameVersion%" "%TempPath%\%GameVersion%_LocalLow" /E /I /Y >nul 2>&1

:: Ensure destination folder exists
set "DestPath=%USERPROFILE%\Documents\Sports Interactive\%GameVersion%\crash dumps"
if not exist "%DestPath%" (
    mkdir "%DestPath%" >nul 2>&1
)

:: Compress to ZIP using PowerShell
echo Zipping up your files...
powershell -Command "Compress-Archive -Path '%TempPath%\*' -DestinationPath '%DestPath%\FM_SettingsBackup.zip' -Force" >nul 2>&1

echo ✅ Backup completed successfully!
echo 📁 Saved to: %DestPath%\FM_SettingsBackup.zip
start "" "%DestPath%"