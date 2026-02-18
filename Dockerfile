# syntax=docker/dockerfile:1

FROM python:latest

# Establish apt package manager cache using Docker BuildKit (see
# github.com/moby/buildkit frontend/dockerfile/docs/reference.md)
RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > \
        /etc/apt/apt.conf.d/keep-cache

RUN if [ -n "$HTTP_PROXY" ]; then \
        echo "Acquire::http::proxy \"$HTTP_PROXY/\";" > \
            /etc/apt/apt.conf.d/10proxy; \
    fi

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    \
    apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        curl \
        ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Map the passed host user to the container user
ARG USER_ID
ARG GROUP_ID
ARG CONTAINER_USER
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
ENV CONTAINER_USER=${CONTAINER_USER}
ENV HOME=/home/$CONTAINER_USER
RUN groupadd --gid $GROUP_ID group \
    && useradd \
        --shell /bin/bash \
        --no-log-init \
        --create-home \
        --uid $USER_ID \
        --gid $GROUP_ID \
        --home $HOME \
        $CONTAINER_USER \
    && mkdir -p $HOME/.cache \
    && chown $CONTAINER_USER --recursive $HOME
USER $CONTAINER_USER

# yt-dlp needs to solve JavaScript challenges presented by YouTube
# using an external JavaScript runtime. See
# https://github.com/yt-dlp/yt-dlp/wiki/EJS
COPY --from=denoland/deno:bin /deno /usr/local/bin/deno

ENV VENV_PATH=$HOME/venv
RUN python -m venv $VENV_PATH
ENV PATH="$VENV_PATH/bin:$PATH"

ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_CACHE_DIR=$HOME/.cache/pip

RUN --mount=type=cache,target=$PIP_CACHE_DIR,uid=$USER_ID,gid=$GROUP_ID \
    \
    pip install "yt-dlp[default]"

ENTRYPOINT ["yt-dlp"]
CMD ["--help"]
