### /g/ - Linux

#### Unblock Lenovo WiFi
```bash
sudo echo "blacklist ideapad_laptop" | sudo tee -a /etc/modprobe.d/blacklist-ideapad-laptop.conf
rfkill unblock all
# If using NetworkManager -> nano /etc/network/interfaces -> remove any interface in there
sudo reboot now
```

#### List manually installed packages in diff pkg managers
```bash
comm -23 <(pacman -Qqett | sort) <(pacman -Qqg -g base-devel | sort | uniq)
zypper packages --installed-only | grep i+
xbps-query -m
```

#### Check storage space of directories
```bash
sudo du -h / | sort -rh | head -n 60 | grep -E "M|G"
sudo du -cha --max-depth=1 / | grep -E "M|G"
```

#### Check memory usage of each app
```bash
ps aux | awk '$6 != 0 {print $6/1024 " MB\t\t" $11}' | sort -nr
```

#### Extract links with lynx and download them with aria2
```bash
lynx --dump --listonly --nonumbers --hiddenlinks=ignore https://archive.org/download/alice_in_wonderland_librivox | grep -E '.ogg' | aria2c -i - -c -x 16 -j 4
```

#### Gamescope env variables 
```bash
MESA_VK_WSI_PRESENT_MODE=immediate
vk_xwayland_wait_ready=false
XKB_DEFAULT_LAYOUT=en
MANGOHUD=1
```

#### Patch Suckless software
```bash
patch -Np1 -i patch.diff
```

#### Clone & Update git repo with submodules
```bash
git clone --recurse-submodules https://github.com/repo/git
git submodule update --init --force --remote
git pull --recurse-submodules
```

#### Get system information
```bash
wmic memorychip get devicelocator, manufacturer
wmic memorychip get devicelocator, partnumber
wmic baseboard get product, Manufacturer
wmic model,serialNumber,size,mediaType
wmic diskdrive get model,index,firmwareRevision,status,interfaceType,totalHeads,totalTracks,totalCylinders,totalSectors,partitions
```

#### Disable CPU Mitigation
Edit /etc/default/grub and put the following:
```bash
GRUB_CMDLINE_LINUX="mitigations=off"
```
Then, run:
```bash
sudo update-grub
```

#### Add a drive in fstab
get UUID with:
```bash
sudo blkid
```
Edit /etc/fstab and put something like this:
```bash
UUID=3EFC1D0A56C4F8EE   /media/ST500                       ntfs    uid=1000,gid=1000,umask=0022,auto,rw,sync,users   0 0

UUID=a667fc4d-5a4d-4f35-b828-fbcabd0d5923   /media/RANDOM  ext4    errors=remount-ro    0 1
```
Then, run:
```bash
mount -a
sudo chown -Rc $USER:  /media/*
```

#### Fix MTP integration
```bash
# on GNOME based systems or pcmanfm(-qt)
sudo apt install --no-install-recommends gvfs gvfs-backends

# on KDE systems
sudo apt install --no-install-recommends kio kio-extras
```

#### /g/ Linux - Setup a Linux Server

#### Setup NetworkManager
```bash
sudo apt install --no-install-recommends network-manager

sudo systemctl stop wpa_supplicant
sudo systemctl stop dhcpcd
sudo systemctl disable wpa_supplicant
sudo systemctl disable dhcpcd
sudo systemctl enable dbus
sudo systemctl start dbus
sudo rm /etc/wpa_supplicant/wpa_supplicant.conf

sudo nano /etc/NetworkManager/NetworkManager.conf
# add the following lines:
# note for powersave: 
# (0): use the default value (1): don't touch existing setting 
# (2): disable powersave (3): enable powersave
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

[keyfile]
unmanaged-devices=none

[connection]
wifi.powersave = 2

sudo apt-get --purge autoremove dhcpcd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

nmcli device wifi list
nmcli device wifi connect "Your Network Name" password "Your Password"
```

#### Setup wpa_supplicant
```bash
su -l -c "wpa_passphrase myssid my_very_secret_passphrase > /etc/wpa_supplicant/wpa_supplicant.conf"

sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
# add the following lines:
ctrl_interface=/run/wpa_supplicant
update_config=1

sudo systemctl reenable wpa_supplicant.service
sudo service wpa_supplicant restart
sudo service dhcpcd restart
wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf

sudo nano /etc/network/interfaces
# add the following lines:
allow-hotplug wlp2s0
iface wlp2s0 inet dhcp
        wpa-ssid myssid
        wpa-psk ccb290fd4fe6b22935cbae31449e050edd02ad44627b16ce0151668f5f53c01b
```


