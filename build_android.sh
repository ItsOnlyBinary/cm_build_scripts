#!/bin/bash

SCRIPT_HOME="$(dirname "$(which "$0")")"
source "$SCRIPT_HOME/config"

if [ ! -e $SCRIPT_HOME/repo_sync ]; then
  echo "Repo sync script is not found"
  exit
fi

if [ ! -e $SCRIPT_HOME/build_start ]; then
  echo "Start build script is not found"
  exit
fi

if [ ! -e $SCRIPT_HOME/make_changelog ]; then
  echo "Make changelog script is not found"
  exit
fi

if [ ! -e $SCRIPT_HOME/build_finish ]; then
  echo "Update web script is not found"
  exit
fi

echo ""
echo "Syncing Repos."
echo ""
$SCRIPT_HOME/repo_sync
echo ""
echo "Creating Changelog."
echo ""
$SCRIPT_HOME/make_changelog
echo ""
echo "Building ROM."
echo ""
$SCRIPT_HOME/build_start
echo ""
echo "Updating Web Server."
echo ""
$SCRIPT_HOME/build_finish

