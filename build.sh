export DOCKER_BUILDKIT=1
export CONTAINER_USER=$(whoami)
export USER_ID=$(id -u $CONTAINER_USER)
export GROUP_ID=$(id -g $CONTAINER_USER)

docker build \
	--build-arg HTTP_PROXY \
	--build-arg CONTAINER_USER=$CONTAINER_USER \
	--build-arg USER_ID=$USER_ID \
	--build-arg GROUP_ID=$GROUP_ID \
    --tag yt-dlp \
    .
