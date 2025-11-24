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

pipx_fuckery () {
    # Check if a tool is installed, if not install, if so update
    if pipx list | grep $1 | grep installed ; then
        pipx upgrade $1
    else
        pipx install $1
    fi
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
        echo "[!] - fresh clone of $REPO_URL"
        echo "$TARGET_DIR created, but empty, cloning..."
        git clone $BRANCH "$REPO_URL" "$TARGET_DIR"
	return 1	# if true we'll run build
    else
        echo "Directory $TARGET_DIR already exists. Pulling latest changes..."
        # Navigate to the directory and pull the latest changes
        if git -C "$TARGET_DIR" pull | grep -v "Already up-to-date"; then CHANGED=0; else CHANGED=1; fi
 	if $CHANGED; then echo "[!] - Repo $REPO_URL at $TARGET_DIR is changed! Will build again if needed."; else echo "[+] - Repo $REPO_URL at $TARGET_DIR is not changed."; fi
	return $CHANGED # returns true if a change has happened so we'll build again
    fi

}

kali_install() {
	echo "Detected Kali Linux. Installing Kali specifics."
	# Base tools first
	sudo DEBIAN_FRONTEND=noninteractiv apt install -y thefuck byobu vim flashrom nmap bashtop python3-pwntools esptool plocate golang-go docker.io rustup python3-venv pipx curl nmap vlc

	# Ensure this is set in $HOME/.config/qterminal.org/qterminal.ini ApplicationTransparency=0
	sed -i '/^ApplicationTransparency=/c\ApplicationTransparency=0' "$HOME/.config/qterminal.org/qterminal.ini" || echo "ApplicationTransparency=0" >> "$HOME/.config/file.ini"
	# Nessus
	if [ ! -f /opt/nessus/sbin/nessusd ]; then
			curl --request GET --url 'https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/27148/download?i_agree_to_tenable_license_agreement=true' --output "$HOME/Nessus-10.8.3-debian10_amd64.deb"
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
}

ubuntu_install() {
	echo "Detected Ubuntu. Installing would-be Kali shit."
	# Base tools first
	sudo DEBIAN_FRONTEND=noninteractiv apt install -y thefuck byobu vim flashrom nmap bashtop traceroute esptool plocate golang-go docker.io  python3-venv pipx curl nmap hydra medusa gnome-tweaks vlc openssh-server wireshark netdiscover rpcbind testssl.sh jython
	sudo snap install rustup --classic
	# ensure pipx path
	add_rc_path "/home/blackfell/.local/bin"
	# Pwntools
	pipx_fuckery pwntools
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
		curl --request GET --url 'https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/27148/download?i_agree_to_tenable_license_agreement=true'  --output "$HOME/Nessus-10.8.3-ubuntu1604_amd64.deb"
			sudo dpkg -i "$HOME/Nessus-10.8.3-ubuntu1604_amd64.deb"
	else
		echo "[+] Nessus already here, skipping install..."
	fi
	# Impacket and nxc
	pipx_fuckery impacket
	# NXC is from git so different install procedure...
	if pipx list | grep ncx | grep installed; then
			pipx upgrade git+https://github.com/Pennyw0rth/NetExec
	else
		pipx install git+https://github.com/Pennyw0rth/NetExec
	fi
	# Certipy
	pipx_fuckery certipy-ad
	# Coercer
	pipx_fuckery coercer
	# Bloodhound
	pipx_fuckery bloodhound
	# PyWerview
	pipx_fuckery pywerview
	# Wifi stuff
	sudo DEBIAN_FRONTEND=noninteractiv apt install wifite rtl8812au-dkms -y
	# Generic hacking tools (snaps)
	sudo snap install metasploit-framework 
	sudo snap install sqlmap 
	sudo snap install code --classic
	sudo snap install searchsploit
	sudo snap install crackmapexec

	# Web tooling
	cargo install feroxbuster
}

