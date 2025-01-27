#!/bin/bash

add_line_if_not_exists() {
    local line="$1"
    local file="$2"

    # Check if the line exists in the file
    if ! grep -Fxq "$line" "$file"; then
        # If the line does not exist, append it to the file
        echo "$line" >> "$file"
    fi
}

add_rc_path () {
    # If you're using another shell you deserve what you get OK?
    add_line_if_not_exists "export PATH=\$PATH:$1" "$HOME/.zshrc"
    add_line_if_not_exists "export PATH=\$PATH:$1" "$HOME/.bashrc"
}

clone_or_update_repo() {
    local REPO_URL="$1"
    local REPO_NAME=$(basename -s .git "$REPO_URL")
    if [ -n "$2" ]; then 
	    local BRANCH="--branch $2"
	    local REPO_NAME="${REPO_NAME}_$2"
    fi
    local TARGET_DIR="/opt/$REPO_NAME"
    sudo mkdir -p $TARGET_DIR
    sudo chown $USER:$USER $TARGET_DIR
    if [ -z "$(ls -A "$TARGET_DIR")" ]; then
        echo "$TARGET_DIR created, but empty, cloning..."
        git clone $BRANCH "$REPO_URL" "$TARGET_DIR"
    else
        echo "Directory $TARGET_DIR already exists. Pulling latest changes..."
        # Navigate to the directory and pull the latest changes
        git -C "$TARGET_DIR" pull
    fi

}

