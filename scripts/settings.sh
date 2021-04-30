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
sudo touch /etc/locale.conf
tee -a /etc/locale.conf << EOF
export LANG="en_US.UTF-8"
export LC_COLLATE="C"
EOF

echo "Sync Hwclock and timezones"
sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sudo hwclock --systohc

echo "Setting Samba"
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
	force create mode = 0755
	force user = lyes
	force group = WORKGROUP
EOF

: '
echo "Config Asound"
sudo touch /etc/asound.conf
tee -a /etc/asound.conf << EOF
defaults.pcm.card 1
defaults.pcm.device 0
defaults.ctl.card 1
EOF
'

echo "Removing Unused Services"
sudo rm /var/service/agetty-tty3
sudo rm /var/service/agetty-tty4
sudo rm /var/service/agetty-tty5
sudo rm /var/service/agetty-tty6
sudo rm /var/service/SSHD

echo "Setting up Runit"
sudo ln -s /etc/sv/wpa_supplicant/ /var/service
sudo ln -s /etc/sv/dhcpcd/ /var/service
sudo ln -s /etc/sv/acpid/ /var/service
sudo ln -s /etc/sv/tlp/ /var/service
sudo ln -s /etc/sv/openntpd/ /var/service
sudo ln -s /etc/sv/smbd /var/service

sudo sv restart wpa_supplicant
sudo sv restart dhcpcd
sudo sv restart acpid
sudo sv restart tlp
sudo sv restart openntpd
sudo sv restart smbd

echo "Making font look nicer"
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d
