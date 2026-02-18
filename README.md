# yt-dlp - dockerized
Containerized version of the [yt-dlp](https://github.com/yt-dlp/yt-dlp) project.

yt-dlp is a pretty large project with a lot of internal dependencies (PIP packages) and external tools it is relying on (FFmpeg, JavaScript EJS environment, etc). This project goal is to simplify an installation and usage of yt-dlp across different platforms.


## Usage
If you're behind some proxy set the HTTP_PROXY variable that will be used during a build step. To set download path and frequently used yt-dlp options outside of repository files add the `.env` file and put them here:

```Shell
OUTPUT_DIR=/home/user/Downloads
YT_DLP_OPTIONS=(--no-check-certificate --compat-option no-certifi -f "best[height=720]")
```

Then build and run:

```Shell
chmod +x build.sh
chmod +x run.sh

./build.sh

./run.sh https://www.youtube.com/watch\?v\=dont_forget_escaping
# YouTube shorts
./run.sh https://youtube.com/shorts/some_youtube_id
# Add additional options not in .env file
./run.sh -f "bv*[height<=720]+ba/b" https://www.youtube.com/playlist\?list\=youtube_playlist_id_here
```

Any other service that is supported by yt-dlp is available (Instagram, etc).
