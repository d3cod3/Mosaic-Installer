#!/bin/bash

###############################################################################
# 	----------------------------------------------------------
#   Mosaic | OF Visual Patching Developer Platform
#
#	  Copyright (c) 2024 Emanuele Mazza aka n3m3da
#
#	  Mosaic is distributed under the MIT License. This gives everyone the
#   freedoms to use Mosaic in any context: commercial or non-commercial,
#   public or private, open or closed source.
#
#   See https://github.com/d3cod3/Mosaic for documentation
#	  ----------------------------------------------------------
#
#
#	  Mosaic auto update script for linux boxes
#   ( works only after using mosaic_installer.sh script )
#
#
###############################################################################


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo "\"${last_command}\" command failed with exit code $?."

###############################################################################
# Check if running with sudo
if [ $(id -u) != 0 ]; then
    echo -e "\nMosaic updater script must be run with super-user privileges."
    echo -e "\nUsage:\nsudo "$0"\n"
    exit $exit_code
    exit 1
fi

###############################################################################
# VARS
USERHOME="$( echo ~ )"
LOCALUSERNAME="$( who | awk '{print $1}' )"
INSTALLFOLDER=/opt
OFFOLDERNAME=openFrameworks

NPROC="$( nproc )"
NUMPU="1"
if [ $NPROC -gt "1" ]; then
    NUMPU="$( expr $NPROC / 2 )"
else
    NUMPU="1"
fi

LINUX_DISTRO=""
###############################################################################

# 1 - Get linux distro
echo "Select your linux distro ************"
echo ""
echo "  1)Ubuntu"
echo "  2)Linux Mint"
echo "  3)Debian"
echo "  4)Arch Linux"
echo "  5)Fedora"
echo "  6)Ubuntu WMWare"
echo ""
echo "[1/2/3/4/5/6]: "

read n
case $n in
  1) LINUX_DISTRO="Ubuntu";;
  2) LINUX_DISTRO="Linux Mint";;
  3) LINUX_DISTRO="Debian";;
  4) LINUX_DISTRO="Arch Linux";;
  5) LINUX_DISTRO="Fedora";;
  6) LINUX_DISTRO="Ubuntu WMWare";;
  *) echo "Invalid option. Try another one.";;
esac

if [ "$LINUX_DISTRO" == "" ]; then
  exit 0
fi

if [! -d $INSTALLFOLDER/$OFFOLDERNAME]; then
  echo "Mosaic is not installed in your system, please run mosaic_installer.sh in order to install it."
  exit 0
fi

echo -e "\nUpdating Mosaic for "$LINUX_DISTRO"\n"

# 2 - Install dependencies
if [ "$LINUX_DISTRO" == "Ubuntu" ]; then
  apt update
  apt install git curl ffmpeg wget build-essential net-tools guile-2.2 guile-2.2-dev -y
  apt install cmake libncurses5-dev libreadline-dev nettle-dev libgnutls28-dev libargon2-0-dev libmsgpack-dev libssl-dev libfmt-dev libjsoncpp-dev libhttp-parser-dev libasio-dev libcppunit-dev -y
elif [ "$LINUX_DISTRO" == "Ubuntu WMWare" ]; then
  apt update
  apt install git curl ffmpeg wget build-essential net-tools guile-2.2 guile-2.2-dev -y
  apt install cmake libncurses5-dev libreadline-dev nettle-dev libgnutls28-dev libargon2-0-dev libmsgpack-dev libssl-dev libfmt-dev libjsoncpp-dev libhttp-parser-dev libasio-dev libcppunit-dev -y
elif [ "$LINUX_DISTRO" == "Linux Mint" ]; then
  apt update
  apt install git curl ffmpeg wget build-essential net-tools guile-2.2 guile-2.2-dev -y
  apt install cmake libncurses5-dev libreadline-dev nettle-dev libgnutls28-dev libargon2-0-dev libmsgpack-dev libssl-dev libfmt-dev libjsoncpp-dev libhttp-parser-dev libasio-dev libcppunit-dev -y
elif [ "$LINUX_DISTRO" == "Debian" ]; then
  apt update
  apt install git curl ffmpeg wget build-essential net-tools rsync guile-2.2 guile-2.2-dev -y
  apt install cmake libncurses5-dev libreadline-dev nettle-dev libgnutls28-dev libargon2-0-dev libmsgpack-dev libssl-dev libfmt-dev libjsoncpp-dev libhttp-parser-dev libasio-dev libcppunit-dev -y
elif [ "$LINUX_DISTRO" == "Arch Linux" ]; then
  pacman -Syu
  pacman -Syu base-devel git curl ffmpeg wget net-tools rsync nano guile-2.2 guile-2.2-dev
  pacman -Syu cmake libncurses5-dev libreadline-dev nettle-dev libgnutls28-dev libargon2-0-dev libmsgpack-dev libssl-dev libfmt-dev libjsoncpp-dev libhttp-parser-dev libasio-dev libcppunit-dev
elif [ "$LINUX_DISTRO" == "Fedora" ]; then
  dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  dnf update
  dnf install nano make git curl ffmpeg wget net-tools guile22 guile22-devel --allowerasing
  dnf install cppunit cppunit-devel readline-devel gnutls-devel msgpack-devel asio-devel libargon2-devel fmt-devel --allowerasing
fi

MOSAICVERSION="$( curl https://raw.githubusercontent.com/d3cod3/Mosaic/master/bin/data/release.txt )"


# 3 - Install/update ofxaddons dependencies
cd $INSTALLFOLDER/$OFFOLDERNAME/addons

if [ -d ofxAudioFile ]; then
  echo -e "\nUpdating ofxAudioFile addon..."
  cd ofxAudioFile && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxAudioFile addon..."
  git clone --branch=master https://github.com/d3cod3/ofxAudioFile
