#!/bin/bash

# Detect username
username=$(whoami)

# Install different packages according to GPU vendor (Intel, AMDGPU) 
cpu_vendor=$(cat /proc/cpuinfo | grep vendor | uniq)
gpu_drivers=""
libva_environment_variable=""
vdpau_environment_variable=""
if [[ $cpu_vendor =~ "AuthenticAMD" ]]
then
 gpu_drivers="xf86-video-amdgpu mesa-vulkan-radeon mesa-vulkan-radeon-32bit mesa-vdpau mesa-vdpau-32bit"
 libva_environment_variable="export LIBVA_DRIVER_NAME=radeonsi"
elif [[ $cpu_vendor =~ "GenuineIntel" ]]
then
 gpu_drivers="xf86-video-intel mesa-vulkan-intel mesa-vulkan-intel-32bit	intel-media-driver libvdpau-va-gl libvdpau-va-gl-32bit"
 libva_environment_variable="export LIBVA_DRIVER_NAME=iHD"
 vdpau_environment_variable="export VDPAU_DRIVER=va_gl"
fi

sudo pacman -Suy

echo "Installing GPU drivers"
sudo pacman -S $gpu_drivers

echo "Improving hardware video accelaration"
sudo pacman -S ffmpeg libva-utils libva-vdpau-driver vdpauinfo

# Reference: https://github.com/lutris/docs/blob/master/WineDependencies.md
# echo "Installing Lutris (with Wine support)"
sudo pacman -S lutris wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs

echo "Installing Apps"
sudo pacman -S xorg-server xrdb alsa-utils lm_sensors xorg-xbacklight tlp bspwm sxhkd rxvt-unicode st-terminfo nnn neovim ncurses tmux mpv sxiv hsetroot picom polybar dunst base-devel libxft libxinerama libxcb xcb xcb-util-keysyms xcb-util-xrm xcb-util-wm scrot wget youtube-dl unzip openntpd ntfs-3g xdg-utils xprop xsetroot samba cifs-utils smbclient xdpyinfo tango-icon-theme arc-theme git connman

echo "Installing Fonts"
sudo pacman -S ttf-ibm-plex noto-fonts-emoji

echo "Installing Yay AUR Helper"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

echo "Installing AUR packages"
yay -S simple-mtpfs font-kakwafont font-Siji

echo "Setting X Keyboard"
sudo mkdir /etc/X11/xorg.conf.d
sudo touch /etc/X11/xorg.conf.d/00-keyboard.conf
tee -a /etc/X11/xorg.conf.d/00-keyboard.conf << EOF
Section "InputClass"
		Identifier "system-keyboard"
		MatchIsKeyboard "on"
		Option "XkbLayout" "fr"
EndSection
EOF

echo "Setting Touchpad"
sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
tee -a /etc/X11/xorg.conf.d/30-touchpad.conf << EOF
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "Tapping" "on"
	Option "TapingDrag" "True"
        Driver "libinput"
EndSection
EOF

echo "Setting libinput"
sudo touch /etc/X11/xorg.conf.d/40-libinput.conf
tee -a /etc/X11/xorg.conf.d/40-libinput.conf << EOF
# Match on all types of devices but joysticks
#
# If you want to configure your devices, do not copy this file.
# Instead, use a config snippet that contains something like this:
#
# Section "InputClass"
#   Identifier "something or other"
#   MatchDriver "libinput"
#
#   MatchIsTouchpad "on"
#   ... other Match directives ...
#   Option "someoption" "value"
# EndSection
#
# This applies the option any libinput device also matched by the other
# directives. See the xorg.conf(5) man page for more info on
# matching devices.

Section "InputClass"
        Identifier "libinput pointer catchall"
        MatchIsPointer "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput keyboard catchall"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
	Option "Tapping" "True"
	Option "TapingDrag" "True"
	Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput touchscreen catchall"
        MatchIsTouchscreen "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput tablet catchall"
        MatchIsTablet "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection
EOF

echo "Setting X Intel"
sudo touch /etc/X11/xorg.conf.d/99-intel.conf
tee -a /etc/X11/xorg.conf.d/99-intel.conf << EOF
Section "OutputClass"
	Identifier "intel"
    MatchDriver "i915"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "TearFree" "true"
    Option "DRI" "3"
EndSection
EOF

echo "Setting Locales"
sudo rm -rf /etc/locale.conf
sudo touch /etc/locale.conf
tee -a /etc/locale.conf << EOF
LANG="fr_FR.UTF-8"
LANGUAGE="fr_FR:en_US"
LC_COLLATE=C
EOF

echo "Setting Samba"
sudo rm -rf /etc/samba/smb.conf
sudo touch /etc/samba/smb.conf
tee -a /etc/samba/smb.conf << EOF
[global]
	server role = standalone server
	map to guest = bad user
	usershare allow guests = yes
	hosts allow = 192.168.0.0/16
	hosts deny = 0.0.0.0/0

[anemone]
	comment = Comfy sharing
	path = /home/lyes/
	read only = no
	guest ok = yes
	force create mode = 755
	force user = lyes
	force group = lyes
EOF

echo "Sync Hwclock and timezones"
sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sudo hwclock --systohc

: '
echo "Config Asound"
sudo touch /etc/asound.conf
tee -a /etc/asound.conf << EOF
defaults.pcm.card 1
defaults.pcm.device 0
defaults.ctl.card 1
EOF
'

echo "Setting up Runit"
sudo ln -s /etc/runit/sv/connmand/ /run/runit/service
sudo ln -s /etc/runit/sv/acpid/ /run/runit/service
sudo ln -s /etc/runit/sv/tlp/ /run/runit/service
sudo ln -s /etc/runit/sv/openntpd/ /run/runit/service
sudo ln -s /etc/runit/sv/smbd /run/runit/service

sudo sv restart connmand
sudo sv restart wpa_supplicant
sudo sv restart acpid
sudo sv restart tlp
sudo sv restart openntpd
sudo sv restart smbd

echo "Making font look nicer"
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d

echo "Cloning Repos"
git clone https://github.com/Speyll/dotfiles
git clone https://github.com/Speyll/suckless
git clone https://github.com/Speyll/dump