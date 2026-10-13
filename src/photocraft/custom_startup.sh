#!/usr/bin/env bash
set -ex
START_COMMAND="photocraft"
DEFAULT_ARGS=""
ARGS=${APP_ARGS:-$DEFAULT_ARGS}

/usr/bin/filter_ready
/usr/bin/desktop_ready
set +e
bash ${MAXIMIZE_SCRIPT} &
$START_COMMAND $ARGS