#!/bin/bash

###############################################################################
# 	----------------------------------------------------------
#   Mosaic | OF Visual Patching Developer Platform
#
#	  Copyright (c) 2020 Emanuele Mazza aka n3m3da
#
#	  Mosaic is distributed under the MIT License. This gives everyone the
#   freedoms to use Mosaic in any context: commercial or non-commercial,
#   public or private, open or closed source.
#
#   See https://github.com/d3cod3/Mosaic for documentation
#	----------------------------------------------------------
#
#
#	  Mosaic auto compile/install script for multi linux boxes
#
#   Supported for now: Ubuntu, Ubuntu Studio, Linux Mint, Debian, Arch Linux, Fedora
#
###############################################################################


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo "\"${last_command}\" command failed with exit code $?."

start_message() {
  echo ""
  echo ""
  echo " __    __     ______     ______     ______     __     ______    "
  echo "/\ '-./  \   /\  __ \   /\  ___\   /\  __ \   /\ \   /\  ___\   "
  echo "\ \ \-./\ \  \ \ \/\ \  \ \___  \  \ \  __ \  \ \ \  \ \ \____  "
  echo " \ \_\ \ \_\  \ \_____\  \/\_____\  \ \_\ \_\  \ \_\  \ \_____\ "
  echo "  \/_/  \/_/   \/_____/   \/_____/   \/_/\/_/   \/_/   \/_____/"
  echo ""
  echo ""
  echo " __     __   __     ______     ______   ______     __         __         ______     ______    "
  echo "/\ \   /\ '-.\ \   /\  ___\   /\__  _\ /\  __ \   /\ \       /\ \       /\  ___\   /\  == \   "
  echo "\ \ \  \ \ \-.  \  \ \___  \  \/_/\ \/ \ \  __ \  \ \ \____  \ \ \____  \ \  __\   \ \  __<   "
  echo " \ \_\  \ \_\\''\_\  \/\_____\    \ \_\  \ \_\ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\ "
  echo "  \/_/   \/_/ \/_/   \/_____/     \/_/   \/_/\/_/   \/_____/   \/_____/   \/_____/   \/_/ /_/ "
  echo ""
  echo ""
}

###############################################################################
# Check if running with sudo
if [ $(id -u) != 0 ]; then
    echo -e "\nMosaic installer script must be run with super-user privileges."
    echo -e "\nUsage:\nsudo "$0"\n"
    exit $exit_code
    exit 1
fi

###############################################################################
# VARS
USERHOME="$( echo ~ )"
MOSAICDESKTOPFILE=Mosaic.desktop
LOCALUSERNAME="$( who | awk '{print $1}' )"
INSTALLFOLDER=/opt
OFFOLDERNAME=openFrameworks
# HARDCODED OPENFRAMEWORKS RELEASE, using 0.11.0
OFRELURL=https://openframeworks.cc/versions/v0.11.0/of_v0.11.0_linux64gcc6_release.tar.gz
OFRELFILENAME=of_v0.11.0_linux64gcc6_release.tar.gz
OFRELORIGINALNAME=of_v0.11.0_linux64gcc6_release

NPROC="$( nproc )"
NUMPU="1"
if [ $NPROC -gt "1" ]; then
    NUMPU="$( expr $NPROC / 2 )"
else
    NUMPU="1"
fi

LINUX_DISTRO=""
###############################################################################

# 0 - print installer start_message
start_message

# 1 - Get linux distro
echo "Select your linux distro ************"
echo ""
echo "  1)Ubuntu"
echo "  2)Linux Mint"
echo "  3)Debian"
echo "  4)Arch Linux"
echo "  5)Fedora"
echo ""
echo "[1/2/3/4/5]: "

read n
case $n in
  1) LINUX_DISTRO="Ubuntu";;
  2) LINUX_DISTRO="Linux Mint";;
  3) LINUX_DISTRO="Debian";;
  4) LINUX_DISTRO="Arch Linux";;
  5) LINUX_DISTRO="Fedora";;
  *) echo "Invalid option. Try another one.";;
esac

if [ "$LINUX_DISTRO" == "" ]; then
  exit 0
fi

echo -e "\nInstalling Mosaic for "$LINUX_DISTRO"\n"

# 2 - Install dependencies
if [ "$LINUX_DISTRO" == "Ubuntu" ]; then
  apt update
  apt install git curl ffmpeg wget libpython3.8-dev libsnappy-dev libswresample-dev libavcodec-dev libavformat-dev libdispatch-dev
elif [ "$LINUX_DISTRO" == "Linux Mint" ]; then
  apt update
  apt install git curl ffmpeg wget libpython3.8-dev libsnappy-dev libswresample-dev libavcodec-dev libavformat-dev libdispatch-dev
elif [ "$LINUX_DISTRO" == "Debian" ]; then
  apt update
  apt install git curl ffmpeg wget libpython3.8-dev rsync libsnappy-dev libswresample-dev libavcodec-dev libavformat-dev libdispatch-dev
