@echo off
setlocal

set "SAVE_DIR=%LOCALAPPDATA%\Sports Interactive\Football Manager 26 Console\Temporary"
set "SAVE=%SAVE_DIR%\*.fmt"
set "ATTRIBUTES_CSV_FILE=%CD%\fmsave_attributes.csv"
set "STATS_CSV_FILE=%CD%\fmsave_stats.csv"

if not exist "%SAVE_DIR%\" (
    echo ERROR: Save directory not found: "%SAVE_DIR%"
    exit /b 1
)

where py >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python launcher 'py' was not found.
    exit /b 1
)

py -m pip install --upgrade fmsave -q --no-warn-script-location
if errorlevel 1 (
    echo ERROR: Could not install or upgrade fmsave.
    exit /b 1
)

if exist "%ATTRIBUTES_CSV_FILE%" del /F "%ATTRIBUTES_CSV_FILE%"
if exist "%STATS_CSV_FILE%" del /F "%STATS_CSV_FILE%"
pushd "%SAVE_DIR%" || exit /b 1

echo
echo Save file: %SAVE%
echo

echo "Exporting Attributes"
py -m fmsave export "%SAVE%" players --managed-club ^
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
attributes_rushing_out,attributes_throwing ^
  -o "%ATTRIBUTES_CSV_FILE%"
set "RESULT=%ERRORLEVEL%"

if not "%RESULT%"=="0" (
    echo ERROR: fmsave export of attributes failed with exit code %RESULT%.
	popd
    exit /b %RESULT%
)
echo "Attributes Export Completed: "%ATTRIBUTES_CSV_FILE%"
echo

echo "Exporting Stats"
py -m fmsave export "%SAVE%" player-season-stats --managed-club ^
  --columns player_name,^
kind,^
team_id,^
average_rating,^
minutes,^
expected_goals_prevented,^
goals_allowed_per_90,^
interceptions_per_90,^
tackles_completed_per_90,^
clearances_per_90,^
blocks_per_90,^
pressures_completed_per_90,^
passes_completed_per_90,^
progressive_passes_per_90,^
open_play_key_passes_per_90,^
high_intensity_sprints_per_90,^
open_play_crosses_completed_per_90,^
dribbles_per_90,^
expected_assists_per_90,^
headers_won_per_90,^
non_penalty_expected_goals_per_90,^
shots_on_target_per_90,^
conversion_percent ^
  -o "%STATS_CSV_FILE%"
set "RESULT=%ERRORLEVEL%"

if not "%RESULT%"=="0" (
    echo ERROR: fmsave export of stats failed with exit code %RESULT%.
	popd
    exit /b %RESULT%
)

echo "Stats Export Completed: "%STATS_CSV_FILE%"
echo
popd
