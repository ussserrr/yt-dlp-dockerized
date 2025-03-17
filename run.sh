export CONTAINER_USER=$(whoami)

docker run \
    --rm \
    --env HTTPS_PROXY \
    --mount type=bind,src=$HOME/downloads,dst=/home/$CONTAINER_USER/downloads \
    \
    yt-dlp --no-check-certificate --compat-option no-certifi -f "best[height=720]" -P /home/$CONTAINER_USER/downloads $@
