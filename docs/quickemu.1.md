---
author: Martin Wimpress
date: July 31, 2025
footer: quickemu
header: Quickemu User Manual
section: 1
title: QUICKEMU
---

# NAME

quickemu - A quick VM builder and manager

# SYNOPSIS

**quickemu** \[*OPTION*\]...

# DESCRIPTION

**quickemu** will create and run highly optimised desktop virtual
machines for Linux, macOS and Windows

# OPTIONS

**--vm**
:   vm configuration file

You can also pass optional parameters

**--access**
:   Enable remote spice access support. 'local' (default), 'remote',
    'clientipaddress'

**--braille**
:   Enable braille support. Requires SDL.

**--delete-disk**
:   Delete the disk image and EFI variables

**--delete-vm**
:   Delete the entire VM and its configuration

**--display**
:   Select display backend. 'sdl' (default), 'gtk', 'none', 'spice' or
    'spice-app'

**--fullscreen**
:   Starts VM in full screen mode (Ctl+Alt+f to exit)

**--ignore-msrs-always**
:   Configure KVM to always ignore unhandled machine-specific registers

**--kill**
:   Kill the VM process if it is running

**--offline**
:   Override all network settings and start the VM offline

**--shortcut**
:   Create a desktop shortcut

**--snapshot apply \<tag\>**
:   Apply/restore a snapshot.

**--snapshot create \<tag\>**
:   Create a snapshot.

**--snapshot delete \<tag\>**
:   Delete a snapshot.

**--snapshot info**
:   Show disk/snapshot info.

**--status-quo**
:   Do not commit any changes to disk/snapshot.

**--viewer \<viewer\>**
:   Choose an alternative viewer. @Options: 'spicy' (default),
    'remote-viewer', 'none'

**--width \<width\>**
:   Set VM screen width; requires '--height'

**--height \<height\>**
:   Set VM screen height; requires '--width'

**--ssh-port \<port\>**
:   Set SSH port manually

**--spice-port \<port\>**
:   Set SPICE port manually

**--public-dir \<path\>**
:   Expose share directory. @Options: '' (default: xdg-user-dir
    PUBLICSHARE), '<directory>', 'none'

**--monitor \<type\>**
:   Set monitor connection type. @Options: 'socket' (default), 'telnet',
    'none'

**--monitor-telnet-host \<ip/host\>**
:   Set telnet host for monitor. (default: 'localhost')

**--monitor-telnet-port \<port\>**
:   Set telnet port for monitor. (default: '4440')

**--monitor-cmd \<cmd\>**
:   Send command to monitor if available. (Example: system_powerdown)

**--serial \<type\>**
:   Set serial connection type. @Options: 'socket' (default), 'telnet',
    'none'

**--serial-telnet-host \<ip/host\>**
:   Set telnet host for serial. (default: 'localhost')

**--serial-telnet-port \<port\>**
:   Set telnet port for serial. (default: '6660')

**--keyboard \<type\>**
:   Set keyboard. @Options: 'usb' (default), 'ps2', 'virtio'

**--keyboard_layout \<layout\>**
:   Set keyboard layout: 'en-us' (default)

**--mouse \<type\>**
:   Set mouse. @Options: 'tablet' (default), 'ps2', 'usb', 'virtio'

**--usb-controller \<type\>**
:   Set usb-controller. @Options: 'ehci' (default), 'xhci', 'none'

**--sound-card \<type\>**
:   Set sound card. @Options: 'intel-hda' (default), 'ac97', 'es1370',
    'sb16', 'none'

**--extra_args \<arguments\>**
:   Pass additional arguments to qemu

**--version**
:   Print version

# EXAMPLES

**quickemu --vm ubuntu-mate-22.04.conf**
:   Launches the VM specified in the file *ubuntu-mate-22.04.conf*

# Introduction