#### Disable systemd lid suspend
```bash
sudo nano /etc/systemd/logind.conf
# modify: HandleLidSwitch=suspend/poweroff/hibernate/suspend/ignore
```

#### Setup SSH
```bash
sudo apt install --no-install-recommends openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
```

#### Setup SSHFS
```bash
sudo apt install --no-install-recommends sshfs
sudo mkdir /mnt/NAME
sshfs username@remote_host:/path/to/remote/directory /mnt/NAME
```

#### Setup qbittorrent-nox
```bash
sudo apt install --no-install-recommends qbittorrent-nox
# run qbittorrent-nox and visit http://localhost:8080
sudo systemctl start qbittorrent-nox@lyes
sudo systemctl enable qbittorrent-nox@lyes
# whitelist 0.0.0.0/0
```

#### Setup NFS
```bash
sudo apt install --no-install-recommends nfs-kernel-server
sudo mv /etc/exports /etc/exports.bak

sudo nano /etc/exports
# add the following lines:
/home/lyes 192.168.100.15/255.255.255.0(rw,async,no_subtree_check,anonuid=1000,anongid=1000) 192.168.100.11/255.255.255.0(rw,async,no_subtree_check,anonuid=1000,anongid=1000)

sudo systemctl restart nfs-kernel-server
# (optional on client) sudo apt install --no-install-recommends nfs-common
```

#### Setup Samba
```bash
sudo apt install --no-install-recommends samba

sudo nano /etc/samba/smb.conf
# add the following lines:
[sharing]
  comment = Sharing
  path = /home/lyes
  guest ok = no
  read only = no
  browseable = yes

# sudo useradd -M <username> (optional)
sudo smbpasswd -a <username>
sudo systemctl enable smb
sudo systemctl start smb
sudo systemctl restart nmbd
# (on Windows, use the name of the smb setting)
```

#### Setup SFTP (Windows & Linux)
```bash
# /win/ (Windows)
# get https://github.com/winfsp/winfsp/tree/v2.0 & https://github.com/winfsp/sshfs-win/tree/v3.5.20357
\\sshfs\[sftpuser]@[sftphost]

# /linux/ (Linux)
sudo apt install --no-install-recommends sshfs
sudo mkdir /mnt/<folder name>
sudo sshfs -o allow_other lyes@192.168.100.10:/home/lyes/ /mnt/<folder name>/
```

#### Disable NetworkManager Power Saving
```bash
# (0): use the default value (1): don't touch existing setting (2): disable powersave (3): enable powersave
sudo nano /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
# add the following lines:
[connection]
wifi.powersave = 2

sudo systemctl restart NetworkManager
```

#### /g/ Linux - Gaming

#### Add MangoHUD & Gamescope to your Steam games
```bash
MANGOHUD=1 %command%
gamemoderun -- mangohud %command%
SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 gamescope -r 60 -H 1080 -f -- mangohud %command%
gamemoderun SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 gamescope -r 60 -H 1080 -f -- mangohud %command%
```

### /windows/

#### Add NFS Client
```batch
# In PowerShell with admin rights, add:
Enable-WindowsOptionalFeature -FeatureName ServicesForNFS-ClientOnly, ClientForNFS-Infrastructure -Online -NoRestart
```

- Get GID and UID with:
```batch
mount
```

```batch
# Add DWORD (32-bit) RegKey and use GID/UID as values:
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default
AnonymousUid
AnonymousGid

net stop nfsclnt
net stop nfsrdr
net start nfsrdr

# Restart service: Client NFS
mount -o anon \\192.168.100.13\home\lyes Z
```

#### Update Windows Icons (Command Prompt)
```batch
taskkill /F /IM explorer.exe
cd /d %userprofile%\AppData\Local
attrib –h IconCache.db
del IconCache.db
start explorer.exe
```

#### Add ApxPackage
```powershell
Add-AppxPackage Microsoft.VP9VideoExtensions1.0.50901.0_x64_8wekyb3d8bbwe.appx
```

### FFmpeg Commands

#### H265 AMD
```bash
ffmpeg -hwaccel auto -i i.mp4 -pix_fmt yuv420p -map 0:v -map 0:a -c:v hevc_amf -b:v 2000k -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 -color_primaries bt709 -color_trc bt709 -colorspace bt709 ii.mp4
```

