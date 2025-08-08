#!/data/data/com.termux/files/usr/bin/bash

clear

echo -e "\e[34mInstalling Java 8 JDK from HYPER12755's repo...\e[0m"
echo

# Check if Java is already installed
if [ -e $PREFIX/bin/java ]; then
  echo -e "\e[32mJava is already installed!\e[0m"
  exit 0
fi

# Detect architecture
ARCH=$(dpkg --print-architecture)

case "$ARCH" in
  aarch64|arm64)
    ARCH_NAME="aarch64"
    TAG="java_aarch"
    ;;
  arm|armhf|armv7l)
    ARCH_NAME="arm"
    TAG="Java"
    ;;
  *)
    echo -e "\e[31mERROR: Unsupported architecture: $ARCH\e[0m"
    exit 1
    ;;
esac

echo -e "\e[32m[*] Downloading Java 8 JDK for architecture: $ARCH_NAME\e[0m"

# Compose download URL based on your repo structure
JDK_FILENAME="jdk8_${ARCH_NAME}.tar.gz"
DOWNLOAD_URL="https://github.com/HYPER12755/Termux-JDK8/releases/download/${TAG}/${JDK_FILENAME}"

wget -q --show-progress "$DOWNLOAD_URL" -O "$JDK_FILENAME"
if [ $? -ne 0 ]; then
  echo -e "\e[31mFailed to download JDK from $DOWNLOAD_URL\e[0m"
  exit 1
fi

echo -e "\e[32m[*] Extracting JDK to $PREFIX/share/jdk8\e[0m"

mkdir -p "$PREFIX/share/jdk8"
tar -xzf "$JDK_FILENAME" -C "$PREFIX/share/jdk8" --strip-components=1
if [ $? -ne 0 ]; then
  echo -e "\e[31mFailed to extract JDK archive\e[0m"
  rm -f "$JDK_FILENAME"
  exit 1
fi

rm -f "$JDK_FILENAME"

# Set JAVA_HOME and update .profile if not set
if ! grep -q "export JAVA_HOME=" "$HOME/.profile"; then
  echo "export JAVA_HOME=$PREFIX/share/jdk8" >> "$HOME/.profile"
  echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> "$HOME/.profile"
fi

# Export for current session
export JAVA_HOME="$PREFIX/share/jdk8"
export PATH="$JAVA_HOME/bin:$PATH"

echo -e "\e[32m[*] Java installation completed!\e[0m"
echo -e "\e[33mPlease restart Termux or run: source ~/.profile\e[0m"
echo

exit 0