elif [ "$LINUX_DISTRO" == "Arch Linux" ]; then
  pacman -Syu
  pacman -Syu base-devel python git curl ffmpeg wget rsync snappy nano
elif [ "$LINUX_DISTRO" == "Fedora" ]; then
  dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  dnf update
  dnf install nano make git curl ffmpeg wget python3-libs python3-devel
fi

MOSAICVERSION="$( curl https://raw.githubusercontent.com/d3cod3/Mosaic/master/bin/data/release.txt )"

# 3 - Download and Install openFrameworks
cd $INSTALLFOLDER

if [ ! -d $OFFOLDERNAME ]; then
  # download OF
  echo -e "\nDownloading openFrameworks version: "$OFRELORIGINALNAME
  wget $OFRELURL
  tar -xvzf $OFRELFILENAME
  mv $OFRELORIGINALNAME/ $OFFOLDERNAME/
  rm -f $OFRELFILENAME

  # install OF dependencies
  echo -e "\nInstalling openFrameworks dependencies"
  if [ "$LINUX_DISTRO" == "Ubuntu" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux/ubuntu
  elif [ "$LINUX_DISTRO" == "Linux Mint" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux/ubuntu
  elif [ "$LINUX_DISTRO" == "Debian" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux/debian
    DEBIAN_VERSION="$( cat /etc/debian_version | cut -d . -f 1 )"
    if [ $DEBIAN_VERSION == "10" ]; then
      sed -i 's/libgles1-mesa-dev/libglvnd-dev/' install_dependencies.sh
    fi
  elif [ "$LINUX_DISTRO" == "Arch Linux" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux/archlinux
    sed -e 's.$ROOT/..g' -i install_dependencies.sh
  elif [ "$LINUX_DISTRO" == "Fedora" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux/fedora
  fi
  ./install_dependencies.sh -y
  ./install_codecs.sh

  # small compile fixes
  cd $INSTALLFOLDER/$OFFOLDERNAME/libs/openFrameworks/utils
  sed -e '/GL\/glext.h/ s/^#*/\/\//' -i ofConstants.h
  if [ "$LINUX_DISTRO" == "Arch Linux" ]; then
    cd $INSTALLFOLDER/$OFFOLDERNAME/libs/openFrameworks/sound
    wget -O openal_fix.patch https://aur.archlinux.org/cgit/aur.git/plain/openal_fix.patch?h=openframeworks
    patch ofOpenALSoundPlayer.h < openal_fix.patch
    rm -f openal_fix.patch
    cd $INSTALLFOLDER/$OFFOLDERNAME/libs/openFrameworksCompiled/project/makefileCommon
    wget -O make_4.3_error_fix.patch https://aur.archlinux.org/cgit/aur.git/plain/make_4.3_error_fix.patch?h=openframeworks
    patch config.addons.mk < make_4.3_error_fix.patch
    rm make_4.3_error_fix.patch
  fi

  # compile OF
  echo -e "\nCompiling openFrameworks..."
  cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/linux
  ./compileOF.sh -j$NUMPU
fi

# 4 - Fix python symbolic link for compiling
if [ "$LINUX_DISTRO" == "Fedora" ]; then
  if [ ! -e /usr/lib64/pkgconfig/python3.pc ]; then
    ln -s /usr/lib64/pkgconfig/python-3.8.pc /usr/lib64/pkgconfig/python3.pc
  fi
else
  if [ ! -e /usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc ]; then
    ln -s /usr/lib/x86_64-linux-gnu/pkgconfig/python-3.8.pc /usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc
  fi
fi

# 5 - Install ofxaddons dependencies
cd $INSTALLFOLDER/$OFFOLDERNAME/addons

if [ -d ofxAudioAnalyzer ]; then
  echo -e "\nUpdating ofxAudioAnalyzer addon..."
  cd ofxAudioAnalyzer && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxAudioAnalyzer addon..."
  git clone --branch=master https://github.com/d3cod3/ofxAudioAnalyzer
fi

if [ -d ofxAudioFile ]; then
  echo -e "\nUpdating ofxAudioFile addon..."
  cd ofxAudioFile && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxAudioFile addon..."
  git clone --branch=master https://github.com/npisanti/ofxAudioFile
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
  git clone --branch=master https://github.com/kylemcdonald/ofxCv
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

if [ -d ofxGLEditor ]; then
  echo -e "\nUpdating ofxGLEditor addon..."
  cd ofxGLEditor && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxGLEditor addon..."
  git clone --branch=master https://github.com/Akira-Hayasaka/ofxGLEditor
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
  git clone --branch=of-0.10.0 https://github.com/d3cod3/ofxLua
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

if [ -d ofxNDI ]; then
  echo -e "\nUpdating ofxNDI addon..."
  cd ofxNDI && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxNDI addon..."
  git clone --branch=master https://github.com/d3cod3/ofxNDI
fi

if [ -d ofxPd ]; then
  echo -e "\nUpdating ofxPd addon..."
  cd ofxPd && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxAudofxPdioAnalyzer addon..."
  git clone --branch=master https://github.com/danomatika/ofxPd
fi

if [ -d ofxPdExternals ]; then
  echo -e "\nUpdating ofxPdExternals addon..."
  cd ofxPdExternals && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPdExternals addon..."
  git clone --branch=master https://github.com/d3cod3/ofxPdExternals
fi

if [ -d ofxPDSP ]; then
  echo -e "\nUpdating ofxPDSP addon..."
  cd ofxPDSP && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPDSP addon..."
  git clone --branch=master https://github.com/npisanti/ofxPDSP
fi

if [ -d ofxPython ]; then
  echo -e "\nUpdating ofxPython addon..."
  cd ofxPython && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPython addon..."
  git clone --branch=master https://github.com/d3cod3/ofxPython
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

# 6 - Compile fftw3.3.2 library from source and install
if [ ! -e $INSTALLFOLDER/$OFFOLDERNAME/addons/ofxAudioAnalyzer/libs/fftw3f/lib/linux64/libfftw3f.a ]; then
	cd $INSTALLFOLDER
	git clone --branch=master https://github.com/d3cod3/fftw3.3.2-source
	cd fftw3.3.2-source
	./configure --prefix=`pwd` --enable-float --enable-sse2 --with-incoming-stack-boundary=2 --with-our-malloc16 --disable-shared --enable-static
  make MAKEINFO=true -j$NUMPU
	cd .libs
	mkdir $INSTALLFOLDER/$OFFOLDERNAME/addons/ofxAudioAnalyzer/libs/fftw3f/lib/linux64
	cp libfftw3f.a $INSTALLFOLDER/$OFFOLDERNAME/addons/ofxAudioAnalyzer/libs/fftw3f/lib/linux64/
	cd $INSTALLFOLDER
	rm -rf fftw3.3.2-source/
fi

# 7 - Copy libndi
if [ ! -e /usr/local/lib/libndi.so.3.7.1 ]; then
  echo -e "\nCopying libndi to /usr/local/lib"
  cd $INSTALLFOLDER
  cp $OFFOLDERNAME/addons/ofxNDI/libs/libndi/lib/x86_64-linux-gnu/libndi.so.3.7.1 /usr/local/lib
  ln -s /usr/local/lib/libndi.so.3.7.1 /usr/lib/libndi.so.3
fi

# 8 - Clone and compile Mosaic
cd $INSTALLFOLDER
cd $OFFOLDERNAME/apps
if [ -d d3cod3 ]; then
  cd d3cod3
  rm -rf Mosaic
  git clone --recursive --branch=master https://github.com/d3cod3/Mosaic
  cd Mosaic
  make -j$NUMPU Release
else
  mkdir d3cod3
  cd d3cod3
  git clone --recursive --branch=master https://github.com/d3cod3/Mosaic
  cd Mosaic
  make -j$NUMPU Release
fi

# 9 - Create a Mosaic.desktop file for desktop launchers
if [ ! -e /usr/share/applications/$MOSAICDESKTOPFILE ]; then
  cd $INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic/bin
  echo "[Desktop Entry]" > $MOSAICDESKTOPFILE
  echo "Encoding=UTF-8" >> $MOSAICDESKTOPFILE
  echo "Version="$MOSAICVERSION >> $MOSAICDESKTOPFILE
  echo "Name=Mosaic" >> $MOSAICDESKTOPFILE
  echo "Type=Application" >> $MOSAICDESKTOPFILE
  echo "Terminal=false" >> $MOSAICDESKTOPFILE
  echo "Exec=$INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic/bin/Mosaic" >> $MOSAICDESKTOPFILE
  echo "Icon=$INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic/bin/data/images/logo_128.png" >> $MOSAICDESKTOPFILE
  echo "Categories=AudioVideo;Audio;Development" >> $MOSAICDESKTOPFILE
  echo "Comment=Live Visual Patching Creative-Coding Platform" >> $MOSAICDESKTOPFILE
  cp $MOSAICDESKTOPFILE /usr/share/applications
fi

# 10 - Change the ownership of the entire openFrameworks folder to local user
cd $INSTALLFOLDER
chown $LOCALUSERNAME:$LOCALUSERNAME -R $OFFOLDERNAME/

# 11 - Create Mosaic Example folder in ~/Documents
mkdir -p $USERHOME/Documents/Mosaic
cp -R $INSTALLFOLDER/$OFFOLDERNAME/apps/d3cod3/Mosaic/bin/examples $USERHOME/Documents/Mosaic

# 12 - Mosaic installed message
echo -e "\nMosaic $MOSAICVERSION installed and ready to use."
echo -e "\nYou will find it in your applications menu."

exit 0
