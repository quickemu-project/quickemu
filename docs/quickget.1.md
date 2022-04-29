---
author: Martin Wimpress
date: February 20, 2022
footer: quickget
header: Quickget User Manual
section: 1
title: QUICKGET
---

# NAME

quickget - download and prepare materials for building a quickemu VM

# SYNOPSIS

**quickget** \[*os*\] \[*release*\] \[*edition*\] \| \[*OPTION*\]\*

# DESCRIPTION

**quickget** will download the requisite materials and prepare a
configuration for `quickemu` to use to build and run

# OPTIONS

**version \| -version \| --version**
:   show version (from Quickemu)

**list \| list_csv \| list_json**
:   provide a csv list of all supported guest OSes, versions and
    variants.

**\[OS\] \[Release\] \[Edition\]**
:   specify the OS and release (and optional edition) if insufficient
    input is provided a list of missing options will be reported and the
    script will exit. Editions may not apply and will be defaulted if
    not provided.

# NOTES

## Ubuntu Guest

`quickget` will automatically download an Ubuntu release and create the
virtual machine configuration.

``` bash
quickget ubuntu 22.04
quickemu --vm ubuntu-22.04.conf
```

-   Complete the installation as normal.
-   Post-install:
    -   Install the SPICE agent (`spice-vdagent`) to enable copy/paste
        and USB redirection
        -   `sudo apt install spice-vdagent`
    -   Install the SPICE WebDAV agent (`spice-webdavd`) to enable file
        sharing.
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
-   `ubuntukylin` (Ubuntu Kylin)
-   `ubuntu-mate` (Ubuntu MATE)
-   `ubuntustudio` (Ubuntu Studio)
-   `ubuntu` (Ubuntu)
-   `xubuntu` (Xubuntu)

## Other Operating Systems

`quickget` also supports:

## Other Operating Systems

`quickget` also supports:

-   `alma` (Alma Linux)
-   `alpine` (Alpine Linux)
-   `android` (Android x86)
-   `archlinux` (Arch Linux)
-   `arcolinux` (Arco Linux)
-   `cachyos` (CachyOS)
-   `debian` (Debian)
-   `devuan` (Devuan)
-   `dragonflybsd` (DragonFlyBSD)
-   `elementary` (elementary OS)
-   `fedora` (Fedora)
-   `freebsd` (FreeBSD)
-   `freedos` (FreeDOS)
-   `garuda` (Garuda Linux)
-   `gentoo` (Gentoo)
-   `ghostbsd` (GhostBSD)
-   `haiku` (Haiku)
-   `kali` (Kali)
-   `kdeneon` (KDE Neon)
-   `kolibrios` (KolibriOS)
-   `linuxmint` (Linux Mint)
-   `manjaro` (Manjaro)
-   `mxlinux` (MX Linux)
-   `netboot` (netboot.xyz)
-   `netbsd` (NetBSD)
-   `nixos` (NixOS)
-   `openbsd` (OpenBSD)
-   `opensuse` (openSUSE)
-   `oraclelinux` (Oracle Linux)
-   `popos` (Pop!\_OS)
-   `regolith` (Regolith Linux)
-   `rockylinux` (Rocky Linux)
-   `slackware` (Slackware)
-   `solus` (Solus)
-   `tails` (Tails)
-   `void` (Void Linux)
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
    -   Install the SPICE agent (`spice-vdagent`) to enable copy/paste
        and USB redirection.
    -   Install the SPICE WebDAV agent (`spice-webdavd`) to enable file
        sharing.

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
        -   On macOS Catalina, Big Sur & Monterey
            -   Select `Apple Inc. VirtIO Block Media` from the list and
                click **Erase**.
        -   On macOS Mojave and High Sierra
            -   Select `QEMU HARDDISK Media` (\~103.08GB) from the list
                and click **Erase**.
    -   Enter a `Name:` for the disk and click **Erase**.
    -   Click **Done**.
    -   Close Disk Utility
-   From **macOS Utilities**
    -   Click **Reinstall macOS** and **Continue**
-   Complete the installation as you normally would.
    -   On the first reboot use cursor keys and enter key to select
        **macOS Installer**
    -   On the subsequent reboots use cursor keys and enter key to
        select the disk you named

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
-   Full Duplex audio works on macOS High Sierra, Mojave and Catalina.
    -   **macOS Big Sur and Monterey have no audio at all**.
-   File sharing between guest and host is available via
    [virtio-9p](https://wiki.qemu.org/Documentation/9psetup) and [SPICE
    webdavd](https://gitlab.gnome.org/GNOME/phodav/-/merge_requests/24).
-   Copy/paste via SPICE agent is **not available on macOS**.

## Windows 8.1, 10 & 11 Guests

`quickget` can automatically download Windows 8.1, [Windows
10](https://www.microsoft.com/en-gb/software-download/windows10ISO) and
[Windows
11](https://www.microsoft.com/en-gb/software-download/windows11) along
with the [VirtIO drivers for
Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/)
and creates a virtual machine configuration.

``` bash
quickget windows 11
quickemu --vm windows-11.conf
```

-   Complete the installation as you normally would.
-   All relevant drivers and services should be installed automatically.

### Regional versions

By default `quickget` will download the *"English International"*
release, but you can optionally specify one of the supported languages:
For example:

``` bash
quickget windows 11 "Chinese (Traditional)"
```

The default Windows 11 configuration looks like this:

``` bash
guest_os="windows"
disk_img="windows-11/disk.qcow2"
iso="windows-11/Win11_EnglishInternational_x64.iso"
fixed_iso="windows-11/virtio-win.iso"
tpm="on"
```

-   `guest_os="windows"` instructs `quickemu` to optimise for Windows.
-   `fixed_iso=` specifies the ISO image that provides VirtIO drivers.
-   `tpm="on"` instructs `quickemu` to create a software emulated TPM
    device using `swtpm`.

# AUTHORS

Written by Martin Wimpress.

# BUGS

Submit bug reports online at:
<https://github.com/quickemu-project/quickemu/issues>

# SEE ALSO

Full sources at: <https://github.com/quickemu-project/quickemu>

quickemu(1), quickemu_conf(1), quickgui(1)
