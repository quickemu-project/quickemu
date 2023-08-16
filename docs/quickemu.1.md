---
author: Martin Wimpress
date: June 14, 2023
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

**--braille**
:   Enable braille support. Requires SDL.

**--delete**
:   Delete the disk image.

**--display**
:   Select display backend. 'sdl' (default), 'gtk', 'none' or 'spice'

**--fullscreen**
:   Starts VM in full screen mode (Ctl+Alt+f to exit)

**--ignore-msrs-always**
:   Configure KVM to always ignore unhandled machine-specific registers

**--screen \<screen\>**
:   Use specified screen to determine the window size.

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

**--version**
:   Print version

# EXAMPLES

**quickemu --vm ubuntu-mate-22.04.conf**
:   Launches the VM specified in the file *ubuntu-mate-22.04.conf*

## Introduction

Quickly create and run highly optimised desktop virtual machines for
Linux, macOS and Windows; with just two commands. You decide what
operating system you want to run and Quickemu will figure out the best
way to do it for you. For example:

``` bash
quickget ubuntu-mate 22.04
quickemu --vm ubuntu-mate-22.04.conf
```

The original objective of the project was to enable quick testing of
Linux distributions where the virtual machine configurations can be
stored anywhere, such as external USB storage or your home directory,
and no elevated permissions are required to run the virtual machines.
**Quickemu now also includes comprehensive support for macOS and
Windows**.

## Features