generic_setup() {
    OS=$1
    # Start off with a oh-my-zsh install
    if [ ! -d $HOME/.oh-my-zsh ]; then 
        echo "[+] Installing oh-my-zsh"
        sudo apt install -y zsh
        CHSH="yes" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="alanpeabody"/g' $HOME/.zshrc
    else
        echo "[+] Zsh already configured. Skipping..."
    fi
    
    # stuff that needs to be OS specific
    if [ $OS = "kali" ]; then
        kali_install
    elif [ $OS = "ubuntu" ]; then
        ubuntu_install        
    fi

	# STUFF THAT IS OS GENERIC
	
    # Some general APT tools on both OS
    sudo DEBIAN_FRONTEND=noninteractiv apt install -y  snapd bettercap apktool hostapd qemu-system qemu-user mitmproxy cmake hashcat-nvidia hcxtools openocd gqrx-sdr inspectrum minicom picocom lsscsi  pcscd libacsccid1 libccid  pcsc-tools cardpeek cardpeek-data tio
    # FS Tools
    sudo DEBIAN_FRONTEND=noninteractiv apt install -y fusecram fusefat fuseiso fuse2fs
	
	# OT tools
	pipx_fuckery opcua-client
	clone_or_update_repo https://github.com/meeas/plcscan
	clone_or_update_repo https://github.com/klsecservices/s7scan
	clone_or_update_repo https://github.com/mssabr01/sixnet-tools/tree/new_master/SIXNET%20tools
    
    # Configure rust environment
    rustup default stable
    
    #PMapper
    pipx_fuckery principalmapper

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

    # Saleae
    if [ ! -f /opt/saleae/log ]; then
        sudo mkdir -p /opt/saleae 
        pushd /opt/saleae
        sudo chown -R $USER:$USER /opt/saleae
        wget -q https://downloads2.saleae.com/logic2/Logic-2.4.29-linux-x64.AppImage
        sudo chmod +x /opt/saleae/Logic-2.4.29-linux-x64.AppImage
        echo '#!/bin/bash' | sudo tee /opt/saleae/logic > /dev/null
		echo "sudo /opt/saleae/Logic-2.4.29-linux-x64.AppImage --no-sandbox" | sudo tee /opt/saleae/logic > /dev/null
        sudo chmod +x /opt/saleae/logic
		add_rc_path /opt/saleae/logic
        popd
    fi
    
    
    # Mobile incl. Frida and objection
    sudo DEBIAN_FRONTEND=noninteractiv apt install -y adb apktool apksigner aapt
    pipx_fuckery frida-tools
    pipx_fuckery objection
    if [ ! -f /opt/frida-server/frida-server-17.2.17-android-arm.xz ]; then
        sudo mkdir -p /opt/frida-server
        sudo chown -R $USER:$USER /opt/frida-server
        pushd /opt/frida-server
        wget -q https://github.com/frida/frida/releases/download/17.2.17/frida-server-17.2.17-android-arm64.xz 
        wget -q https://github.com/frida/frida/releases/download/17.2.17/frida-server-17.2.17-android-arm.xz
        wget -q https://github.com/frida/frida/releases/download/17.2.17/frida-server-17.2.17-android-x86.xz
        wget -q https://github.com/frida/frida/releases/download/17.2.17/frida-server-17.2.17-android-x86_64.xz
        popd
    fi
    # Scout suite
    # YOLO
    pipx_fuckery scoutsuite

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


    # Snap tools
    sudo systemctl enable --now snapd
    sudo systemctl enable --now snapd.apparmor
    sudo systemctl start snapd
    sudo snap install mqtt-explorer
    add_rc_path /snap/bin

    # Pass the cert
    clone_or_update_repo https://github.com/AlmondOffSec/PassTheCert

    # Documentation
    sudo snap install --classic obsidian
    clone_documentation https://github.com/Pennyw0rth/NetExec-Wiki
    clone_documentation https://github.com/HackTricks-wiki/hacktricks

    # Segger
    if which JLinkExe>/dev/null; then 
        echo "[+] - JLink already installed, skipping..."
    else
         echo "[!] - JLink not found. Installing..."
        sudo mkdir -p /opt/segger
        sudo curl -X POST https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb --data-raw 'accept_license_agreement=accepted&submit=Download+software'  -o /opt/segger/JLink_Linux_x86_64.deb
        sudo dpkg -i /opt/segger/JLink_Linux_x86_64.deb
    fi

	# Cynthion
	sudo DEBIAN_FRONTEND=noninteractiv apt install -y nextpnr-ecp5 yosys tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev fgpa-trellis
	pipx_fuckery cynthion
	sudo mkdir -p /opt/packetry
	sudo wget https://github.com/greatscottgadgets/packetry/releases/download/v0.5.0/packetry-x86_64.AppImage -O /opt/packetry/packetry-x86_64_v0.5.0.AppImage
	sudo chmod +x /opt/packetry/packetry-x86_64_v0.5.0.AppImage
}

