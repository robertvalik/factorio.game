# Factorio Headless Savegame

This script can be used to create a data and save folders for [Factorio](https://www.factorio.com/) headless server that will host multiple games.

Best used with https://github.com/robertvalik/factorio.updater

## Installation

First step is to create target FACTORIO_ROOT (and preferably a system user exclusively for running Factorio) that will contain all game data and install the [updater script](https://github.com/robertvalik/factorio.game.git).

Next step is to cd $FACTORIO_ROOT and use:

git clone https://github.com/robertvalik/factorio.updater.git

to pull a save directory for a single Factorio game.

Create copies of all *.sample files (without the .sample suffix) and modify to your needs. Alternatively you can provide configuration files from your existing headless server configuration :-)

## Configuration

The script is configured by creating and editing a savegame.conf file.

SAVEGAME_NAME contains name of the game.

UPDATE - should the factorio_game.sh script run updater and update this game to the latest version?
- "yes" is self-explanatory
- in the case "no" is provided as a configuration option, you have to download and extract the desired version manually, it must reside in a folder called factorio_headless_x64_$FACTORIO_VERSION in the FACTORIO_ROOT directory

FACTORIO_VERSION - specific version should be run. This option is ignored if UPDATE is set to "yes"

DONOTUSEADMINLIST - backward compatibility setting, set to "yes" if you want to run an older version of Factorio (like 0.16.something?)

COPY_OPTS - some options passed to cp command when creating a new game folder (new game or new version). For example if "--reflink=always" is passed to cp on BTRFS, the game files are "coloned" not copied and do not use more disk space unless changed.

Do not forget to change port number in the Factorio config if you intend to run more than one game simultaneously.

## Running

The game should be started by going to the game folder and running ./factorio_game.sh

## Limitations

- earliest version I have tried the script is 0.16.51. Use at your own risk :-)
- I did not find a way to run multiple headless servers from one game directory at the same time (Factorio still creates lock file and log in the game dir), that is the reason that the game folder is created for every game.
- no automatic cleanup - you have to delete folders for old games manually

## To do

- port configuration
- propagate game name to configuration for Factorio 
headless server
- probably some other changes I will need (PRs welcome)