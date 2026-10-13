#!/usr/bin/env bash
set -ex
START_COMMAND="photocraft"
PGREP="photocraft"
export MAXIMIZE="true"
export MAXIMIZE_NAME="PhotoCraft"
MAXIMIZE_SCRIPT=$STARTUPDIR/maximize_window.sh
DEFAULT_ARGS=""
ARGS=${APP_ARGS:-$DEFAULT_ARGS}

# Relaunch PhotoCraft whenever it is closed, unless custom startup is disabled
if [ -z "$DISABLE_CUSTOM_STARTUP" ]; then
  echo "Entering process startup loop"
  set +x
  while true; do
    if ! pgrep -x $PGREP > /dev/null; then
      /usr/bin/filter_ready
      /usr/bin/desktop_ready
      set +e
      bash ${MAXIMIZE_SCRIPT} &
      $START_COMMAND $ARGS
      set -e
    fi
    sleep 1
  done
fi
