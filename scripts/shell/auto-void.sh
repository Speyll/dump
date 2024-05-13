#!/bin/sh
# Void Linux Post-Installation Script for Wayland
# Author: Speyll
# Last-update: 13-05-2024

# Enable debugging output and exit on error
set -x

# Add multilib and nonfree repositories
sudo xbps-install -Sy void-repo-nonfree

# Update package lists and upgrade existing packages
sudo xbps-install -Syu

# Install GPU drivers
install_gpu_driver() {
  gpu_driver=""
  case "$(lspci | grep -E 'VGA|3D')" in
    *Intel*) gpu_driver="mesa-dri intel-video-accel vulkan-loader mesa-vulkan-intel" ;;
    *AMD*)   gpu_driver="mesa-dri mesa-vaapi mesa-vdpau vulkan-loader mesa-vulkan-radeon" ;;
    *NVIDIA*)gpu_driver="mesa-dri nvidia nvidia-libs-32bit" ;;
  esac
  for pkg in $gpu_driver; do
    [ -n "$pkg" ] && sudo xbps-install -y "$pkg"
  done
}

install_gpu_driver

# Install CPU microcode updates
if lspci | grep -q 'Intel'; then
  sudo xbps-install -y intel-ucode
  sudo xbps-reconfigure -f linux-$(uname -r)
fi

# Install other packages
install_core_packages() {
  sudo xbps-install -y \
    git wayland dbus dbus-glib curl elogind polkit-elogind \
    xdg-utils xdg-desktop-portal-gtk xdg-desktop-portal-wlr xdg-desktop-portal \
    pipewire gstreamer1-pipewire libspa-bluetooth pavucontrol wlr-randr \
    noto-fonts-emoji noto-fonts-ttf font-hack-ttf font-awesome \
    grim slurp wl-clipboard cliphist \
    imv swaybg mpv ffmpeg yt-dlp \
    fnott libnotify \
    nnn unzip p7zip unrar pcmanfm-qt ffmpegthumbnailer lxqt-archiver gvfs-smb gvfs-afc gvfs-mtp udisks2 \
    breeze-gtk breeze-snow-cursor-theme breeze-icons \
    qt5-wayland bluez \
    wayfire neovim foot Waybar wlsunset fuzzel brightnessctl #labwc sway nano yambar qimgv seatd dumb_runtime_dir polkit-kde-agent
}

install_networking_packages() {
  sudo xbps-install -y \
    fuse-sshfs lynx rsync wireguard \
}

install_flatpak_packages() {
  sudo xbps-install -y flatpak
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub io.gitlab.librewolf-community
  flatpak install flathub com.github.tchx84.Flatseal
}

install_flatpak_gaming() {
  flatpak install flathub com.usebottles.bottles
  flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud
  flatpak install flathub org.freedesktop.Platform.VulkanLayer.gamescope 
}

install_gaming_packages() {
  sudo xbps-install -y \
    void-repo-multilib-nonfree \
    libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit wine wine-mono gamemode MangoHud gamescope
  sudo usermod -aG gamemode $USER 
}

# !IMPORTANT! here you can select what get installed and what not by commenting
install_core_packages
install_networking_packages
install_flatpak_packages
#install_flatpak_gaming
#install_gaming_packages

# Set up PipeWire autostart
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/pipewire.desktop

# Set up elogind
sudo ln -s /etc/sv/elogind /var/service/

# Set up bluetooth autostart
sudo ln -s /etc/sv/bluetoothd /var/service/

# Remove unused services (TTYs)
sudo rm -rf /var/service/agetty-tty3
sudo rm -rf /var/service/agetty-tty4
sudo rm -rf /var/service/agetty-tty5
sudo rm -rf /var/service/agetty-tty6

# Set up ACPI
sudo ln -s /etc/sv/acpid/ /var/service/
sudo sv enable acpid
sudo sv start acpid

# Improve font rendering
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d

# Set up NetworkManager
sudo xbps-install -Sy NetworkManager dbus
if sudo sv status wpa_supplicant >/dev/null 2>&1; then
  sudo sv stop wpa_supplicant
fi

sudo rm -rf /var/services/wpa_supplicant 2>/dev/null
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/NetworkManager /var/service
sudo sv start NetworkManager

# Clone and set up dotfiles
git clone https://github.com/speyll/dotfiles "$HOME/dotfiles"
cp -r "$HOME/dotfiles/."* "$HOME/"
rm -rf "$HOME/dotfiles"
chmod -R +X "$HOME/.local/bin" "$HOME/.local/share/applications" "$HOME/.config/autostart/"
chmod +x "$HOME/.config/yambar/sway-switch-keyboard.sh" "$HOME/.config/yambar/xkb-layout.sh" "$HOME/.config/waybar/sway-switch-keyboard.sh" "$HOME/.config/waybar/xkb-layout.sh" "$HOME/.config/autostart/*" "$HOME/.local/bin/*" 
ln -s "$HOME/.config/mimeapps.list" "$HOME/.local/share/applications/"

# Add user to wheel group for sudo access
sudo echo "%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ" | sudo tee -a /etc/sudoers.d/wheel