clone_documentation() {
    # Documentation - args are $1 repo and $2 (optional) name to clone to in /opt/bfdocs
    sudo mkdir -p /opt/bfdocs
    sudo chown -R $USER:$USER /opt/bfdocs
    local REPO_URL="$1"
    local REPO_NAME=$(basename -s .git "$REPO_URL")
    if [ -n "$2" ]; then 
	    local REPO_NAME="${REPO_NAME}_$2"
    fi
    local TARGET_DIR="/opt/bfdocs/$REPO_NAME"
    sudo mkdir -p $TARGET_DIR
    sudo chown $USER:$USER $TARGET_DIR
    if [ -z "$(ls -A "$TARGET_DIR")" ]; then
        echo "$TARGET_DIR created, but empty, cloning..."
        git clone "$REPO_URL" "$TARGET_DIR"
    else
        echo "Directory $TARGET_DIR already exists. Pulling latest changes..."
        # Navigate to the directory and pull the latest changes
        git -C "$TARGET_DIR" pull
    fi
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
        echo "[!] - Binwalk not found. Installing..."
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
        wget -q https://github.com/skylot/jadx/releases/download/v1.5.3/jadx-1.5.3.zip -O jadx-1.5.3.zip
		7z x jadx-1.5.3.zip
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

	# Proxmark Chameleon Ultra
	if [ ! -f /opt/ChameleonUltra/software/script/run.sh ]; then
		clone_or_update_repo https://github.com/RfidResearchGroup/ChameleonUltra
  		mkdir -p /opt/ChameleonUltra/software/src/out
		pushd /opt/ChameleonUltra/software/src/out
    	cmake ..
    	cmake --build . --config Release
		cd /opt/ChameleonUltra/software/script
  		python3 -m venv venv
  		source venv/bin/activate
  		pip3 install -r requirements.txt
  		deactivate
		echo '#!/bin/bash' > /opt/ChameleonUltra/software/script/run.sh
		echo 'pushd /opt/ChameleonUltra/software/script' >> /opt/ChameleonUltra/software/script/run.sh
		echo 'source venv/bin/activate' >> /opt/ChameleonUltra/software/script/run.sh
		echo 'python3 chameleon_cli_main.py' >> /opt/ChameleonUltra/software/script/run.sh
		echo 'deactivate' >> /opt/ChameleonUltra/software/script/run.sh
		echo 'popd' >> /opt/ChameleonUltra/software/script/run.sh
		chmod +x /opt/ChameleonUltra/software/script/run.sh
  		popd
	fi

    #john
    if clone_or_update_repo https://github.com/openwall/john; then
    	pushd /opt/john/src
    	./configure && make -sj$(nproc)
        cd /opt/john
	    python3 -m venv johnvenv
        source /opt/john/johnvenv/bin/activate
	    python -m pip install -r requirements.txt
    	popd
     fi

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
    if clone_or_update_repo https://github.com/tenable/esp32_image_parser; then
    	python3 -m pip install -r /opt/esp32_image_parser/requirements.txt --break-system-packages
    	add_rc_path /opt/esp32_image_parser
     fi

    # Radamsa
    sudo DEBIAN_FRONTEND=noninteractiv apt install gcc make git wget -y
    if clone_or_update_repo https://gitlab.com/akihe/radamsa; then 
        pushd /opt/radamsa
        sudo make install 
        popd
        add_rc_path /opt/radamsa/bin/radamsa
    fi

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
    if clone_or_update_repo https://github.com/SourceArcade/flashprog; then  
        pushd /opt/flashprog 
        sudo DEBIAN_FRONTEND=noninteractiv apt install libpci-dev libftdi-dev libftdi1-dev libftdi1 libusb-1.0-0 libusb-1.0-0-dev libusb-dev libjaylink-dev  libgpiod-dev pkgconf -y
        make 
        popd
    fi

    # Ubertooth 
    if which ubertooth-util>/dev/null; then 
        echo "[+] - Ubertooth already installed, skipping..."
    else
        echo "[!] - Ubertooth not found. Installing..."
        sudo DEBIAN_FRONTEND=noninteractiv apt install -y cmake libusb-1.0-0-dev make gcc g++ libbluetooth-dev wget pkg-config python3-numpy python3-qtpy python3-distutils python3-setuptools
        #libbtbb bit
        sudo mkdir -p /opt/libbtbb
        sudo chown -R $USER:$USER /opt/libbtbb
        wget https://github.com/greatscottgadgets/libbtbb/archive/2020-12-R1.tar.gz -O /opt/libbtbb/libbtbb-2020-12-R1.tar.gz
        pushd /opt/libbtbb
        tar -xf libbtbb-2020-12-R1.tar.gz
        cd libbtbb-2020-12-R1
        mkdir -p build
        cd build
        cmake ..
        # Probably the worst little build fix I've ever done in my whole life, sorry...
        sed -i "s/version\s*=\s*''/version\t\t= '0.5'/g" /opt/libbtbb/libbtbb-2020-12-R1/build/python/pcaptools/setup.py
        make
        sudo make install
        sudo ldconfig
        popd
    
        # Main ubertooth app
        sudo mkdir -p /opt/ubertooth
        sudo chown -R $USER:$USER /opt/ubertooth
        pushd  /opt/ubertooth
        wget https://github.com/greatscottgadgets/ubertooth/releases/download/2020-12-R1/ubertooth-2020-12-R1.tar.xz
        tar -xf ubertooth-2020-12-R1.tar.xz
        cd ubertooth-2020-12-R1/host
        mkdir -p build
        cd build
        cmake ..
        # Clearly I wasn't that sorry because I make a horrific jank fix a second time
        sed -i "s/version\s*=\s*''/version\t\t= '0.5'/g"  /opt/ubertooth/ubertooth-2020-12-R1/host/build/python/specan_ui/setup.py
        make
        sudo make install
        sudo ldconfig
        popd

 	# Udev rule for access:
        echo 'ACTION=="add" BUS=="usb" SYSFS{idVendor}=="1d50" SYSFS{idProduct}=="6002" GROUP:="plugdev" MODE:="0660"' | sudo tee /etc/udev/rules.d/99-ubertooth.rules
	    sudo udevadm control --reload-rules
    fi

    # NCC Sniffle for sonoff sniffer
    if [  ! -d /opt/sniffle/Sniffle-1.10.0/python_cli  ]; then
        echo "[+] - Sniffle not installed! Installing at 1.10.0..."
        sudo mkdir -p /opt/sniffle
        sudo chown -R $USER:$USER /opt/sniffle
        pushd /opt/sniffle
	    wget https://github.com/nccgroup/Sniffle/releases/download/v1.10.0/sniffle_cc1352p1_cc2652p1_1M.hex
        git clone https://github.com/sultanqasim/cc2538-bsl.git # The flashign util in case we need it
        wget https://github.com/nccgroup/Sniffle/archive/refs/tags/v1.10.0.tar.gz
        tar xvf v1.10.0.tar.gz
	    # Install Wireshark extcap for user and root only
	    mkdir -p $HOME/.local/lib/wireshark/extcap
        ln -s /opt/sniffle/Sniffle-1.10.0/python_cli/sniffle_extcap.py $HOME/.local/lib/wireshark/extcap
        sudo mkdir -p /root/.local/lib/wireshark/extcap
        sudo ln -s /opt/sniffle/Sniffle-1.10.0/python_cli/sniffle_extcap.py /root/.local/lib/wireshark/extcap
        popd
    else
        echo "[+] - Sniffle already installed at 1.10.0"
    fi

    # Zephyr for NRF Dev Kits
    if [  ! -d /opt/zephyr ]; then
	    sudo mkdir -p /opt/zephyr
	    sudo chown -R $USER:$USER /opt/zephyr
	    pushd /opt/zephyr
	    # Get nrfUtil if you don't already
	    sudo wget https://files.nordicsemi.com/ui/api/v1/download?repoKey=swtools&path=external/nrfutil/executables/x86_64-unknown-linux-gnu/nrfutil&isNativeBrowsing=false -O /usr/local/bin/nrfutil
	    sudo chmod 0755 /usr/local/bin/nrfutil
	    nrfutil install device 
	    nrfutil install completion
	    nrfutil completion install zsh
	    nrfutil completion install bash
	    wget https://github.com/NordicSemiconductor/nrf-udev/releases/download/v1.0.1/nrf-udev_1.0.1-all.deb -O nrf-udev_1.0.1-all.deb
	    sudo dpkg -i nrf-udev_1.0.1-all.deb
	    # You may need Segger installed, let's do that anyway 
	    sudo mkdir -p /opt/segger
	    sudo curl -X POST https://www.segger.com/downloads/jlink/JLink_Linux_V818_x86_64.deb --data-raw 'accept_license_agreement=accepted&submit=Download+software'  -o /opt/segger/JLink_Linux_V818_x86_64.deb
	    sudo dpkg -i /opt/segger/JLink_Linux_V818_x86_64.deb
	    # Main Zephyr install
	    sudo DEBIAN_FRONTEND=noninteractiv apt install --no-install-recommends git cmake ninja-build gperf \
	         ccache dfu-util device-tree-compiler wget \
	        python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
	        xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1 \
	        python3-venv ninja-build -y
	    python3 -m venv /opt/zephyr/.venv
	    source /opt/zephyr/.venv/bin/activate
	    pip install west
	    west init /opt/zephyr
	    west update
	    west zephyr-export
	    pip install -r /opt/zephyr/zephyr/scripts/requirements.txt
	    # Install the zephyr project SDK into /opt, rather than $HOME
	    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.0/zephyr-sdk-0.16.0_linux-x86_64.tar.xz
	    if wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.0/sha256.sum | shasum --check --ignore-missing ; then
	        echo '[+] SDK downloaded OK.'
	        tar xvf zephyr-sdk-0.16.0_linux-x86_64.tar.xz
	        # Now actually move it into /opt
	        sudo mv zephyr-sdk-0.16.0 /opt
	        pushd /opt/zephyr-sdk-0.16.0
	        ./setup.sh
	        # Apply udev rules
	        sudo /opt/zephyr-sdk-0.16.0/sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d
	        sudo udevadm control --reload
	       popd
	    else
	        echo '[!] SDK download checksum failed. You are on your own, sorry...'
	    fi
	    popd  # In case you were doing something beforehand - youre' welcome
    else
     	echo "[+] Zephyr already installed, skipping..."
    fi

    # Chipwhisperer
    if [ ! -d /opt/chipwhisperer ]; then
    	clone_or_update_repo https://github.com/newaetech/chipwhisperer 
     	sudo DEBIAN_FRONTEND=noninteractiv apt install make git avr-libc gcc-avr \
    		gcc-arm-none-eabi libusb-1.0-0-dev usbutils python3 python3-venv python3-dev \
      		libnewlib-arm-none-eabi  -y
        # Venv
        pushd /opt/chipwhisperer
        python3 -m venv .cwvenv
        source /opt/chipwhisperer/.cwvenv/bin/activate
        # UDev rules
        sudo cp 50-newae.rules /etc/udev/rules.d/50-newae.rules
        sudo udevadm control --reload-rules
        sudo groupadd -f chipwhisperer
        sudo usermod -aG chipwhisperer $USER
        sudo usermod -aG plugdev $USER
        git submodule update --init jupyter
        # Deps
        python -m pip install -e .
        python -m pip install -r jupyter/requirements.txt
            echo "#!/usr/bin/env bash" | tee /opt/chipwhisperer/chipwhisperer_notebook
        echo "source /opt/chipwhisperer/.cwvenv/bin/activate" | tee -a /opt/chipwhisperer/chipwhisperer_notebook
        echo "pushd /opt/chipwhisperer/" | tee -a /opt/chipwhisperer/chipwhisperer_notebook
        echo "jupyter notebook" | tee -a /opt/chipwhisperer/chipwhisperer_notebook
        echo "deactivate" | tee -a /opt/chipwhisperer/chipwhisperer_notebook
        echo "popd" | tee -a /opt/chipwhisperer/chipwhisperer_notebook
        chmod +x /opt/chipwhisperer/chipwhisperer_notebook
        add_rc_path /opt/chipwhisperer/
    else
     	clone_or_update_repo https://github.com/newaetech/chipwhisperer # always pull latest
	echo "[+] Chipwhisperer already installed, skipping..."
    fi

    # scsi SIM card reader
    clone_or_update_repo https://github.com/ccoff/scsisim

    # JWT Tool
    if [ ! -f /opt/jwt_tool/bin/jwttool ]; then
        clone_or_update_repo https://github.com/ticarpi/jwt_tool
        pushd /opt/jwt_tool
        echo "[-] Installing JWT tool in venv..."
        python3 -m venv jwtvenv
	source jwtvenv/bin/activate
 	python3 -m pip install -r requirements.txt
  	mkdir /opt/jwt_tool/bin
  	echo -e '#!/usr/bin/env bash\nsource /opt/jwt_tool/jwtvenv/bin/activate\n/opt/jwt_tool/jwt_tool.py $@\ndeactivate' > /opt/jwt_tool/bin/jwttool
   	chmod +x /opt/jwt_tool/bin/jwttool
	add_rc_path /opt/jwt_tool/bin
  	deactivate
        popd
    fi 

 	# Android unpinner
  	clone_or_update_repo https://github.com/mitmproxy/android-unpinner.git
    if [ ! -f /opt/android-unpinner/unpinvenv ]; then
		pushd /opt/android-unpinner
        python3 -m venv unpinvenv
		source unpinvenv/bin/activate
		pip install -e .
  		deactivate
		popd
    fi

	if clone_or_update_repo https://github.com/gchq/CyberChef; then 
 		echo "[+] Changes to Cyberchef source, building..."
 		pushd /opt/CyberChef
		sudo docker build --tag cyberchef --ulimit nofile=10000 .
  		echo '#!/usr/bin/env bash' > /opt/CyberChef/run.sh
 		echo "sudo docker run -dt -p 8888:80 cyberchef" >> /opt/CyberChef/run.sh
   		echo "open http://127.0.0.1:8888" >> /opt/CyberChef/run.sh
		chmod +x /opt/CyberChef/run.sh
 		popd
   	else
		echo "[+] Cyberchef already built, continuing..."
  	fi

   clone_or_update_repo https://github.com/Pwnistry/Windows-Exploit-Suggester-python3 # https://github.com/AonCyberLabs/Windows-Exploit-Suggester
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

# Refresh apt then go!
sudo apt update 
generic_setup $OS
install_git_tools
install_go_tools

echo "[+] Done. You can check the log - $LOGFILE"
