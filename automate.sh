#!/bin/sh
# this is a personal script to automate some system settings

getkeyboard() { \
    rm -rf 00-keyboard.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/00-keyboard.conf
    sudo mv 00-keyboard.conf /etc/X11/xorg.conf.d/
}

gettouchpad() { \
    while true; do
        read -p "Install touchpad config? " yn
        case $yn in
            [Yy]* ) gettouchpadconf; getlibinput;;
            [Nn]* ) getlibinput;;
            * ) echo "Please answer yes or no.";;
        esac
    done
        }

gettouchpadconf() { \
    rm -rf 30-touchpad.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/30-touchpad.conf
    sudo mv 30-touchpad.conf /etc/X11/xorg.conf.d/
}

getlibinput() { \
    while true; do
        read -p "Install libinput config? " yn
        case $yn in
            [Yy]* ) getlibinputconf; getintel;;
            [Nn]* ) getintel;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

getlibinputconf() { \
    rm -rf 40-libinput.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/40-libinput.conf
    sudo mv 40-libinput.conf /usr/share/X11/xorg.conf.d/
}

getintel() { \
    while true; do
        read -p "Install intel config? " yn
        case $yn in
            [Yy]* ) getintelconf; getmonitor;;
            [Nn]* ) getmonitor;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

getintelconf() { \
    rm -rf 99-intel.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/99-intel.conf
    sudo mv 99-intel.conf /etc/X11/xorg.conf.d/
}

getmonitor() { \
    while true; do
        read -p "Install monitor config? " yn
        case $yn in
            [Yy]* ) getmonitorconf; getasound;;
            [Nn]* ) getasound;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

getmonitorconf() { \
    rm -rf 10-monitor.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/10-monitor.conf
    sudo mv 10-monitor.conf /etc/X11/xorg.conf.d/
}

getasound () { \
    while true; do
        read -p "Install alsamixer config? " yn
        case $yn in
            [Yy]* ) getasoundconf; getwpa;;
            [Nn]* ) getwpa;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

getasoundconf () { \
    rm -rf asound.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/asound.conf
    sudo mv asound.conf /etc/
}

getwpa () { \
    while true; do
        read -p "Install wpa config? " yn
        case $yn in
            [Yy]* ) getwpaconf; echo 'all done! have a nice day'; exit;;
            [Nn]* ) echo 'all done! have a nice day!'; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

getwpaconf () { \
    rm -rf asound.conf
    axel https://gist.githubusercontent.com/Speyll/c5e493927697f7e28b0b5527acfeae1d/raw/wpa_supplicant.conf
    sudo mv wpa_supplicant.conf /etc/wpa_supplicant/
}

while true; do
    read -p "Install keyboard config? " yn
    case $yn in
        [Yy]* ) getkeyboard; gettouchpad;;
        [Nn]* ) gettouchpad;;
        * ) echo "Please answer yes or no.";;
    esac
done