fi

if [ -d ofxBTrack ]; then
  echo -e "\nUpdating ofxBTrack addon..."
  cd ofxBTrack && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxBTrack addon..."
  git clone --branch=master https://github.com/d3cod3/ofxBTrack
fi

if [ -d ofxChromaKeyShader ]; then
  echo -e "\nUpdating ofxChromaKeyShader addon..."
  cd ofxChromaKeyShader && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxChromaKeyShader addon..."
  git clone --branch=master https://github.com/d3cod3/ofxChromaKeyShader
fi

if [ -d ofxCv ]; then
  echo -e "\nUpdating ofxCv addon..."
  cd ofxCv && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxCv addon..."
  git clone --branch=master https://github.com/d3cod3/ofxCv
fi

if [ -d ofxEasing ]; then
  echo -e "\nUpdating ofxEasing addon..."
  cd ofxEasing && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxEasing addon..."
  git clone --branch=master https://github.com/arturoc/ofxEasing
fi

if [ -d ofxFFmpegRecorder ]; then
  echo -e "\nUpdating ofxFFmpegRecorder addon..."
  cd ofxFFmpegRecorder && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxFFmpegRecorder addon..."
  git clone --branch=master https://github.com/d3cod3/ofxFFmpegRecorder
fi

if [ -d ofxFft ]; then
  echo -e "\nUpdating ofxFft addon..."
  cd ofxFft && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxFft addon..."
  git clone --branch=master https://github.com/kylemcdonald/ofxFft
fi

if [ -d ofxJSON ]; then
  echo -e "\nUpdating ofxJSON addon..."
  cd ofxJSON && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxJSON addon..."
  git clone --branch=master https://github.com/jeffcrouse/ofxJSON
fi

if [ -d ofxImGui ]; then
  echo -e "\nUpdating ofxImGui addon..."
  cd ofxImGui && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxImGui addon..."
  git clone --branch=master https://github.com/d3cod3/ofxImGui
fi

if [ -d ofxInfiniteCanvas ]; then
  echo -e "\nUpdating ofxInfiniteCanvas addon..."
  cd ofxInfiniteCanvas && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxInfiniteCanvas addon..."
  git clone --branch=master https://github.com/d3cod3/ofxInfiniteCanvas
fi

if [ -d ofxLua ]; then
  echo -e "\nUpdating ofxLua addon..."
  cd ofxLua && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxLua addon..."
  git clone --branch=master https://github.com/danomatika/ofxLua
fi

if [ -d ofxMidi ]; then
  echo -e "\nUpdating ofxMidi addon..."
  cd ofxMidi && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxMidi addon..."
  git clone --branch=master https://github.com/danomatika/ofxMidi
fi

if [ -d ofxMtlMapping2D ]; then
  echo -e "\nUpdating ofxMtlMapping2D addon..."
  cd ofxMtlMapping2D && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxMtlMapping2D addon..."
  git clone --branch=master https://github.com/d3cod3/ofxMtlMapping2D
fi

if [ -d ofxOpenDHT ]; then
  echo -e "\nUpdating ofxOpenDHT addon..."
  cd ofxOpenDHT && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxOpenDHT addon..."
  git clone --branch=master https://github.com/d3cod3/ofxOpenDHT
  # compile and install opendht library
  cd $INSTALLFOLDER/$OFFOLDERNAME/addons/ofxOpenDHT
  git clone https://github.com/savoirfairelinux/opendht.git
  cd opendht
  mkdir build && cd build
  cmake -DOPENDHT_PYTHON=OFF -DCMAKE_INSTALL_PREFIX=/usr ..
  make -j4
  sudo make install
  cd $INSTALLFOLDER/$OFFOLDERNAME/addons
fi

if [ -d ofxPd ]; then
  echo -e "\nUpdating ofxPd addon..."
  cd ofxPd && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPd addon..."
  git clone --branch=master https://github.com/danomatika/ofxPd
fi

if [ -d ofxPDSP ]; then
  echo -e "\nUpdating ofxPDSP addon..."
  cd ofxPDSP && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPDSP addon..."
  git clone --branch=master https://github.com/d3cod3/ofxPDSP
fi

if [ -d ofxTimeline ]; then
  echo -e "\nUpdating ofxTimeline addon..."
  cd ofxTimeline && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxTimeline addon..."
  git clone --branch=master https://github.com/d3cod3/ofxTimeline
fi

if [ -d ofxVisualProgramming ]; then
  echo -e "\nUpdating ofxVisualProgramming addon..."
  cd ofxVisualProgramming && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxVisualProgramming addon..."
  git clone --branch=master https://github.com/d3cod3/ofxVisualProgramming
fi

if [ -d ofxWarp ]; then
  echo -e "\nUpdating ofxWarp addon..."
  cd ofxWarp && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxWarp addon..."
  git clone --branch=master https://github.com/d3cod3/ofxWarp
fi

# 4 - Clone and compile Mosaic
cd $INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic

# update repo
git checkout -- . && git pull && git submodule update

# compile
make -j$NUMPU Release

# 5 - Change the ownership of the entire openFrameworks folder to local user
cd $INSTALLFOLDER
chown $LOCALUSERNAME:$LOCALUSERNAME -R $OFFOLDERNAME/

# 6 - Create Mosaic Example folder in ~/Documents
mkdir -p $USERHOME/Documents/Mosaic
cp -R $INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic/bin/examples $USERHOME/Documents/Mosaic
chown $LOCALUSERNAME:$LOCALUSERNAME -R $USERHOME/Documents/Mosaic

# 7 - Mosaic installed message
echo -e "\nMosaic $MOSAICVERSION updated and ready to use."
echo -e "\nYou will find it in your applications menu."

exit 0
