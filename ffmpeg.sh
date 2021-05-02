# FFMPEG Commands. To be put in /root/ffmpeg.sh on transcode nodes.
# NED 360p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 1000K -minrate 1000K -maxrate 1000K -bufsize 5000k -s 640x360 -f flv rtmp://45.10.159.20/hlsingest/F1NL_360

# NED 480p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 2500k -minrate 2500K -maxrate 2500K -bufsize 3000k -s 854x480 -f flv rtmp://45.10.159.20/hlsingest/F1NL_480

# NED 720p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 4500k -minrate 4500k -maxrate 4500K -bufsize 3000k -s 1280x720 -f flv rtmp://45.10.159.20/hlsingest/F1NL_720

# NED 1080p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 6000k -bufsize 10000k -s 1920x1080 -f flv rtmp://45.10.159.20/hlsingest/F1NL_1080

# ENG 360p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 1000K -minrate 1000K -maxrate 1000K -bufsize 5000k -s 640x360 -f flv rtmp://45.10.159.20/hlsingest/F1ENG_360

# ENG 480p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 2500k -minrate 2500K -maxrate 2500K -bufsize 3000k -s 854x480 -f flv rtmp://45.10.159.20/hlsingest/F1ENG_480

# ENG 720p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 4500k -minrate 4500k -maxrate 4500K -bufsize 3000k -s 1280x720 -f flv rtmp://45.10.159.20/hlsingest/F1ENG_720

# ENG 1080p
ffmpeg -i rtmp://127.0.0.1/transcodes/$1 -surfaces 2 -c:a aac -ac 2 -b:a 128k -c:v h264_nvenc -pix_fmt yuv420p -profile:v baseline -tune zerolatency -vsync cfr -x264-params "nal-hrd=cbr" -b:v 6000k -bufsize 10000k -s 1920x1080 -f flv rtmp://45.10.159.20/hlsingest/F1ENG_1080