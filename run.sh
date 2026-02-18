#!/usr/bin/env bash

set -a
source .env
set +a

export CONTAINER_USER=$(whoami)
export _CONTAINER_DL_DIR="/home/$CONTAINER_USER/downloads"

docker run \
    --rm \
    --env HTTPS_PROXY \
    --mount type=bind,src=$OUTPUT_DIR,dst=$_CONTAINER_DL_DIR \
    \
    yt-dlp "${YT_DLP_OPTIONS[@]}" -P $_CONTAINER_DL_DIR $@
