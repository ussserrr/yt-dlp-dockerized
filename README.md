# yt-dlp - dockerized
Containerized version of the yt-dlp project. Simplifies usage and doesn't clashes with your environment (isolated). Supports proxy forwarding - in case you sit behind some provider proxy.

## Usage
```Shell
chmod +x build.sh
chmod +x run.sh
./build.sh
./run.sh https://youtube.com/shorts/some_youtube_id
./run.sh https://www.youtube.com/watch\?v\=dont_forget_escaping
./run.sh -f "bv*[height<=720]+ba/b" https://www.youtube.com/playlist\?list\=youtube_playlist_id_here
...
```
