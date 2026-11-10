# Football Manager Scripts

Helpful scripts to allow me to

- backup the game
- manage graphic downloads
- export settings
- export saves

Builds on two things

1) fm_settings_exporter: (c) [Sports Interactive](https://www.sports-interactive.com/)
2) [fmsave](https://github.com/rhiever/fmsave) by [Randy Olson](https://github.com/rhiever)

In particular, the first is property and copyright of Sports Interactive](https://www.sports-interactive.com/) and my own modification serves only 
to allow me to obtain the same settings for FM 27 on PC.

## Compatability

Tested on

 * Windows 11
 * Football Manager 27

## Design

Within `%USERPROFILE%/Documents` lives a folder called `FMBackups`

Within there

 * A folder called `graphics` in which cross-version graphics live 
 * A set of utility scripts to help me manage the game
 
Primarily scripts are bash shell scripts run on git bash, but there's the occassional Windows Batch (run in cmd prompt) for the [fmsave](https://github.com/rhiever/fmsave) parts.

Occassionally, other directories such as "RealNames" are in here too when I backup parts of the game, but these aren't under source control.

## Settings Export

 * [fm_settings_exporter.bat](./fm_settings_exporter.bat]
   * Obtains the PC settings for FM 27 and zips them up
 * [fm_settings_exporter_orig.bat](./fm_settings_exporter_orig.bat)
   * (c) [Sports Interactive](https://www.sports-interactive.com/)

## Graphics

 * [mkFmGraphicsDirs.sh](./mkFmGraphicsDirs.sh)
   * Creates the graphics directories for my primary graphic downloads
 * [linkGraphicsDir.bat](./linkGraphicsDir.bat)
   * Create a Windows link called 'graphics' in the `%USERPROFILE%\Documents\Sports Interactive\Football Manager 27` and links it to `%USERPROFILE%\Documents\Sports Interactive\FMBackups\graphics`
   * Allows graphics to be stored in a location outside of `%USERPROFILE%\Documents\Sports Interactive\Football Manager 27` and shared across versions
 * [disableGraphicConfigs.sh](./disableGraphicConfigs.sh) and [restoreGraphicConfigs.sh](./restoreGraphicConfigs.sh)
   * Disables all config.xml files for graphics, and restores them
   * Handy when the graphics aren't working as expected, or you need to report bugs
  * [checkGraphicAdditions.sh](./checkGraphicAdditions.sh)
    * Checks if any of my additions have been replaced by new downloads 

## Exporting saves 

Wrapper round [fmsave](https://github.com/rhiever/fmsave) by [Randy Olson](https://github.com/rhiever) - this time using Windows batch since it requires python 

 * [fmsave.bat](./fmsave.bat)
   * Exports my latest save - needs modified for your save name
   * Wrappy around Randy's script
 * [fmsave-filter.bat](./fmsave-filter.bat)
   * ChatGPT generated filter for the above to reduce columns. No longer necessary
 * [fmsave_diag.bat](./fmsave_diag.bat) and [fmsave_diag.py])./fmsave_diag.py)
   * The .py by Randy, the .bat a wrapper round it for debugging
