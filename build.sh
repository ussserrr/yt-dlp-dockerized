: "${CONTAINER_USER:=$(whoami)}"
: "${USER_ID:=$(id -u $CONTAINER_USER)}"
: "${GROUP_ID:=$(id -g $CONTAINER_USER)}"

docker buildx build \
    --build-arg HTTP_PROXY \
    --build-arg CONTAINER_USER=$CONTAINER_USER \
    --build-arg USER_ID=$USER_ID \
    --build-arg GROUP_ID=$GROUP_ID \
    --tag yt-dlp \
    .
