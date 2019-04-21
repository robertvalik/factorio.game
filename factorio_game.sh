#!/bin/bash
. ~/.factorio_server.conf
. savegame.conf
echo $SAVEGAME_NAME

if [ "$UPDATE" = "yes" ] ; then
	. $FACTORIO_ROOT/factorio_updater.sh
	FACTORIO_VERSION=$FACTORIO_CURRENT_VERSION
fi

SAVEGAME_DIR="$FACTORIO_ROOT/factorio.game.$SAVEGAME_NAME"
GAMEDATA_SOURCE_DIR="$FACTORIO_ROOT/factorio_headless_x64_$FACTORIO_VERSION"
GAMEDATA_DIR="$FACTORIO_ROOT/factorio_headless_x64_$FACTORIO_VERSION.$SAVEGAME_NAME"

if [ ! -e $GAMEDATA_DIR ]; then
	cp -r $COPY_OPTS $GAMEDATA_SOURCE_DIR $GAMEDATA_DIR
fi

if [ ! -e $GAMEDATA_DIR/saves ]; then
	ln -s $SAVEGAME_DIR/saves $GAMEDATA_DIR/saves
fi

if [ ! -e $SAVEGAME_DIR/player-data.json ]; then
	touch $SAVEGAME_DIR/player-data.json
fi

if [ ! -e $GAMEDATA_DIR/player-data.json ]; then
	ln -s $SAVEGAME_DIR/player-data.json $GAMEDATA_DIR/player-data.json
fi

if [ ! -e $SAVEGAME_DIR/server-adminlist.json ]; then
	touch $SAVEGAME_DIR/server-adminlist.json
fi

if [ ! -e $GAMEDATA_DIR/server-adminlist.json ]; then
	ln -s $SAVEGAME_DIR/server-adminlist.json $GAMEDATA_DIR/server-adminlist.json
fi

if [ "$DONOTUSEADMINLIST" = "yes" ] ; then
	ADMINLISTOPTION="--server-adminlist $GAMEDATA_DIR/server-adminlist.json"
else
	ADMINLISTOPTION=""
fi

$GAMEDATA_DIR/bin/x64/factorio \
	-c $SAVEGAME_DIR/config/config.ini \
	--start-server-load-latest $GAMEDATA_DIR/saves/$SAVEGAME_NAME.zip \
	--server-settings $SAVEGAME_DIR/config/server-settings.json \
	$ADMINLISTOPTION \
	--mod-directory $SAVEGAME_DIR/mods/ \
	--server-banlist $SAVEGAME_DIR/server-banlist.json \
	--console-log $SAVEGAME_DIR/console.log

