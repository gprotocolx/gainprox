
Debian
====================
This directory contains files used to package gainproxd/gainprox-qt
for Debian-based Linux systems. If you compile gainproxd/gainprox-qt yourself, there are some useful files here.

## gainprox: URI support ##


gainprox-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install gainprox-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your gainprox-qt binary to `/usr/bin`
and the `../../share/pixmaps/gainprox128.png` to `/usr/share/pixmaps`

gainprox-qt.protocol (KDE)