**Quickemu** is a wrapper for the excellent
[QEMU](https://www.qemu.org/) that automatically *"does the right
thing"* when creating virtual machines. No requirement for exhaustive
configuration options. You decide what operating system you want to run
and Quickemu takes care of the rest 🤖

- `quickget` **automatically downloads the upstream OS** and creates the
  configuration 📀
- `quickemu` enumerates your hardware and launches the virtual machine
  with the **optimum configuration best suited to your computer** ⚡️

The original objective of the project was to [enable quick testing of
Linux
distributions](https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines)
where the virtual machines and their configuration can be stored
anywhere (such as external USB storage or your home directory) and no
elevated permissions are required to run the virtual machines.

**Today, Quickemu includes comprehensive support for
[macOS](https://github.com/quickemu-project/quickemu/wiki/03-Create-macOS-virtual-machines),
[Windows](https://github.com/quickemu-project/quickemu/wiki/04-Create-Windows-virtual-machines)**,
most of the BSDs, novel non-Linux operating systems such as FreeDOS,
Haiku, KolibriOS, OpenIndiana, ReactOS, and more.

# Features

- Host support for **Linux and macOS**
- **macOS** Sequoia, Sonoma, Ventura, Monterey, Big Sur, Catalina &
  Mojave
- **Windows** 10 and 11 including TPM 2.0
- **Windows Server** 2022 2019 2016
- [Ubuntu](https://ubuntu.com/desktop) and all the **[official Ubuntu
  flavours](https://ubuntu.com/download/flavours)**
- **Nearly 1000 operating system editions are supported!**
- Full SPICE support including host/guest clipboard sharing
- VirtIO-webdavd file sharing for Linux and Windows guests
- VirtIO-9p file sharing for Linux and macOS guests
- [QEMU Guest Agent support](https://wiki.qemu.org/Features/GuestAgent);
  provides access to a system-level agent via standard QMP commands
- Samba file sharing for Linux, macOS and Windows guests (*if `smbd` is
  installed on the host*)
- VirGL acceleration
- USB device pass-through
- Smartcard pass-through
- Automatic SSH port forwarding to guests
- Network port forwarding
- Full duplex audio
- Braille support
- EFI (with or without SecureBoot) and Legacy BIOS boot

## As featured on [Linux Matters](https://linuxmatters.sh) podcast!

The presenters of Linux Matters 🐧🎙️ are the creators of each of the
principal Quickemu projects. We discussed Quickemu's 2024 reboot in
[Episode 30 - Quickemu Rising From the
Bashes](https://linuxmatters.sh/30).
<!-- and in [Episode 32 - Quick, quicker, quickest](https://linuxmatters.sh/32) [Martin](https://github.com/flexiondotorg) unveils macOS host support for [**Quickemu**](https://github.com/quickemu-project/quickemu), [Mark](https://github.com/marxjohnson) explains the origins of the [**Quickgui**](https://github.com/quickemu-project/quickgui) desktop app and upcoming improvements, and [Alan](https://github.com/popey) debuts [**Quicktest**](https://github.com/quickemu-project/quicktest); a framework for automatically testing operating systems via Quickemu -->

<div align="center">

<a href="https://linuxmatters.sh" target="_blank"><img src="https://github.com/wimpysworld/nix-config/raw/main/.github/screenshots/linuxmatters.png" alt="Linux Matters Podcast"/></a>
<br /> <em>Linux Matters Podcast</em>

</div>

When installing from source, you will need to install the following
requirements manually:

- [QEMU](https://www.qemu.org/) (*6.0.0 or newer*) **with GTK, SDL,
  SPICE & VirtFS support**
- [bash](https://www.gnu.org/software/bash/) (*4.0 or newer*)
- [Coreutils](https://www.gnu.org/software/coreutils/)
- [curl](https://curl.se/)
- [EDK II](https://github.com/tianocore/edk2)
- [gawk](https://www.gnu.org/software/gawk/)
- [grep](https://www.gnu.org/software/grep/)
- [glxinfo](https://gitlab.freedesktop.org/mesa/demos)
- [jq](https://stedolan.github.io/jq/)
- [LSB](https://wiki.linuxfoundation.org/lsb/start)
- [pciutils](https://github.com/pciutils/pciutils)
- [procps](https://gitlab.com/procps-ng/procps)
- [python3](https://www.python.org/)
- [mkisofs](http://cdrtools.sourceforge.net/private/cdrecord.html)
- [usbutils](https://github.com/gregkh/usbutils)
- [util-linux](https://github.com/karelzak/util-linux); including
  `uuidgen`
- [sed](https://www.gnu.org/software/sed/)
- [socat](http://www.dest-unreach.org/socat/)
- [spicy](https://gitlab.freedesktop.org/spice/spice-gtk)
- [swtpm](https://github.com/stefanberger/swtpm)
- [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)
- [xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr)
- [zsync](http://zsync.moria.org.uk/)
- [unzip](http://www.info-zip.org/UnZip.html)

For Ubuntu, Debian, Fedora, Arch and NixOS hosts the native packaging or
[ppa](https://launchpad.net/~flexiondotorg/+archive/ubuntu/quickemu),
[AUR](https://aur.archlinux.org/packages/quickemu) or
[nix](https://github.com/NixOS/nixpkgs/tree/master/pkgs/development/quickemu)
packaging will take care of the dependencies. For other host
distributions or operating systems it will be necessary to install the
above requirements or their equivalents.

These examples may save a little typing:

#### Install requirements on Debian hosts

These should be handled by dependencies in Trixie and later. For earlier
versions (and their derivatives):

``` shell
sudo apt-get install bash coreutils curl genisoimage grep jq mesa-utils ovmf pciutils procps python3 qemu sed socat spice-client-gtk swtpm-tools unzip usbutils util-linux xdg-user-dirs xrandr zsync 
```

#### Install requirements on Fedora hosts

These are handled natively for Fedora 41 on. For earlier versions:

``` shell
sudo dnf install bash coreutils curl edk2-tools genisoimage grep jq mesa-demos pciutils procps python3 qemu sed socat spice-gtk-tools swtpm unzip usbutils util-linux uuidgen-runtime xdg-user-dirs xrandr zsync
```

### Install requirements on Gentoo

Please note that you may have to use `sys-firmware/edk2-ovmf` instead of
`sys-firmware/edk2-ovmf-bin` - depending on how your system is
configured.

``` shell
sudo emerge --ask --noreplace app-emulation/qemu \
 app-shells/bash \
 sys-apps/coreutils \
 net-misc/curl \
 sys-firmware/edk2-ovmf-bin \
 sys-apps/gawk \
 sys-apps/grep \
 x11-apps/mesa-progs \
 app-misc/jq \
 sys-apps/pciutils \
 sys-process/procps \
 app-cdr/cdrtools \
 sys-apps/usbutils \
 sys-apps/util-linux \
 sys-apps/sed \
 net-misc/socat \
 app-emulation/spice \
 app-crypt/swtpm \
 x11-misc/xdg-user-dirs \
 x11-apps/xrandr \
 net-misc/zsync \
 app-arch/unzip
```

#### Install requirements on macOS hosts

Install the Quickemu requirements using brew:

``` shell
brew install bash cdrtools coreutils jq python3 qemu usbutils samba socat swtpm zsync
```

Now clone the project:

``` shell
git clone https://github.com/quickemu-project/quickemu
cd quickemu
```

## [Alternative Frontends](https://github.com/quickemu-project/quickemu/wiki/07-Alternative-frontends)

### Quickgui

While `quickemu` and `quickget` are designed for the terminal, a
graphical user interface is also available:

- **[Quickgui](https://github.com/quickemu-project/quickgui)** by [Mark
  Johnson](https://github.com/marxjohnson) and [Yannick
  Mauray](https://github.com/ymauray).

To install Quickgui on Ubuntu:

``` shell
sudo add-apt-repository ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install quickgui
```

Many thanks to [Luke Wesley-Holley](https://github.com/Lukewh) and
[Philipp Kiemle](https://github.com/daPhipz) for creating the
**[Quickemu icons](https://github.com/Lukewh/quickemu-icons)** 🎨

## Creating Linux guests 🐧

### Ubuntu

`quickget` will automatically download an Ubuntu release and create the
virtual machine configuration.

``` shell
quickget ubuntu 22.04
quickemu --vm ubuntu-22.04.conf
```

- Complete the installation as normal.
- Post-install:
  - Install the SPICE agent (`spice-vdagent`) in the guest to enable
    copy/paste and USB redirection
    - `sudo apt install spice-vdagent`
  - Install the SPICE WebDAV agent (`spice-webdavd`) in the guest to
    enable file sharing.
    - `sudo apt install spice-webdavd`

### Ubuntu daily-live images

`quickget` can also download/refresh daily-live images via `zsync` for
Ubuntu developers and testers.

``` shell
quickget ubuntu daily-live
quickemu --vm ubuntu-daily-live.conf
```

You can run `quickget ubuntu daily-live` to refresh your daily
development image as often as you like, it will even automatically
switch to a new series.

### Ubuntu Flavours

All the official Ubuntu flavours are supported, just replace `ubuntu`
with your preferred flavour.

The project
[wiki](https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines)
may have further information.

- `edubuntu` (Edubuntu)
- `kubuntu` (Kubuntu)
- `lubuntu` (Lubuntu)
- `ubuntu-budgie` (Ubuntu Budgie)
- `ubuntucinnamon` (Ubuntu Cinnamon)
- `ubuntukylin` (Ubuntu Kylin)
- `ubuntu-mate` (Ubuntu MATE)
- `ubuntu-server` (Ubuntu Server)
- `ubuntustudio` (Ubuntu Studio)
- `ubuntu` (Ubuntu)
- `ubuntu-unity` (Ubuntu Unity)
- `xubuntu` (Xubuntu)

You can also use `quickget` with advanced options :

``` text
  --download      <os> <release> [edition] : Download image; no VM configuration
  --create-config <os> [path/url] [flags]  : Create VM config for an OS image
  --open-homepage <os>                     : Open homepage for the OS
  --show          [os]                     : Show OS information
  --version                                : Show version
  --help                                   : Show this help message
  --disable-unattended                     : Force quickget not to set up an unattended installation
  --url           [os] [release] [edition] : Show image URL(s)
  --check         [os] [release] [edition] : Check image URL(s)
  --list                                   : List all supported systems
  --list-csv                               : List everything in csv format
  --list-json                              : List everything in json format
```

Here are some typical uses

``` shell
    # show an OS ISO download URL for {os} {release} [edition]
    quickget --url fedora 38 Silverblue
    # test if an OS ISO is available for {os} {release} [edition]
    quickget --check nixos unstable plasma5
    # open an OS distribution homepage in a browser
    quickget --open-homepage  ubuntu-mate
    # Only download image file into current directory, without creating VM
    quickget --download elementary 7.1
```

The `--url`, `--check`, and `--download` options are fully functional
for all operating systems, including Windows and macOS.

Further information is available from the project
[wiki](https://github.com/quickemu-project/quickemu/wiki/06-Advanced-quickget-features)

### Other Operating Systems

`quickget` also supports:

- `alma` (AlmaLinux)
- `alpine` (Alpine Linux)
- `android` (Android x86)
- `antix` (Antix)
- `archcraft` (Archcraft)
- `archlinux` (Arch Linux)
- `artixlinux` (Artix Linux)
- `athenaos` (Athena OS)
- `batocera` (Batocera)
- `bazzite` (Bazzite)
- `biglinux` (BigLinux)
- `blendos` (BlendOS)
- `bodhi` (Bodhi)
- `bunsenlabs` (BunsenLabs)
- `cachyos` (CachyOS)
- `centos-stream` (CentOS Stream)
- `chimeralinux` (Chimera Linux)
- `crunchbang++` (Crunchbangplusplus)
- `debian` (Debian)
- `deepin` (Deepin)
- `devuan` (Devuan)
- `dragonflybsd` (DragonFlyBSD)
- `easyos` (EasyOS)
- `elementary` (elementary OS)
- `endeavouros` (EndeavourOS)
- `endless` (Endless OS)
- `fedora` (Fedora)
- `freebsd` (FreeBSD)
- `freedos` (FreeDOS)
- `garuda` (Garuda Linux)
- `gentoo` (Gentoo)
- `ghostbsd` (GhostBSD)
- `gnomeos` (GNOME OS)
- `guix` (Guix)
- `haiku` (Haiku)
- `holoiso` (HoloISO)
- `kali` (Kali)
- `kdeneon` (KDE Neon)
- `kolibrios` (KolibriOS)
- `linuxlite` (Linux Lite)
- `linuxmint` (Linux Mint)
- `lmde` (Linux Mint Debian Edition)
- `maboxlinux` (Mabox Linux)
- `mageia` (Mageia)
- `manjaro` (Manjaro)
- `mxlinux` (MX Linux)
- `netboot` (netboot.xyz)
- `netbsd` (NetBSD)
- `nitrux` (Nitrux)
- `nixos` (NixOS)
- `nwg-shell` (nwg-shell)
- `openbsd` (OpenBSD)
- `openindiana` (OpenIndiana)
- `opensuse` (openSUSE)
- `oraclelinux` (Oracle Linux)
- `parrotsec` (Parrot Security)
- `pclinuxos` (PCLinuxOS)
- `peppermint` (PeppermintOS)
- `popos` (Pop!\_OS)
- `porteus` (Porteus)
- `primtux` (PrimTux)
- `proxmox-ve` (Proxmox VE)
- `pureos` (PureOS)
- `reactos` (ReactOS)
- `rebornos` (RebornOS)
- `rockylinux` (Rocky Linux)
- `siduction` (Siduction)
- `slackware` (Slackware)
- `slax` (Slax)
- `slint` (Slint)
- `slitaz` (SliTaz)
- `solus` (Solus)
- `spirallinux` (SpiralLinux)
- `tails` (Tails)
- `tinycore` (Tiny Core Linux)
- `trisquel` (Trisquel-)
- `truenas-core` (TrueNAS Core)
- `truenas-scale` (TrueNAS Scale)
- `tuxedo-os` (Tuxedo OS)
- `vanillaos` (Vanilla OS)
- `void` (Void Linux)
- `vxlinux` (VX Linux)
- `zorin` (Zorin OS)

### [Custom Linux guests](https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines#manually-create-linux-guests)

Or you can download a Linux image and manually create a VM
configuration.

- Download a .iso image of a Linux distribution
- Create a VM configuration file; for example `debian-bullseye.conf`

``` shell
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

- Use `quickemu` to start the virtual machine:

``` shell
quickemu --vm debian-bullseye.conf
```

- Complete the installation as normal.
- Post-install:
  - Install the SPICE agent (`spice-vdagent`) in the guest to enable
    copy/paste and USB redirection.
  - Install the SPICE WebDAV agent (`spice-webdavd`) in the guest to
    enable file sharing.

## Supporting old Linux distros

If you want to run an old Linux , from 2016 or earlier, change the
`guest_os` to `linux_old`. This will enable the `vmware-svga` graphics
driver which is better supported on older distros.

## [Creating macOS Guests](https://github.com/quickemu-project/quickemu/wiki/03-Create-macOS-virtual-machines#automatically-create-macos-guests) 🍏

**Installing macOS in a VM can be a bit finicky, if you encounter
problems, [check the
Discussions](https://github.com/quickemu-project/quickemu/discussions)
for solutions or ask for help there** 🛟

`quickget` automatically downloads a macOS recovery image and creates a
virtual machine configuration.

``` shell
quickget macos big-sur
quickemu --vm macos-big-sur.conf
```

macOS `mojave`, `catalina`, `big-sur`, `monterey`, `ventura` and
`sonoma` are supported.

- Use cursor keys and enter key to select the **macOS Base System**
- From **macOS Utilities**
  - Click **Disk Utility** and **Continue**
    - Select `QEMU HARDDISK Media` (~103.08GB) from the list (on Big Sur
      and above use `Apple Inc. VirtIO Block Device`) and click
      **Erase**.
    - Enter a `Name:` for the disk
    - If you are installing macOS Mojave or later (Catalina, Big Sur,
      Monterey, Ventura and Sonoma), choose any of the APFS options as
      the filesystem. MacOS Extended may not work.
  - Click **Erase**.
  - Click **Done**.
  - Close Disk Utility
- From **macOS Utilities**
  - Click **Reinstall macOS** and **Continue**
- Complete the installation as you normally would.
  - On the first reboot use cursor keys and enter key to select **macOS
    Installer**
  - On the subsequent reboots use cursor keys and enter key to select
    the disk you named
- Once you have finished installing macOS you will be presented with an
  the out-of-the-box first-start wizard to configure various options and
  set up your username and password
- OPTIONAL: After you have concluded the out-of-the-box wizard, you may
  want to enable the TRIM feature that the computer industry created for
  SSD disks. This feature in our macOS installation will allow QuickEmu
  to compact (shrink) your macOS disk image whenever you delete files
  inside the Virtual Machine. Without this step your macOS disk image
  will only ever get larger and will not shrink even when you delete
  lots of data inside macOS.
  - To enable TRIM, open the Terminal application and type the following
    command followed by pressing <kbd>enter</kbd> to tell macos to use
    the TRIM command on the hard disk when files are deleted:

``` shell
sudo trimforce enable
```

You will be prompted to enter your account's password to gain the
privilege needed. Once you've entered your password and pressed
<kbd>enter</kbd> the command will request confirmation in the form of
two questions that require you to type <kbd>y</kbd> (for a "yes"
response) followed by <kbd>enter</kbd> to confirm.

If you press <kbd>enter</kbd> without first typing <kbd>y</kbd> the
system will consider that a negative response as though you said "no":

``` plain
IMPORTANT NOTICE: This tool force-enables TRIM for all relevant attached devices, even though such devices may not have been validated for data integrity while using TRIM. Use of this tool to enable TRIM may result in unintended data loss or data corruption. It should not be used in a commercial operating environment or with important data. Before using this tool, you should back up all of your data and regularly back up data while TRIM is enabled. This tool is provided on an "as is" basis. APPLE MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THIS TOOL OR ITS USE ALONE OR IN COMBINATION WITH YOUR DEVICES, SYSTEMS, OR SERVICES. BY USING THIS TOOL TO ENABLE TRIM, YOU AGREE THAT, TO THE EXTENT PERMITTED BY APPLICABLE LAW, USE OF THE TOOL IS AT YOUR SOLE RISK AND THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND EFFORT IS WITH YOU.
Are you sure you with to proceed (y/N)?
```

And a second confirmation once you've confirmed the previous one:

``` plain
Your system will immediately reboot when this is complete.
Is this OK (y/N)?
```

As the last message states, your system will automatically reboot as
soon as the command completes.

The default macOS configuration looks like this:

``` shell
guest_os="macos"
img="macos- big-sur/RecoveryImage.img"
disk_img="macos- big-sur/disk.qcow2"
macos_release=" big-sur"
```

- `guest_os="macos"` instructs Quickemu to optimise for macOS.
- `macos_release=" big-sur"` instructs Quickemu to optimise for a
  particular macOS release.
  - For example VirtIO Network and Memory Ballooning are available in
    Big Sur and newer, but not previous releases.
  - And VirtIO Block Media (disks) are supported/stable in Catalina and
    newer.

# macOS compatibility

There are some considerations when running macOS via Quickemu.

- Supported macOS releases:
  - Mojave
  - Catalina
  - Big Sur
  - Monterey
  - Ventura
  - Sonoma
- `quickemu` will automatically download the required
  [OpenCore](https://github.com/acidanthera/OpenCorePkg) bootloader and
  OVMF firmware from [OSX-KVM](https://github.com/kholia/OSX-KVM).
- Optimised by default, but no GPU acceleration is available.
  - Host CPU vendor is detected and guest CPU is optimised accordingly.
  - [VirtIO Block
    Media](https://www.kraxel.org/blog/2019/06/macos-qemu-guest/) is
    used for the system disk where supported.
  - [VirtIO `usb-tablet`](http://philjordan.eu/osx-virt/) is used for
    the mouse.
  - VirtIO Network (`virtio-net`) is supported and enabled on macOS Big
    Sur and newer, but earlier releases use `vmxnet3`.
  - VirtIO Memory Ballooning is supported and enabled on macOS Big Sur
    and newer but disabled for other support macOS releases.
- USB host and SPICE pass-through is:
  - UHCI (USB 2.0) on macOS Catalina and earlier.
  - XHCI (USB 3.0) on macOS Big Sur and newer.
- Display resolution can be changed via `quickemu` using `--width` and
  `--height` command line arguments.
- **Full Duplex audio requires [VoodooHDA
  OC](https://github.com/chris1111/VoodooHDA-OC) or pass-through a USB
  audio-device to the macOS guest VM**.
  - NOTE! [Gatekeeper](https://disable-gatekeeper.github.io/) and
    [System Integrity Protection
    (SIP)](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection)
    need to be disabled to install VoodooHDA OC
- File sharing between guest and host is available via
  [virtio-9p](https://wiki.qemu.org/Documentation/9psetup) and [SPICE
  webdavd](https://gitlab.gnome.org/GNOME/phodav/-/merge_requests/24).
- Copy/paste via SPICE agent is **not available on macOS**.

# macOS App Store

If you see *"Your device or computer could not be verified"* when you
try to login to the App Store, make sure that your wired ethernet device
is `en0`. Use `ifconfig` in a terminal to verify this.

If the wired ethernet device is not `en0`, then then go to *System
Preferences* -\> *Network*, delete all the network devices and apply the
changes. Next, open a terminal and run the following:

``` shell
sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
```

Now reboot, and the App Store should work.

There may be further advice and information about macOS guests in the
project
[wiki](https://github.com/quickemu-project/quickemu/wiki/03-Create-macOS-virtual-machines#automatically-create-macos-guests).

## [Creating Windows guests](https://github.com/quickemu-project/quickemu/wiki/04-Create-Windows-virtual-machines) 🪟

`quickget` can download [**Windows
10**](https://www.microsoft.com/software-download/windows10) and
[**Windows 11**](https://www.microsoft.com/software-download/windows11)
automatically and create an optimised virtual machine configuration.
This configuration also includes the [VirtIO drivers for
Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/).

**Windows 8.1** is also supported but doesn't feature any automated
installation or driver optimisation.

`quickget` can also download [Windows 10
LTSC](https://www.microsoft.com/en-us/evalcenter/download-windows-10-enterprise)
and Windows Server
[2012-r2](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2012-r2),
[2016](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2016),
[2019](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019),
and
[2022](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022).
No automated installation is supported for these releases.

``` shell
quickget windows 11
quickemu --vm windows-11.conf
```

- Complete the installation as you normally would.
- All relevant drivers and services should be installed automatically.
- A local administrator user account is automatically created, with
  these credentials:
  - Username: `Quickemu`
  - Password: `quickemu`

Further information is available from the project
[wiki](https://github.com/quickemu-project/quickemu/wiki/04-Create-Windows-virtual-machines)

## Configuration

Here are the usage instructions:

``` text
Usage
  quickemu --vm ubuntu.conf <arguments>

Arguments
  --access                          : Enable remote spice access support. 'local' (default), 'remote', 'clientipaddress'
  --braille                         : Enable braille support. Requires SDL.
  --delete-disk                     : Delete the disk image and EFI variables
  --delete-vm                       : Delete the entire VM and its configuration
  --display                         : Select display backend. 'sdl' (default), 'cocoa', 'gtk', 'none', 'spice' or 'spice-app'
  --fullscreen                      : Starts VM in full screen mode (Ctl+Alt+f to exit)
  --ignore-msrs-always              : Configure KVM to always ignore unhandled machine-specific registers
  --kill                            : Kill the VM process if it is running
  --offline                         : Override all network settings and start the VM offline
  --shortcut                        : Create a desktop shortcut
  --snapshot apply <tag>            : Apply/restore a snapshot.
  --snapshot create <tag>           : Create a snapshot.
  --snapshot delete <tag>           : Delete a snapshot.
  --snapshot info                   : Show disk/snapshot info.
  --status-quo                      : Do not commit any changes to disk/snapshot.
  --viewer <viewer>                 : Choose an alternative viewer. @Options: 'spicy' (default), 'remote-viewer', 'none'
  --width <width>                   : Set VM screen width; requires '--height'
  --height <height>                 : Set VM screen height; requires '--width'
  --ssh-port <port>                 : Set SSH port manually
  --spice-port <port>               : Set SPICE port manually
  --public-dir <path>               : Expose share directory. @Options: '' (default: xdg-user-dir PUBLICSHARE), '<directory>', 'none'
  --monitor <type>                  : Set monitor connection type. @Options: 'socket' (default), 'telnet', 'none'
  --monitor-telnet-host <ip/host>   : Set telnet host for monitor. (default: 'localhost')
  --monitor-telnet-port <port>      : Set telnet port for monitor. (default: '4440')
  --monitor-cmd <cmd>               : Send command to monitor if available. (Example: system_powerdown)
  --serial <type>                   : Set serial connection type. @Options: 'socket' (default), 'telnet', 'none'
  --serial-telnet-host <ip/host>    : Set telnet host for serial. (default: 'localhost')
  --serial-telnet-port <port>       : Set telnet port for serial. (default: '6660')
  --keyboard <type>                 : Set keyboard. @Options: 'usb' (default), 'ps2', 'virtio'
  --keyboard_layout <layout>        : Set keyboard layout: 'en-us' (default)
  --mouse <type>                    : Set mouse. @Options: 'tablet' (default), 'ps2', 'usb', 'virtio'
  --usb-controller <type>           : Set usb-controller. @Options: 'ehci' (default), 'xhci', 'none'
  --sound-card <type>               : Set sound card. @Options: 'intel-hda' (default), 'ac97', 'es1370', 'sb16', 'usb-audio', 'none'
  --sound-duplex <type>             : Set sound card duplex. @Options: 'hda-micro' (default: speaker/mic), 'hda-duplex' (line-in/line-out), 'hda-output' (output-only)
  --extra_args <arguments>          : Pass additional arguments to qemu
  --version                         : Print version
```

## Desktop shortcuts

Desktop shortcuts can be created for a VM, the shortcuts are saved in
`~/.local/share/applications`. Here is an example of how to create a
shortcut.

``` shell
quickemu --vm ubuntu-22.04-desktop.conf --shortcut
```

## References

Useful reference that assisted the development of Quickemu.

- General
  - [QEMU's documentation!](https://qemu.readthedocs.io/en/latest/)
  - <https://pve.proxmox.com/wiki/Qemu/KVM_Virtual_Machines>
  - <https://www.kraxel.org/blog/2020/01/qemu-sound-audiodev/>
- macOS
  - <https://www.nicksherlock.com/2020/06/installing-macos-big-sur-on-proxmox/>
  - <https://passthroughpo.st/mac-os-adds-early-support-for-virtio-qemu/>
  - <https://github.com/kholia/OSX-KVM>
  - <https://github.com/thenickdude/KVM-Opencore>
  - <https://gist.github.com/MCJack123/943eaca762730ca4b7ae460b731b68e7>
  - <https://github.com/acidanthera/OpenCorePkg/tree/master/Utilities/macrecovery>
  - <https://www.kraxel.org/blog/2017/09/running-macos-as-guest-in-kvm/>
  - <https://www.nicksherlock.com/2017/10/passthrough-of-advanced-cpu-features-for-macos-high-sierra-guests/>
  - <http://philjordan.eu/osx-virt/>
  - <https://github.com/Dids/clover-builder>
  - [OpenCore Configurator](https://mackie100projects.altervista.org)
- Windows
  - <https://www.heiko-sieger.info/running-windows-10-on-linux-using-kvm-with-vga-passthrough/>
  - <https://leduccc.medium.com/improving-the-performance-of-a-windows-10-guest-on-qemu-a5b3f54d9cf5>
  - <https://frontpagelinux.com/tutorials/how-to-use-linux-kvm-to-optimize-your-windows-10-virtual-machine/>
  - <https://turlucode.com/qemu-command-line-args/>
  - <https://github.com/pbatard/Fido>
  - <https://www.catapultsystems.com/blogs/create-zero-touch-windows-10-iso/>
- TPM
  - <https://qemu-project.gitlab.io/qemu/specs/tpm.html>
  - <https://www.tecklyfe.com/how-to-create-a-windows-11-virtual-machine-in-qemu/>
- 9p & virtiofs
  - <https://wiki.qemu.org/Documentation/9p>
  - <https://wiki.qemu.org/Documentation/9psetup>
  - <https://www.kraxel.org/blog/2019/06/macos-qemu-guest/>
  - <https://superuser.com/questions/628169/how-to-share-a-directory-with-the-host-without-networking-in-qemu>
  - <https://virtio-fs.gitlab.io/>

# AUTHORS

Written by Martin Wimpress.

# BUGS

Submit bug reports online at:
<https://github.com/quickemu-project/quickemu/issues>

# SEE ALSO

Full sources at: <https://github.com/quickemu-project/quickemu>

quickemu_conf(5), quickget(1), quickgui(1)
