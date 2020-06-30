# Mosaic-Installer

 Mosaic installer script

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/mi.jpg)

![screenshot](https://github.com/d3cod3/Mosaic-Installer/blob/master/img/windows_installer.jpg)

## DESCRIPTION

Bash scripts for automated Mosaic download/compile/install on Linux and windows machines.

### LINUX

On Linux boxes the install process is fully automated, and right now is available for those distros:

1. Ubuntu ( tested on different one starting from 16.04 )
2. Linux Mint
3. Debian ( tested from debian 9 stretch )
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