#### H265
```bash
ffmpeg -hwaccel auto -i i.mp4 -pix_fmt yuv420p -map 0:v -map 0:a -c:v libx265 -c:a libopus -preset faster -profile:v main -level:v 4.0 -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 ii.mp4
```

#### H264
```bash
ffmpeg -hwaccel auto -i i.mp4 -pix_fmt yuv420p -map 0:v -map 0:a -c:v libx264 -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 ii.mp4
```

#### WebM
```bash
ffmpeg -hwaccel auto -i i.mp4 -pix_fmt yuv420p -map 0:v -map 0:a -c:v libvpx-vp9 -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos-movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 ii.webm
```

#### Bulk Preset
```bash
for %i in (*.mp4 *.mkv *.ts *.mov *.avi) do ffmpeg -i "%i" -pix_fmt yuv420p -map 0:v -map 0:a -c:v libx264 -preset faster -profile:v main -level:v 4.0 -c:a libopus "NEW_%~ni.mp4"
```

#### Bulk AMD H265
```bash
for %i in (*.mp4 *.mkv *.ts *.mov *.avi) do ffmpeg -hwaccel auto -i "%i" -pix_fmt yuv420p -map 0:v -map 0:a -c:v hevc_amf -preset faster -profile:v main -level:v 4.0 -c:a libopus  -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos  -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 "NEW_%~ni.mp4"
```

#### Bulk H265
```bash
for %i in (*.mp4 *.mkv *.ts *.mov *.avi) do ffmpeg -i "%i" -pix_fmt yuv420p -map 0:v -map 0:a -c:v libx265 -preset faster -profile:v main -level:v 4.0 -c:a libopus  -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 "NEW_%~ni.mp4"
```

#### Rescale AMD H265
```bash
ffmpeg -hwaccel auto -i i.mp4 -vf "scale=-1:720,fps=30" -pix_fmt yuv420p -map 0:v -map 0:a -c:v hevc_amf -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 ii.mp4

```

#### Rescale Bulk AMD H265
```bash
mkdir encVids
for %%i in (*.mp4 *.mkv *.ts *.mov *.avi) do (
    if not exist "encVids\%%~ni.mp4" (
        ffmpeg -hwaccel auto -i "%%i" -vf "scale=-1:720,fps=30" -pix_fmt yuv420p -map 0:v -map 0:a -c:v hevc_amf -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 "encVids\%%~ni.mp4"
    )
)
```

#### Bulk Opus
```bash
for %i in (*.mp3 *.aac *.wav) do ffmpeg -i "%i" -c:a libopus -q:a 1 -movflags use_metadata_tags -vn "%~ni.ogg"
```

#### Cut & Merge
```bash
for %i in ("**") do ffmpeg -i "%i" -ss 00:49:00 -to 01:13:28 -c:v copy -c:a copy "n%~i"
ffmpeg -f concat -i x.txt -c copy out.mp4
file '1.mkv'
file '2.mkv'
```

### ImageMagick Commands

#### Bulk WebP from PNG
```bash
for %i in ("*.png*") do magick convert "%i" -define webp:lossless=true "%~ni.webp"
```

#### Bulk WebP from JPG
```bash
for %i in ("*.jpg*") do magick convert "%i" -define webp "%~ni.webp"
```

#### Static WebP
```bash
magick z.jpg -quality 100 -define webp:lossless=true -resize 1920x1080 -background black -compose Copy -gravity center -extent 1920x1080 z.webp
```

#### Animated WebP
```bash
magick convert -delay 500 *.jpg -quality 100 -define webp:lossless=true -resize 1920x1080 -background black -compose Copy -gravity center -extent 1920x1080 -loop 0 z.webp
```

### /web/

#### Open new tabs in background on firefox
```
# about:config
browser.tabs.loadDivertedInBackground
```

#### Enable vaapi hw accel on firefox
```
# about:config
media.ffmpeg.vaapi.enabled
```

#### Endless Scroll
```javascript
function autoScrolling() {
  window.scrollTo(0, document.body.scrollHeight);
}

var varScroll = setInterval(autoScrolling, 500);
```

#### Scroll Fixed Bookmark
```javascript
javascript:window.scrollTo(0,document.body.scrollHeight);
```

#### Clear Scroll
```javascript
javascript:clearInterval(varScroll);
```

#### Hide Section
```html
<div id="hashLink">
  <a class="toggle" href="#">/hide/</a>
</div>
<a class="toggle" href="#hashLink">/nsfw/</a>
```