-   **macOS** Monterey, Big Sur, Catalina, Mojave & High Sierra
-   **Windows** 10 and 11 including TPM 2.0
-   [Ubuntu](https://ubuntu.com/desktop) and all the **[official Ubuntu
    flavours](https://ubuntu.com/download/flavours)**
-   **Over 360 operating system editions are supported!**
-   Full SPICE support including host/guest clipboard sharing
-   VirtIO-webdavd file sharing for Linux and Windows guests
-   VirtIO-9p file sharing for Linux and macOS guests
-   [QEMU Guest Agent
    support](https://wiki.qemu.org/Features/GuestAgent); provides access
    to a system-level agent via standard QMP commands
-   Samba file sharing for Linux, macOS and Windows guests (*if `smbd`
    is installed on the host*)
-   VirGL acceleration
-   USB device pass-through
-   Smartcard pass-through
-   Automatic SSH port forwarding to guests
-   Network port forwarding
-   Full duplex audio
-   Braille support
-   EFI (with or without SecureBoot) and Legacy BIOS boot
-   Graphical user interfaces available

Quickemu is a wrapper for the excellent [QEMU](https://www.qemu.org/)
that attempts to automatically *"do the right thing"*, rather than
expose exhaustive configuration options.

We have a Discord for this project:
[![Discord](https://img.shields.io/discord/712850672223125565?color=0C306A&label=WimpysWorld%20Discord&logo=Discord&logoColor=ffffff&style=flat-square)](https://discord.gg/sNmz3uw)

See this (old) video where I explain some of my motivations for creating
Quickemu.

[![Replace VirtualBox with Bash &
QEMU](https://img.youtube.com/vi/AOTYWEgw0hI/0.jpg)](https://www.youtube.com/watch?v=AOTYWEgw0hI)

## Requirements

-   [QEMU](https://www.qemu.org/) (*6.0.0 or newer*) **with GTK, SDL,
    SPICE & VirtFS support**
-   [bash](https://www.gnu.org/software/bash/) (*4.0 or newer*)
-   [Coreutils](https://www.gnu.org/software/coreutils/)
-   [EDK II](https://github.com/tianocore/edk2)
-   [grep](https://www.gnu.org/software/grep/)
-   [jq](https://stedolan.github.io/jq/)
-   [LSB](https://wiki.linuxfoundation.org/lsb/start)
-   [procps](https://gitlab.com/procps-ng/procps)
-   [python3](https://www.python.org/)
-   [macrecovery](https://github.com/acidanthera/OpenCorePkg/tree/master/Utilities/macrecovery)
-   [mkisofs](http://cdrtools.sourceforge.net/private/cdrecord.html)
-   [usbutils](https://github.com/gregkh/usbutils)
-   [util-linux](https://github.com/karelzak/util-linux)
-   [sed](https://www.gnu.org/software/sed/)
-   [socat](http://www.dest-unreach.org/socat/)
-   [spicy](https://gitlab.freedesktop.org/spice/spice-gtk)
-   [swtpm](https://github.com/stefanberger/swtpm)
-   [Wget](https://www.gnu.org/software/wget/)
-   [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)
-   [xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr)
-   [zsync](http://zsync.moria.org.uk/)
-   [unzip](http://www.info-zip.org/UnZip.html)

### Installing Requirements

For Ubuntu, Arch and nixos systems the
[ppa](https://launchpad.net/~flexiondotorg/+archive/ubuntu/quickemu),
[AUR](https://aur.archlinux.org/packages/quickemu) or
[nix](https://github.com/NixOS/nixpkgs/tree/master/pkgs/development/quickemu)
packaging will take care of the dependencies. For other host
distributions or operating systems it will be necessary to install the
above requirements or their equivalents.

These examples may save a little typing

Debian (and direct derivatives such as MX Linux):

    sudo apt install qemu bash coreutils ovmf grep jq lsb-base procps python3 genisoimage usbutils util-linux sed spice-client-gtk libtss2-tcti-swtpm0 wget xdg-user-dirs zsync unzip

Fedora:

    sudo dnf install qemu bash coreutils edk2-tools grep jq lsb procps python3 genisoimage usbutils util-linux sed spice-gtk-tools swtpm wget xdg-user-dirs xrandr unzip

MacOS:

This is a work in progress (see [issue
248](https://github.com/quickemu-project/quickemu/issues/248) for other
steps and changes that may enable running on MacOS)

    brew install qemu bash coreutils grep jq python@3.10 cdrtools gnu-sed spice-gtk wget zsync

# Usage

## Graphical User Interfaces

While `quickemu` and `quickget` are designed for the terminal, a
graphical user interface is also available:

-   **[Quickgui](https://github.com/quickgui/quickgui)** by [Mark
    Johnson](https://github.com/marxjohnson) and [Yannick
    Mauray](https://github.com/ymauray).

Many thanks to [Luke Wesley-Holley](https://github.com/Lukewh) and
[Philipp Kiemle](https://github.com/daPhipz) for creating the
**[Quickemu icons](https://github.com/Lukewh/quickemu-icons)** 🎨

### Quickgui for Ubuntu

``` bash
sudo add-apt-repository ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install quickgui
```

## Ubuntu Guest

`quickget` will automatically download an Ubuntu release and create the
virtual machine configuration.

``` bash
quickget ubuntu 22.04
quickemu --vm ubuntu-22.04.conf
```

-   Complete the installation as normal.
-   Post-install:
    -   Install the SPICE agent (`spice-vdagent`) in the guest to enable
        copy/paste and USB redirection
        -   `sudo apt install spice-vdagent`
    -   Install the SPICE WebDAV agent (`spice-webdavd`) in the guest to
        enable file sharing.
        -   `sudo apt install spice-webdavd`

### Ubuntu devel (daily-live) images

`quickget` can also download/refresh devel images via `zsync` for Ubuntu
developers and testers.

``` bash
quickget ubuntu devel
quickemu --vm ubuntu-devel.conf
```

You can run `quickget ubuntu devel` to refresh your daily development
image as often as you like, it will even automatically switch to a new
series.

### Ubuntu Flavours

All the official Ubuntu flavours are supported, just replace `ubuntu`
with your preferred flavour.

-   `kubuntu` (Kubuntu)
-   `lubuntu` (Lubuntu)
-   `ubuntu-budgie` (Ubuntu Budgie)
-   `ubuntucinnamon` (Ubuntu Cinnamon)
-   `ubuntukylin` (Ubuntu Kylin)
-   `ubuntu-mate` (Ubuntu MATE)
-   `ubuntu-server` (Ubuntu Server)
-   `ubuntustudio` (Ubuntu Studio)
-   `ubuntu` (Ubuntu)
-   `ubuntu-unity` (Ubuntu Unity)
-   `xubuntu` (Xubuntu)

## Other Operating Systems

`quickget` also supports:

-   `alma` (Alma Linux)
-   `alpine` (Alpine Linux)
-   `android` (Android x86)
-   `archcraft` (Archcraft)
-   `archlinux` (Arch Linux)
-   `arcolinux` (Arco Linux)
-   `batocera` (Batocera)
-   `blendos` (BlendOS)
-   `cachyos` (CachyOS)
-   `centos-stream` (CentOS Stream)
-   `debian` (Debian)
-   `deepin` (Deepin)
-   `devuan` (Devuan)
-   `dragonflybsd` (DragonFlyBSD)
-   `elementary` (elementary OS)
-   `endeavouros` (EndeavourOS)
-   `endless` (Endless OS)
-   `fedora` (Fedora)
-   `freebsd` (FreeBSD)
-   `freedos` (FreeDOS)
-   `gentoo` (Gentoo)
-   `ghostbsd` (GhostBSD)
-   `haiku` (Haiku)
-   `holoiso` (HoloISO)
-   `kali` (Kali)
-   `kdeneon` (KDE Neon)
-   `kolibrios` (KolibriOS)
-   `linuxmint` (Linux Mint)
-   `lmde` (Linux Mint Debian Edition)
-   `mageia` (Mageia)
-   `manjaro` (Manjaro)
-   `mxlinux` (MX Linux)
-   `netboot` (netboot.xyz)
-   `netbsd` (NetBSD)
-   `nixos` (NixOS)
-   `openbsd` (OpenBSD)
-   `openindiana` (OpenIndiana)
-   `opensuse` (openSUSE)
-   `oraclelinux` (Oracle Linux)
-   `popos` (Pop!\_OS)
-   `reactos` (ReactOS)
-   `rebornos` (RebornOS)
-   `rockylinux` (Rocky Linux)
-   `siduction` (Siduction)
-   `slackware` (Slackware)
-   `solus` (Solus)
-   `tails` (Tails)
-   `truenas-core` (TrueNAS Core)
-   `truenas-scale` (TrueNAS Scale)
-   `vanillaos` (Vanilla OS)
-   `void` (Void Linux)
-   `vxlinux` (VX Linux)
-   `xerolinux` (XeroLinux)
-   `zorin` (Zorin OS)

Or you can download a Linux image and manually create a VM
configuration.

-   Download a .iso image of a Linux distribution
-   Create a VM configuration file; for example `debian-bullseye.conf`

``` bash
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

-   Use `quickemu` to start the virtual machine:

``` bash
quickemu --vm debian-bullseye.conf
```

-   Complete the installation as normal.
-   Post-install:
    -   Install the SPICE agent (`spice-vdagent`) in the guest to enable
        copy/paste and USB redirection.
    -   Install the SPICE WebDAV agent (`spice-webdavd`) in the guest to
        enable file sharing.

## macOS Guest

`quickget` automatically downloads a macOS recovery image and creates a
virtual machine configuration.

``` bash
quickget macos catalina
quickemu --vm macos-catalina.conf
```

macOS `high-sierra`, `mojave`, `catalina`, `big-sur` and `monterey` are
supported.

-   Use cursor keys and enter key to select the **macOS Base System**
-   From **macOS Utilities**
    -   Click **Disk Utility** and **Continue**
        -   Select `QEMU HARDDISK Media` (\~103.08GB) from the list (on
            Big Sur and above use `Apple Inc. VirtIO Block Device`) and
            click **Erase**.
        -   Enter a `Name:` for the disk
        -   If you are installing macOS Mojave or later (Catalina, Big
            Sur, and Monterey), choose any of the APFS options as the
            filesystem. MacOS Extended may not work.
    -   Click **Erase**.
    -   Click **Done**.
    -   Close Disk Utility
-   From **macOS Utilities**
    -   Click **Reinstall macOS** and **Continue**
-   Complete the installation as you normally would.
    -   On the first reboot use cursor keys and enter key to select
        **macOS Installer**
    -   On the subsequent reboots use cursor keys and enter key to
        select the disk you named
-   Once you have finished installing macOS you will be presented with
    an the out-of-the-box first-start wizard to configure various
    options and set up your username and password
-   OPTIONAL: After you have concluded the out-of-the-box wizard, you
    may want to enable the TRIM feature that the computer industry
    created for SSD disks. This feature in our macOS installation will
    allow QuickEmu to compact (shrink) your macOS disk image whenever
    you delete files inside the Virtual Machine. Without this step your
    macOS disk image will only ever get larger and will not shrink even
    when you delete lots of data inside macOS.
    -   To enable TRIM, open the Terminal application and type the
        following command followed by pressing
        `<kbd>`{=html}enter`</kbd>`{=html} to tell macos to use the TRIM
        command on the hard disk when files are deleted:

``` bash
sudo trimforce enable
```

You will be prompted to enter your account's password to gain the
privilege needed. Once you've entered your password and pressed
`<kbd>`{=html}enter`</kbd>`{=html} the command will request confirmation
in the form of two questions that require you to type
`<kbd>`{=html}y`</kbd>`{=html} (for a "yes" response) followed by
`<kbd>`{=html}enter`</kbd>`{=html} to confirm. If you press
`<kbd>`{=html}enter`</kbd>`{=html} without first typing
`<kbd>`{=html}y`</kbd>`{=html} the system will consider that a negative
response as though you said "no":

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

``` bash
guest_os="macos"
img="macos-catalina/RecoveryImage.img"
disk_img="macos-catalina/disk.qcow2"
macos_release="catalina"
```

-   `guest_os="macos"` instructs Quickemu to optimise for macOS.
-   `macos_release="catalina"` instructs Quickemu to optimise for a
    particular macOS release.
    -   For example VirtIO Network and Memory Ballooning are available
        in Big Sur and newer, but not previous releases.
    -   And VirtIO Block Media (disks) are supported/stable in Catalina
        and newer.

### macOS compatibility

There are some considerations when running macOS via Quickemu.

-   Supported macOS releases:
    -   High Sierra
    -   Mojave
    -   Catalina **(Recommended)**
    -   Big Sur
    -   Monterey
-   `quickemu` will automatically download the required
    [OpenCore](https://github.com/acidanthera/OpenCorePkg) bootloader
    and OVMF firmware from [OSX-KVM](https://github.com/kholia/OSX-KVM).
-   Optimised by default, but no GPU acceleration is available.
    -   Host CPU vendor is detected and guest CPU is optimised
        accordingly.
    -   [VirtIO Block
        Media](https://www.kraxel.org/blog/2019/06/macos-qemu-guest/) is
        used for the system disk where supported.
    -   [VirtIO `usb-tablet`](http://philjordan.eu/osx-virt/) is used
        for the mouse.
    -   VirtIO Network (`virtio-net`) is supported and enabled on macOS
        Big Sur and newer but previous releases use `vmxnet3`.
    -   VirtIO Memory Ballooning is supported and enabled on macOS Big
        Sur and newer but disabled for other support macOS releases.
-   USB host and SPICE pass-through is:
    -   UHCI (USB 2.0) on macOS Catalina and earlier.
    -   XHCI (USB 3.0) on macOS Big Sur and newer.
-   Display resolution can only be changed via macOS System Preferences.
-   **Full Duplex audio requires [VoodooHDA
    OC](https://github.com/chris1111/VoodooHDA-OC) or pass-through a USB
    audio-device to the macOS guest VM**.
-   NOTE! [Gatekeeper](https://disable-gatekeeper.github.io/) and
    [System Integrity Protection
    (SIP)](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection)
    need to be disabled to install VoodooHDA OC
-   File sharing between guest and host is available via
    [virtio-9p](https://wiki.qemu.org/Documentation/9psetup) and [SPICE
    webdavd](https://gitlab.gnome.org/GNOME/phodav/-/merge_requests/24).
-   Copy/paste via SPICE agent is **not available on macOS**.

### macOS App Store

If you see *"Your device or computer could not be verified"* when you
try to login to the App Store, make sure that your wired ethernet device
is `en0`. Use `ifconfig` in a terminal to verify this.

If the wired ethernet device is not `en0`, then then go to *System
Preferences* -\> *Network*, delete all the network devices and apply the
changes. Next, open a terminal and run the following:

``` bash
sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
```

Now reboot, and the App Store should work.

## Windows 10 & 11 Guests

`quickget` can download
[Windows10](https://www.microsoft.com/software-download/windows10) and
[Windows 11](https://www.microsoft.com/software-download/windows11)
automatically and create an optimised virtual machine configuration.
This configuration also includes the [VirtIO drivers for
Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/).

``` bash
quickget windows 11
quickemu --vm windows-11-22H2.conf
```

-   Complete the installation as you normally would.
-   All relevant drivers and services should be installed automatically.
-   A local administrator user account is automatically created, with
    these credentials:
    -   Username: `Quickemu`
    -   Password: `quickemu`

The default Windows 11 configuration looks like this:

``` bash
guest_os="windows"
disk_img="windows-11/disk.qcow2"
iso="windows-11/windows-11.iso"
fixed_iso="windows-11/virtio-win.iso"
tpm="on"
secureboot="on"
```

-   `guest_os="windows"` instructs `quickemu` to optimise for Windows.
-   `fixed_iso=` specifies the ISO image that provides VirtIO drivers.
-   `tpm="on"` instructs `quickemu` to create a software emulated TPM
    device using `swtpm`.

# All the options

Here are the usage instructions:


    Usage
      quickemu --vm ubuntu.conf

    You can also pass optional parameters
      --braille                         : Enable braille support. Requires SDL.
      --delete-disk                     : Delete the disk image and EFI variables
      --delete-vm                       : Delete the entire VM and it's configuration
      --display                         : Select display backend. 'sdl' (default), 'gtk', 'none', 'spice' or 'spice-app'
      --fullscreen                      : Starts VM in full screen mode (Ctl+Alt+f to exit)
      --ignore-msrs-always              : Configure KVM to always ignore unhandled machine-specific registers
      --screen <screen>                 : Use specified screen to determine the window size.
      --screenpct <percent>             : Percent of fullscreen for VM if --fullscreen is not specified.
      --shortcut                        : Create a desktop shortcut
      --snapshot apply <tag>            : Apply/restore a snapshot.
      --snapshot create <tag>           : Create a snapshot.
      --snapshot delete <tag>           : Delete a snapshot.
      --snapshot info                   : Show disk/snapshot info.
      --status-quo                      : Do not commit any changes to disk/snapshot.
      --viewer <viewer>                 : Choose an alternative viewer. @Options: 'spicy' (default), 'remote-viewer', 'none'
      --ssh-port <port>                 : Set ssh-port manually
      --spice-port <port>               : Set spice-port manually
      --public-dir <path>               : expose share directory. @Options: '' (default: xdg-user-dir PUBLICSHARE), '<directory>', 'none'
      --monitor <type>                  : Set monitor connection type. @Options: 'socket' (default), 'telnet', 'none'
      --monitor-telnet-host <ip/host>   : Set telnet host for monitor. (default: 'localhost')
      --monitor-telnet-port <port>      : Set telnet port for monitor. (default: '4440')
      --monitor-cmd <cmd>               : Send command to monitor if available. (Example: system_powerdown)
      --serial <type>                   : Set serial connection type. @Options: 'socket' (default), 'telnet', 'none'
      --serial-telnet-host <ip/host>    : Set telnet host for serial. (default: 'localhost')
      --serial-telnet-port <port>       : Set telnet port for serial. (default: '6660')
      --keyboard <type>                 : Set keyboard. @Options: 'usb' (default), 'ps2', 'virtio'
      --keyboard_layout <layout>        : Set keyboard layout.
      --mouse <type>                    : Set mouse. @Options: 'tablet' (default), 'ps2', 'usb', 'virtio'
      --usb-controller <type>           : Set usb-controller. @Options: 'ehci' (default), 'xhci', 'none'
      --extra_args <arguments>          : Pass additional arguments to qemu
      --version                         : Print version

## Desktop shortcuts

Desktop shortcuts can be created for a VM, the shortcuts are saved in
`~/.local/share/applications`. Here is an example of how to create a
shortcut.

``` bash
quickemu --vm ubuntu-22.04-desktop.conf --shortcut
```

## Screen and window size (Linux guests only)

`qemu` will always default to the primary monitor to display the VM's
window.

Without the `--screen` option, `quickemu` will look for the size of the
smallest monitor, and use a size that fits on said monitor.

The `--screen` option forces `quickemu` to use the size of the given
monitor to compute the size of the window. **It won't use that monitor
to display the VM's window if it's not the primary monitor**. This is
useful if the primary monitor if not the smallest one, and if the VM's
window doesn't need to be moved around.

The `--screen` option is also useful with the `--fullscreen` option,
again because `qemu` will always use the primary monitor. In order for
the fullscreen mode to work properly, the resolution of the VM's window
must match the resolution of the screen.

To know which screen to use, type:

``` bash
xrandr --listmonitors | grep -v Monitors
```

The command will output something like this:

``` bash
 0: +*HDMI-0 2560/597x1440/336+1920+0  HDMI-0
 1: +DVI-D-0 1920/527x1080/296+0+0  DVI-D-0
```

The first number is what needs to be passed to the `--screen` option.

For example:

``` bash
quickemu --vm vm.conf --screen 0
```

The above uses the 2560x1440 screen to compute the size of the window,
which Quickemu sizes to 2048x1152. Without the `--screen` option,
Quickemu would have used the 1920x1080 monitor which results in a window
size of 1664x936.

The '--screenpct' is an optional integer value between 25 \<= pct \<
100 which will override system default screen sizes. The VM size will be
'pct' of the chosen screen. **If --fullscreen is chosen screen will be
fullsize instead of being scaled down by --screenpct value.**

# References

Useful reference that assisted the development of Quickemu.

-   General
    -   [QEMU's documentation!](https://qemu.readthedocs.io/en/latest/)
    -   <https://pve.proxmox.com/wiki/Qemu/KVM_Virtual_Machines>
    -   <https://www.kraxel.org/blog/2020/01/qemu-sound-audiodev/>
-   macOS
    -   <https://www.nicksherlock.com/2020/06/installing-macos-big-sur-on-proxmox/>
    -   <https://passthroughpo.st/mac-os-adds-early-support-for-virtio-qemu/>
    -   <https://github.com/kholia/OSX-KVM>
    -   <https://github.com/thenickdude/KVM-Opencore>
    -   <https://github.com/acidanthera/OpenCorePkg/tree/master/Utilities/macrecovery>
    -   <https://www.kraxel.org/blog/2017/09/running-macos-as-guest-in-kvm/>
    -   <https://www.nicksherlock.com/2017/10/passthrough-of-advanced-cpu-features-for-macos-high-sierra-guests/>
    -   <http://philjordan.eu/osx-virt/>
    -   <https://github.com/Dids/clover-builder>
    -   [OpenCore
        Configurator](https://mackie100projects.altervista.org)
-   Windows
    -   <https://www.heiko-sieger.info/running-windows-10-on-linux-using-kvm-with-vga-passthrough/>
    -   <https://leduccc.medium.com/improving-the-performance-of-a-windows-10-guest-on-qemu-a5b3f54d9cf5>
    -   <https://frontpagelinux.com/tutorials/how-to-use-linux-kvm-to-optimize-your-windows-10-virtual-machine/>
    -   <https://turlucode.com/qemu-command-line-args/>
    -   <https://github.com/pbatard/Fido>
    -   <https://www.catapultsystems.com/blogs/create-zero-touch-windows-10-iso/>
-   TPM
    -   <https://qemu-project.gitlab.io/qemu/specs/tpm.html>
    -   <https://www.tecklyfe.com/how-to-create-a-windows-11-virtual-machine-in-qemu/>
-   9p & virtiofs
    -   <https://wiki.qemu.org/Documentation/9p>
    -   <https://wiki.qemu.org/Documentation/9psetup>
    -   <https://www.kraxel.org/blog/2019/06/macos-qemu-guest/>
    -   <https://superuser.com/questions/628169/how-to-share-a-directory-with-the-host-without-networking-in-qemu>
    -   <https://virtio-fs.gitlab.io/>

# AUTHORS

Written by Martin Wimpress.

# BUGS

Submit bug reports online at:
<https://github.com/quickemu-project/quickemu/issues>

# SEE ALSO

Full sources at: <https://github.com/quickemu-project/quickemu>

quickemu_conf(1), quickget(1), quickgui(1)
