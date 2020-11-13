# Mosaic-Installer

 Mosaic installer script

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/mi.jpg)

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/windows_installer.jpg)

## DESCRIPTION

Bash scripts for automated Mosaic download/compile/install on Linux and windows machines.

### LINUX

On Linux boxes the install process is fully automated, and right now is available for those distros:

1. Ubuntu ( tested on different ones starting from 16.04 to 20.04 )
2. Linux Mint
3. Debian ( tested from debian 9 stretch to debian 10 buster)
4. Arch Linux
5. Fedora ( starting from Fedora 29 )

Just clone this repo

```bash
git clone https://github.com/d3cod3/Mosaic-Installer
```

Then launch the install script as sudo

```bash
cd Mosaic-Installer
sudo ./mosaic_installer.sh
```

And choose your distro from the list.

Wait some...

When the script finish, you'll have Mosaic software appearing in your programs menus!

> if your distro is not on the list, and you want to contribute to this repo, you are very welcome!

#### Manual Install

In case something goes wrong, or your distro has not been tested yet, here are the basic steps of the installer explained:

1. Install of0.11.0 from the official openFrameworks page and follow the install instructions here: https://openframeworks.cc/setup/linux-install/
2. Clone Mosaic with submodules:
```bash
cd OF/apps/ && mkdir mosaicApps && cd mosaicApps
git clone https://github.com/d3cod3/Mosaic.git
git submodule init && git submodule update
```
3. Update ofxAddonTool:
```bash
cd Mosaic/scripts/ofxAddonTool && git checkout master && git pull
```
4. Run ofxAddonTool:
```bash
./ofxAddonTool.sh --install
```
5. Install hooks from Mosaic Installer:
```bash
apt install git curl ffmpeg wget libpython3.8-dev libsnappy-dev libswresample-dev libavcodec-dev libavformat-dev libdispatch-dev
```
Python
```bash
ln -s /usr/lib/x86_64-linux-gnu/pkgconfig/python-3.8.pc /usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc
```
NDI
```bash
sudo cp OF/addons/ofxNDI/libs/libndi/lib/x86_64-linux-gnu/libndi.so.3.7.1 /usr/local/lib && ln -s /usr/local/lib/libndi.so.3.7.1 /usr/lib/libndi.so.3
```
Fftw
```bash
git clone --branch=master https://github.com/d3cod3/fftw3.3.2-source
cd fftw3.3.2-source
./configure --prefix=pwd --enable-float --enable-sse2 --with-incoming-stack-boundary=2 --with-our-malloc16 --disable-shared --enable-static
make MAKEINFO=true -j3
mkdir OF/addons/ofxAudioAnalyzer/libs/fftw3f/lib/linux64
cd .libs && cp libfftw3f.a OF/addons/ofxAudioAnalyzer/libs/fftw3f/lib/linux64/
cd ../../ && rm -rf fftw3.3.2-source
```
6. ```make -j3 Release``` could fail because the generated linker command can be too huge. If that's the case, compile Mosaic using qt-creator included Mosaic.qbs project. ( to install qt-creator follow this instructions here: https://openframeworks.cc/setup/qtcreator/ and be sure to download Qt Creator 4.6.1 )

### WINDOWS

As usual, on windows we have some more issues, so the install script is semi-automated, it solve some stuff, but users will need to do some more things manually.

It has been tested on windows 10, but should work too on windows 7.

So, this is the resume in order:

1. Download/Install (follow instructions, it's really straightforward) msys2 from here: https://www.msys2.org/
2. Open msys2, we are going to use mingw 32 bit, so when asked ( you'll have 3 choices ) open the mingw 32 bit shell.

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/mingw32.jpg)

3. clone this repo: ``` git clone https://github.com/d3cod3/Mosaic-Installer ```
4. Launch the windows install script: ``` cd Mosaic-Installer && ./mosaic_windows_installer.sh```

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/shell.jpg)

5. Wait some...
6. When the script finish, you'll have everything ready for compile Mosaic, but due to some mingw compiler limitations, you'll need to compile it with QT Creator.
7. Download/Install QT Creator 4.6.1 from here: http://download.qt.io/official_releases/qtcreator/
8. Follow the setting instruction from OF webpage here: https://openframeworks.cc/setup/qtcreator/
9. Open the Mosaic.qbs project file from QT Creator, located here: ``` C:\msys64\opt\openFrameworks\apps\d3cod3\Mosaic\Mosaic.qbs```
10. Compile the Release.

That's it, when finished compiling, you'll find the Mosaic.exe app here: ``` C:\msys64\opt\openFrameworks\apps\d3cod3\Mosaic\bin/Mosaic.exe```

Just open it and pin it to the taskbar.
