#!/data/data/com.termux/files/usr/bin/bash

echo -e "\e[34mInstalling Java"
echo -e "\e[32mGive Some Time To Install Java 8!\n"

# Check if already installed
if command -v java &> /dev/null; then
    echo -e "\e[32mJava is already installed!\n"
    exit 0
fi

# Detect architecture
case "$(dpkg --print-architecture)" in
    aarch64) archname="aarch64"; tag="java_aarch" ;;
    arm64)   archname="aarch64"; tag="java_aarch" ;;
    armhf)   archname="arm"; tag="java" ;;
    armv7l)  archname="arm"; tag="java" ;;
    arm)     archname="arm"; tag="java" ;;
    *) echo -e "\e[91mERROR: Unknown architecture."; exit 1 ;;
esac

clear
echo -e "\e[32m[*] \e[34mDownloading Java 8 for Termux..."
wget -q "https://github.com/h4ck3r0/Java-termux/releases/download/${tag}/JDK8_${>
    echo -e "\e[91mDownload failed!"; exit 1;
}

echo -e "\e[32m[*] \e[34mMoving JDK to system..."
mv "jdk8_${archname}.tar.gz" "$PREFIX/share"

echo -e "\e[32m[*] \e[34mExtracting JDK..."
cd "$PREFIX/share" || exit
tar -xhf "jdk8_${archname}.tar.gz"
