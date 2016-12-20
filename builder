#!/bin/bash

SCRIPT_HOME="$(dirname "$(which "$0")")"
source "$SCRIPT_HOME/config"

# resume our screen session
if screen -list | grep -q "builder"; then
  screen -r builder
  exit
fi

#start our session
if [ "$1" == "-d" ]; then
  echo "logfile $BUILD_LOG_FILE">/tmp/screenrc.$$
  screen -dmS builder -c /tmp/screenrc.$$ -L
else
  screen -dmS builder
fi

screen -S builder -X stuff "cd $PROJECT_DIR; source build/envsetup.sh\n"

#clean up
if [ -f /tmp/screenrc.$$ ]; then
  rm /tmp/screenrc.$$
fi

if [ "$1" == "-d" ]; then
  # run in daemon mode and start building
  export BUILDER_SHUTODWN=true
  screen -S builder -X stuff "$SCRIPT_HOME/build_android.sh\n"
else
  # open the screen session
  screen -r builder
fi