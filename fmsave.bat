@echo off
setlocal

set SAVE_DIR=%LOCALAPPDATA%\Sports Interactive\Football Manager 26 Console\Temporary
set SAVE_NAME=*.fmt
set SAVE=%SAVE_DIR%\%SAVE_NAME%
set CURR_DIR=%cd%
set CSV_FILE=%CURR_DIR%\fmsave_columns.csv

py -m pip install --upgrade fmsave -q --no-warn-script-location

pushd .
cd %SAVE_DIR%

echo "Save file: %SAVE%"

IF EXIST "%CSV_FILE% del /F "%CSV_FILE%"

C:\Users\%USERNAME%\AppData\Local\Python\pythoncore-3.14-64\Scripts\fmsave ^
  export "%SAVE%" ^
  players ^
  --managed-club ^
  --columns name,common_name,age,natural_positions,^
attributes_crossing,attributes_dribbling,attributes_finishing,^
attributes_first_touch,attributes_heading,attributes_long_shots,attributes_marking,^
attributes_passing,attributes_tackling,attributes_technique,^
attributes_corners,attributes_free_kick_taking,attributes_long_throws,attributes_penalty_taking,^
attributes_aggression,attributes_anticipation,attributes_bravery,attributes_composure,^
attributes_concentration,attributes_decisions,attributes_determination,^
attributes_flair,attributes_leadership,attributes_off_the_ball,attributes_positioning,^
attributes_teamwork,attributes_vision,attributes_work_rate,^
attributes_acceleration,attributes_agility,attributes_balance,attributes_jumping_reach,^
attributes_natural_fitness,attributes_pace,attributes_stamina,attributes_strength,^
attributes_aerial_reach,attributes_command_of_area,attributes_communication,attributes_eccentricity,^
attributes_handling,attributes_kicking,attributes_one_on_ones,attributes_punching,attributes_reflexes,^
attributes_rushing_out,attributes_throwing^
  -o "%CSV_FILE%"

popd
