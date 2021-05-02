# F1 Scripts & Configuration
Formula 1 Pipeline for BlueCrazii.nl

### Ingest
Content is grabbed from F1TV using [FormulaBlue](https://github.com/BlueCrazii-nl/FormulaBlue), it's configuration [here](https://github.com/BlueCrazii-nl/F1-scripts/blob/main/formulablue_config.yml) which goes in `/etc/formulablue/config.yml`
FormulaBlue streams to the NGINX ingest server. See [install script](https://github.com/BlueCrazii-nl/F1-scripts/blob/main/install_ingest.sh) and [config](https://github.com/BlueCrazii-nl/F1-scripts/blob/main/nginx_transcode.conf). The config file goes in `/usr/local/nginx/conf/nginx.conf`

### Transcodes
Transcoding from the source, 1080p @50Fps currently, to 1080p, 720p, 480p and 360p. We also transcode 1080p to make sure it stays somewhat in sync with the other resolutions.  
Configuratio and installation: [install script](https://github.com/BlueCrazii-nl/F1-scripts/blob/main/install_transcoder.sh) and [config](https://github.com/BlueCrazii-nl/F1-scripts/blob/main/nginx_transcode.conf). The config file goes in `/usr/local/nginx/conf/nginx.conf`

### Install scripts
Run the install script followed by the last value in the IP's octet. E.g if you want the IP to be `192.168.1.40`, you do `./path/to/install.sh 40`. If you dont want the subnet `192.168.1.0/24`, you'll have to edit the install scripts.

### Nvidia shennanigans
Since we use GeForce cards, we need to use some workarounds to use more than two NVENC streams. Hence we have `-platforms 2` in the FFMPEG commands. Besides this you'll also need to patch the driver in every container using it:
1. Clone https://github.com/keylase/nvidia-patch.git
2. Run `patch.sh`

The scripts install driver version `455.28`, make sure your host has this too.
