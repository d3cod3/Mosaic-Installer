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
#	  Mosaic auto compile/install script for windows/msys2 64 bit
#
###############################################################################

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
# VARS
USERHOME="$( echo ~ )"
MOSAICDESKTOPFILE=Mosaic.desktop
MOSAICVERSION="$( curl https://raw.githubusercontent.com/d3cod3/Mosaic/master/bin/data/release.txt )"
LOCALUSERNAME="$( who | awk '{print $1}' )"
INSTALLFOLDER=/opt
OFFOLDERNAME=openFrameworks
# HARDCODED OPENFRAMEWORKS RELEASE, using 0.11.0
OFRELURL=https://openframeworks.cc/versions/v0.11.0/of_v0.11.0_msys2_release.zip
OFRELFILENAME=of_v0.11.0_msys2_release.zip
OFRELORIGINALNAME=of_v0.11.0_msys2_release
###############################################################################

# 0 - print installer start_message
start_message

echo -e "\nInstalling Mosaic version "$MOSAICVERSION" for windows\n"

# 1 - Install dependencies
pacman -Syu --noconfirm --needed
pacman -Syu git nano patch unzip --noconfirm

# 2 - Download and Install openFrameworks
cd $INSTALLFOLDER

if [ ! -d $OFFOLDERNAME ]; then
  # download OF
  echo -e "\nDownloading openFrameworks version: "$OFRELORIGINALNAME
  wget $OFRELURL
  unzip $OFRELFILENAME
  mv $OFRELORIGINALNAME/ $OFFOLDERNAME/
  rm -f $OFRELFILENAME

  # install OF dependencies
  echo -e "\nInstalling openFrameworks dependencies"
  cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/msys2
  ./install_dependencies.sh --noconfirm

  # small compile fixes
  cd $INSTALLFOLDER/$OFFOLDERNAME/libs/openFrameworks/sound
  wget -O openal_fix.patch https://aur.archlinux.org/cgit/aur.git/plain/openal_fix.patch?h=openframeworks
  patch ofOpenALSoundPlayer.h < openal_fix.patch
  rm -f openal_fix.patch
  cd $INSTALLFOLDER/$OFFOLDERNAME/libs/openFrameworksCompiled/project/makefileCommon
  wget -O make_4.3_error_fix.patch https://aur.archlinux.org/cgit/aur.git/plain/make_4.3_error_fix.patch?h=openframeworks
  patch config.addons.mk < make_4.3_error_fix.patch
  rm make_4.3_error_fix.patch

  # compile OF
  echo -e "\nCompiling openFrameworks..."
  cd $INSTALLFOLDER/$OFFOLDERNAME/scripts/msys2
  ./compileOF.sh
fi

# 3 - Install ofxaddons dependencies
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

if [ -d ofxDatGui ]; then
  echo -e "\nUpdating ofxDatGui addon..."
  cd ofxDatGui && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxDatGui addon..."
  git clone --branch=master https://github.com/d3cod3/ofxDatGui
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

if [ -d ofxFontStash ]; then
  echo -e "\nUpdating ofxFontStash addon..."
  cd ofxFontStash && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxFontStash addon..."
  git clone --branch=master https://github.com/d3cod3/ofxFontStash
fi

if [ -d ofxGLEditor ]; then
  echo -e "\nUpdating ofxGLEditor addon..."
  cd ofxGLEditor && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxGLEditor addon..."
  git clone --branch=master https://github.com/d3cod3/ofxGLEditor
fi

if [ -d ofxHistoryPlot ]; then
  echo -e "\nUpdating ofxHistoryPlot addon..."
  cd ofxHistoryPlot && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxHistoryPlot addon..."
  git clone --branch=master https://github.com/armadillu/ofxHistoryPlot
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
  git clone --branch=master https://github.com/d3cod3/ofxMidi
fi

if [ -d ofxMtlMapping2D ]; then
  echo -e "\nUpdating ofxMtlMapping2D addon..."
  cd ofxMtlMapping2D && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxMtlMapping2D addon..."
  git clone --branch=master https://github.com/d3cod3/ofxMtlMapping2D
fi

if [ -d ofxParagraph ]; then
  echo -e "\nUpdating ofxParagraph addon..."
  cd ofxParagraph && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxParagraph addon..."
  git clone --branch=master https://github.com/d3cod3/ofxParagraph
fi

if [ -d ofxPDSP ]; then
  echo -e "\nUpdating ofxPDSP addon..."
  cd ofxPDSP && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxPDSP addon..."
  git clone --branch=master https://github.com/npisanti/ofxPDSP
fi

if [ -d ofxThreadedFileDialog ]; then
  echo -e "\nUpdating ofxThreadedFileDialog addon..."
  cd ofxThreadedFileDialog && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxThreadedFileDialog addon..."
  git clone --branch=master https://github.com/d3cod3/ofxThreadedFileDialog
fi

if [ -d ofxTimeline ]; then
  echo -e "\nUpdating ofxTimeline addon..."
  cd ofxTimeline && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxTimeline addon..."
  git clone --branch=master https://github.com/d3cod3/ofxTimeline
fi

if [ -d ofxTimeMeasurements ]; then
  echo -e "\nUpdating ofxTimeMeasurements addon..."
  cd ofxTimeMeasurements && git checkout -- . && git pull && cd ..
else
  echo -e "\nCloning ofxTimeMeasurements addon..."
  git clone --branch=master https://github.com/armadillu/ofxTimeMeasurements
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
cd $INSTALLFOLDER
cd $OFFOLDERNAME/apps
if [ -d d3cod3 ]; then
  cd d3cod3
  rm -rf Mosaic
  git clone --recursive --branch=master https://github.com/d3cod3/Mosaic
  cd Mosaic
  sed -i '' -e "s/ofxJava/ /g" addons.make
  sed -i '' -e "s/ofxNDI/ /g" addons.make
  sed -i '' -e "s/ofxPdExternals/ /g" addons.make
  sed -i '' -e "s/ofxPd/ /g" addons.make
  sed -i '' -e "s/ofxPython/ /g" addons.make
  make -j2 Release
  # copy all .o files in the same folder
  mkdir tmpobj
  cp obj/msys2/Release/src/*.o tmpobj/
  find /opt/openFrameworks/addons/obj/msys2/Release/ -type f -name *.o -exec cp "{}" tmpobj/ \;
  # customize link command to reduce arguments size to 32000 MAX

else
  mkdir d3cod3
  cd d3cod3
  git clone --recursive --branch=master https://github.com/d3cod3/Mosaic
  cd Mosaic
  sed -i '' -e "s/ofxJava/ /g" addons.make
  sed -i '' -e "s/ofxNDI/ /g" addons.make
  sed -i '' -e "s/ofxPdExternals/ /g" addons.make
  sed -i '' -e "s/ofxPd/ /g" addons.make
  sed -i '' -e "s/ofxPython/ /g" addons.make
  make -j2 Release
fi
