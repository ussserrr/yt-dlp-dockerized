#!/usr/bin/env bash

set -a
source .env
set +a

: "${CONTAINER_USER:=$(whoami)}"
: "${USER_ID:=$(id -u $CONTAINER_USER)}"
: "${GROUP_ID:=$(id -g $CONTAINER_USER)}"

export _CONTAINER_DL_DIR="/home/$CONTAINER_USER/downloads"

docker run \
    --rm \
    --env HTTPS_PROXY \
    --user $USER_ID:$GROUP_ID \
    --mount type=bind,src=$OUTPUT_DIR,dst=$_CONTAINER_DL_DIR \
    \
    yt-dlp "${YT_DLP_OPTIONS[@]}" -P $_CONTAINER_DL_DIR $@