generic_setup() {
    OS=$1

    # Start off with a oh-my-zsh install
    if [ ! -d $HOME/.oh-my-zsh ]; then 
        sudo apt install -y zsh
        CHSH="yes" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="alanpeabody"/g'
    else
        echo "[+] Zsh already configured. Skipping..."
    fi
    
    
    # Tools that get installed at the beggining
    if [ $OS = "kali" ]; then
        echo "Detected Kali Linux. Installing Kali specifics."
        # Base tools first
        sudo DEBIAN_FRONTEND=noninteractiv apt install -y thefuck byobu vim flashrom nmap bashtop python3-pwntools esptool plocate golang-go docker.io rustup python3-venv pipx curl nmap vlc

        # Ensure this is set in $HOME/.config/qterminal.org/qterminal.ini ApplicationTransparency=0
        sed -i '/^ApplicationTransparency=/c\ApplicationTransparency=0' "$HOME/.config/qterminal.org/qterminal.ini" || echo "ApplicationTransparency=0" >> "$HOME/.config/file.ini"
        # Nessus
	if [ ! -f /opt/nessus/sbin/nessusd ]; then
        	curl --request GET --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.8.3-debian10_amd64.deb' --output "$HOME/Nessus-10.8.3-debian10_amd64.deb"
        	sudo dpkg -i "$HOME/Nessus-10.8.3-ubuntu1604_amd64.deb"
	else
 		echo "[+] Nessus already here, skipping install..."
 	fi

        #rtl8812au - Kali and wifitre helpers
        sudo DEBIAN_FRONTEND=noninteractiv apt install -y linux-headers-amd64 realtek-rtl88xxau-dkms hcxdumptool hcxtools

        # Desktop background
        sudo DEBIAN_FRONTEND=noninteractiv apt install pcmanfm -y
        wget -q https://blackfell.net/kali_lincox_mine.png -O $HOME/kali_background.png
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s  $HOME/kali_background.png    
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/last-image-style -s 1
        

    elif [ $OS = "ubuntu" ]; then
        echo "Detected Ubuntu. Installing would-be Kali shit."
        # Base tools first
        sudo DEBIAN_FRONTEND=noninteractiv apt install -y thefuck byobu vim flashrom nmap bashtop  esptool plocate golang-go docker.io  python3-venv pipx curl nmap gnome-tweaks vlc
        sudo snap install rustup --classic
        # Pwntools
        pipx install pwntools
        # Seclists
        clone_or_update_repo https://github.com/danielmiessler/SecLists.git
        sudo ln -s /opt/SecLists /usr/share/seclists/
        # DNSChef
        clone_or_update_repo https://github.com/iphelix/dnschef  
        add_rc_path /opt/dnschef    
        # Responder
        clone_or_update_repo https://github.com/SpiderLabs/Responder
        add_rc_path /opt/Responder
        # Nessus
	if [ ! -f /opt/nessus/sbin/nessusd ] ; then
		curl --request GET --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.8.3-ubuntu1604_amd64.deb'  --output "$HOME/Nessus-10.8.3-ubuntu1604_amd64.debccessories"
	        sudo dpkg -i "$HOME/Nessus-10.8.3-ubuntu1604_amd64.deb"ccessories
	else
 		echo "[+] Nessus already here, skipping install..."
	fi
        # Impacket and nxc
        pipx install impacket
	pipx install netexec
        # Certipy
        pipx install certipy-ad
        # Coercer
        pipx install coercer
        # Bloodhound
        pipx install bloodhound
        # Wifi stuff
        sudo DEBIAN_FRONTEND=noninteractiv apt install wifite rtl8812au-dkms -y
        # Generic hacking tools (snaps)
        sudo snap install metasploit-framework 
        sudo snap install sqlmap 
        sudo snap install code --classic
        
    fi
    
    # Configure rust environment
    rustup default stable
    
    #PMapper
    pipx install principalmapper

    # Kingst
    if [ ! -f /opt/kingstVIS/vis_linux ]; then 
        sudo mkdir -p /opt/kingstVIS 
        pushd /opt/kingstVIS
        sudo chown -R $USER:$USER /opt/kingstVIS        
        wget -q http://www.qdkingst.com/download/vis_linux
        tar -xf vis_linux
        if lsusb | grep -qi 77a1 ; then
            echo "[!] ERROR: You may have a kingst device plugged in, not installing..."
        else
            pushd KingstVIS
            sudo ./install.sh
            popd
        fi
        popd
    fi
    
    # Frida and objection
    pipx install frida-tools
    pipx install objection
    if [ ! -f /opt/frida-server/frida-server-16.5.9-android-arm64.xz ]; then
        sudo mkdir -p /opt/frida-server
        sudo chown -R $USER:$USER /opt/frida-server
        pushd /opt/frida-server
        wget -q https://github.com/frida/frida/releases/download/16.5.9/frida-server-16.5.9-android-arm64.xz
        wget -q https://github.com/frida/frida/releases/download/16.5.9/frida-server-16.5.9-android-arm.xz
        wget -q https://github.com/frida/frida/releases/download/16.5.9/frida-server-16.5.9-android-x86.xz
        wget -q https://github.com/frida/frida/releases/download/16.5.9/frida-server-16.5.9-android-x86_64.xz
        popd
    fi

    # JLink
    if [ ! /opt/JLink/JLink_Linux_x86_64.deb ]; then
        sudo mkdir -p /opt/JLink
        pushd /opt/JLink
        wget -q https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
        sudo dpkg -i ./JLink_Linux_x86_64.deb
        popd
    fi

    # Scout suite
    # YOLO
    pipx install scoutsuite

    # Sliver
    if ! which sliver >/dev/null; then curl https://sliver.sh/install | sudo bash; fi

    # NRF Connect
    if [ ! -f /opt/nrfconnect/nrfconnect-5.1.0-x86_64.appimage ]; then 
        sudo mkdir -p /opt/nrfconnect
        sudo chown -R $USER:$USER /opt/nrfconnect
        pushd /opt/nrfconnect
        wget -q  https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-connect-for-desktop/5-1-0/nrfconnect-5.1.0-x86_64.appimage
        popd
    fi

    # Burpsuite Pro
    wget -q 'https://portswigger-cdn.net/burp/releases/download?product=pro&version=2024.10.3&type=Linux'  -O $HOME/Downloads/burp_installer
    echo "[!] Don't forget to install your own burp (GUI), it's here - $USER/Downloads/burp_installer"


    # Customisation
    if [ "$SHELL" != "/bin/zsh" ]; then
        echo "Changing the current user's shell to zsh..."
        sudo chsh -s /usr/bin/zsh $USER
        echo "Shell changed to zsh. Please log out and log back in for the change to take effect."
    fi
    add_rc_path "$HOME/go/bin"
    add_rc_path "$HOME/.local/bin"
    add_line_if_not_exists "eval \$(thefuck --alias)" "$HOME/.zshrc"
    wget -q https://github.com/Blackfell/ansible-hax/raw/refs/heads/main/roles/bf_arch_base/files/vimrc  -O $HOME/.vimrc
    wget -q https://github.com/Blackfell/ansible-hax/blob/main/roles/bf_arch_desktop/files/BFBackground.png?raw=true  -O $HOME/BFBackground.png
    sudo gsettings set org.gnome.desktop.background picture-uri "file://$HOME/BFBackground.png"

    # Final APT tools
    sudo DEBIAN_FRONTEND=noninteractiv apt install -y  snapd bettercap apktool

    # Snap tools
    sudo systemctl enable --now snapd
    sudo systemctl enable --now snapd.apparmor
    sudo systemctl start snapd
    sudo snap install mqtt-explorer
    add_rc_path /snap/bin

    # Pass the cert
    clone_or_update_repo https://github.com/AlmondOffSec/PassTheCert

}

