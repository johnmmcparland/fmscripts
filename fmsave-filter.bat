@echo off
setlocal

REM Input and output files
set "INPUT=fmsave.csv"
set "OUTPUT=fmsave_filtered.csv"

if not exist "%INPUT%" (
    echo ERROR: Input file "%INPUT%" not found.
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$columns = @('name','common_name','age','natural_positions'," ^
    "'attributes_crossing','attributes_dribbling','attributes_finishing'," ^
    "'attributes_first_touch','attributes_heading','attributes_long_shots','attributes_marking'," ^
    "'attributes_passing','attributes_tackling','attributes_technique'," ^
    "'attributes_corners','attributes_free_kick_taking','attributes_long_throws','attributes_penalty_taking'," ^
    "'attributes_aggression','attributes_anticipation','attributes_bravery','attributes_composure'," ^
    "'attributes_concentration','attributes_decisions','attributes_determination'," ^
    "'attributes_flair','attributes_leadership','attributes_off_the_ball','attributes_positioning'," ^
    "'attributes_teamwork','attributes_vision','attributes_work_rate'," ^
    "'attributes_acceleration','attributes_agility','attributes_balance','attributes_jumping_reach'," ^
    "'attributes_natural_fitness','attributes_pace','attributes_stamina','attributes_strength'," ^
    "'attributes_aerial_reach','attributes_command_of_area','attributes_communication','attributes_eccentricity'," ^
    "'attributes_handling','attributes_kicking','attributes_one_on_ones','attributes_punching','attributes_reflexes'," ^
    "'attributes_rushing_out','attributes_throwing');" ^
    "$data = Import-Csv -LiteralPath '%INPUT%';" ^
    "if ($data.Count -eq 0) { Write-Host 'ERROR: CSV contains no data.'; exit 1 };" ^
    "$available = $data[0].PSObject.Properties.Name;" ^
    "$missing = @($columns | Where-Object { $_ -notin $available });" ^
    "if ($missing.Count -gt 0) { Write-Host ('ERROR: Missing columns: ' + ($missing -join ', ')); exit 1 };" ^
    "$data | Select-Object -Property $columns | Export-Csv -LiteralPath '%OUTPUT%' -NoTypeInformation -Encoding UTF8"

if errorlevel 1 (
    echo.
    echo ERROR: Failed to filter CSV.
    pause
    exit /b 1
)

echo.
echo Successfully created "%OUTPUT%".
pause