install_go_tools(){
    # GO Tools for recon and OSINT
    go install github.com/tomnomnom/httprobe@latest
    go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install github.com/sensepost/gowitness@latest
    go install github.com/tomnomnom/assetfinder@latest
    go install github.com/tomnomnom/meg@latest
    go install github.com/tomnomnom/gron@latest
    go install github.com/tomnomnom/waybackurls@latest
    go install github.com/harleo/knockknock@latest
    go install github.com/owasp-amass/amass/v3/...@latest
    # And SSH brute forcing
    go install ktbs.dev/ssb@latest
    # APK URL GREP
    go install github.com/ndelphit/apkurlgrep@latest
}

install_git_tools(){
#### GIT TOOLS ####
    # Helper scripts
    clone_or_update_repo https://github.com/lapolis/helper-scripts
    add_rc_path "/opt/helper-scripts"
    # Ultimate Nmap Parser
    clone_or_update_repo https://github.com/shifty0g/ultimate-nmap-parser
    add_rc_path "/opt/ultimate-nmap-parser"
    if [ ! -d "/opt/ultimate-nmap-parser/venv" ]; then
        echo "[+] - Installing Nmap Parser Deps..."
        pushd "/opt/ultimate-nmap-parser/"
        python3 -m venv venv
        source venv/bin/activate
        python3 -m pip install -r requirements.txt
        popd
    else
        echo "[+] - Skipping Nmap Parser Deps. Already done..."
    fi
    # Binwalk v3.1.0
    clone_or_update_repo "https://github.com/ReFirmLabs/binwalk" "v3.1.0"
    if [ ! -f "/opt/binwalk_v3.1.0/binwalkv3" ]; then
        pushd "/opt/binwalk_v3.1.0"
        python3 -m venv venv
        source venv/bin/activate
        sudo dependencies/ubuntu.sh
        rustup deafult stable
        cargo build --release
        deactivate
        popd
        ln -s "/opt/binwalk_v3.1.0/target/release/binwalk" "/opt/binwalk_v3.1.0/binwalkv3"
    else
        echo "[+] - Skipping Binlwalk build. Already done..."
    fi
    add_rc_path "/opt/binwalk_v3.1.0/"

    #bloodhound - old version  ly4k with certipy support
    sudo mkdir -p /opt/bloodhoundly4k 
    if [ ! -f /opt/bloodhoundly4k/BloodHound-linux-x64/BloodHound ]; then
        pushd /opt/bloodhoundly4k
        echo "[-] Downloading Bloodhound, please wait..."
        sudo wget -q https://github.com/ly4k/BloodHound/releases/download/v4.2.0-ly4k/BloodHound-linux-x64.zip -O /opt/bloodhoundly4k/BloodHound-x64lin.zip
        sudo unzip /opt/bloodhoundly4k/BloodHound-x64lin.zip 
	sudo chmod -R 04755 /opt/bloodhoundly4k/BloodHound-linux-x64/chrome-sandbox
        # Sadly there's a directory in the zip
        add_line_if_not_exists "alias bloodhound-nosandbox='/opt/bloodhoundly4k/BloodHound-linux-x64/BloodHound --no-sandbox'" "$HOME/.zshrc" 
        popd
    fi

    # Not-Really-Git-Ghidra (used to do Nessus but now separate)
    if [ ! -f /opt/Ghidra11.2.1/ghidra_11.2.1_PUBLIC/ghidraRun ]; then
        sudo mkdir -p /opt/Ghidra11.2.1 && sudo chown -R $USER:$USER /opt/Ghidra11.2.1
        pushd /opt/Ghidra11.2.1
        echo "[-] Downloading Ghidra, please wait..."
        wget -q https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2.1_build/ghidra_11.2.1_PUBLIC_20241105.zip -O ghidra_11.2.1_PUBLIC_20241105.zip
        7z x ghidra_11.2.1_PUBLIC_20241105.zip
        popd
    fi

    # Not-Really-git-Jadx
    if [ ! -f /opt/jadx/bin/jadx ]; then
        sudo mkdir -p /opt/jadx && sudo chown $USER:$USER /opt/jadx
        pushd /opt/jadx
        echo "[-] Downloading Jadx, please wait..."
        wget -q https://github.com/skylot/jadx/releases/download/v1.5.1/jadx-1.5.1.zip -O jadx-1.5.1.zip
    7z x jadx-1.5.1.zip
    popd
    fi

    # Not-Really-Git-proxmark3
    if [ ! -f /opt/proxmark3/pm3 ]; then
        sudo DEBIAN_FRONTEND=noninteractiv apt install -y --no-install-recommends git ca-certificates build-essential pkg-config \
            libreadline-dev gcc-arm-none-eabi libnewlib-dev qtbase5-dev \
            libbz2-dev liblz4-dev libbluetooth-dev libpython3-dev libssl-dev libgd-dev
        sudo systemctl stop ModemManager
        sudo systemctl disable ModemManager
        sudo DEBIAN_FRONTEND=noninteractiv apt remove modemmanager -y
        clone_or_update_repo https://github.com/RfidResearchGroup/proxmark3
        pushd /opt/proxmark3
        make accessrights # Give write to serial device
        make clean && make -j
        popd 
    fi

    #john
    clone_or_update_repo https://github.com/openwall/john
    pushd /opt/john/src
    ./configure && make -sj$(nproc)
    popd

    #linux-router - TODO add custom redirect scripts
    clone_or_update_repo https://github.com/garywill/linux-router

    # Sniffrom
    clone_or_update_repo https://github.com/alainiamburg/sniffROM

    # Ysoserial
    clone_or_update_repo https://github.com/frohoff/ysoserial

    # Snafflepy
    clone_or_update_repo https://github.com/asmtlab/snafflepy
    add_rc_path /opt/snafflepy

    # ESP32 image parser 
    clone_or_update_repo https://github.com/tenable/esp32_image_parser
    for pkg in $(cat /opt/esp32_image_parser/requirements.txt); do pipx install $pkg; done
    add_rc_path /opt/esp32_image_parser

    # Radamsa
    sudo DEBIAN_FRONTEND=noninteractiv apt install gcc make git wget -y
    clone_or_update_repo https://gitlab.com/akihe/radamsa
    if [ ! -f /opt/radamsa/bin/radamsa ]; then
        pushd /opt/radamsa
        sudo make install 
        popd
    fi
    add_rc_path /opt/radamsa/bin/radamsa

    # PEASS-ng
    clone_or_update_repo https://github.com/peass-ng/PEASS-ng
    if [ ! -f /opt/PEASS-ng/linpeas.sh ]; then
        pushd /opt/PEASS-ng
        echo "[-] Downloading PEASS archives, please wait..."
        wget -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/linpeas.sh
        wget -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/linpeas_fat.sh
        wegt -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/linpeas_linux_amd64
        wget -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/winPEASany.exe
        wget -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/winPEAS.bat
        wget -q https://github.com/peass-ng/PEASS-ng/releases/download/20241205-c8c0c3e5/winPEASany_ofs.exe
        popd
    fi

    # Flashprog
    clone_or_update_repo https://github.com/SourceArcade/flashprog
    if [ ! -f /opt/flashprog/flashprog ]; then 
        pushd /opt/flashprog 
        sudo DEBIAN_FRONTEND=noninteractiv apt install libpci-dev libftdi-dev libftdi1-dev libftdi1 libusb-1.0-0 libusb-1.0-0-dev libusb-dev libjaylink-dev  libgpiod-dev pkgconf -y
        make 
        popd
    fi


}

####### MAIN ########

# Logging
LOGFILE="/tmp/bfstrap.log"
echo "[+] Saving all output to $LOGFILE"
exec > >(tee -a $LOGFILE) 2>&1

# Determine the OS
if grep -iq "ubuntu" /etc/os-release; then
    OS="ubuntu"
elif grep -iq "kali" /etc/os-release; then
    OS="kali"
else
    echo "[!] This script is for Ubuntu or Kali. If you want to use it with another OS, edit it yourself."
    exit 1
fi

generic_setup $OS
install_git_tools
install_go_tools

echo "[+] Done. You can check the log - $LOGFILE"
