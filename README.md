<h1 align="center">
  <img src=".github/logo.png" alt="Quickemu" width="256" />
  <br />
  Quickemu
</h1>

<p align="center"><b>Quickly create and run optimised Windows, macOS and Linux desktop virtual machines.</b></p>
<div align="center"><img src=".github/screenshot.png" alt="Quickemu Screenshot" /></div>
<p align="center">Made with 💝 for <img src=".github/tux.png" align="top" width="18" /></p>

Introduction
------------

Quickly create and run highly optimised desktop virtual machines for
Linux, macOS and Windows; with just two commands. You decide what
operating system you want to run and Quickemu will figure out the best
way to do it for you. For example:

``` {.bash}
quickget ubuntu-mate impish
quickemu --vm ubuntu-mate-impish.conf
```

The original objective of the project was to enable quick testing of
Linux distributions where the virtual machine configurations can be
stored anywhere, such as external USB storage or your home directory,
and no elevated permissions are required to run the virtual machines.
**Quickemu now also includes comprehensive support for macOS and
Windows**.

Features
--------

-   **macOS** Monterey, Big Sur, Catalina, Mojave & High Sierra

-   **Windows** 8.1, 10 and 11 including TPM 2.0

-   [Ubuntu](https://ubuntu.com/desktop) and all the **[official Ubuntu
    flavours](https://ubuntu.com/download/flavours)**
-   [Fedora](https://getfedora.org/) & openSUSE
    ([Leap](https://get.opensuse.org/leap/),
    [Tumbleweed](https://get.opensuse.org/tumbleweed/),
    [MicroOS](https://microos.opensuse.org/))
-   [Linux Mint](https://linuxmint.com/) (Cinnamon, MATE, and XFCE),
    [elementary OS](https://elementary.io/),
    [Pop!\_OS](https://pop.system76.com/)
-   [Arch Linux](https://www.archlinux.org/),
    [Kali](https://www.kali.org/),[Garuda](https://garudalinux.org/),
    [ZorinOS](https://zorin.com/os/) & [NixOS](https://nixos.org/)
-   [Regolith Linux](https://regolith-linux.org/) (Release 1.6 and
    latest 2.0.0 pre-release )

-   [FreeBSD](https://www.freebsd.org/) &
    [OpenBSD](https://www.openbsd.org/)

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

Requirements
------------

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
-   [spicy](https://gitlab.freedesktop.org/spice/spice-gtk)
-   [swtpm](https://github.com/stefanberger/swtpm)
-   [Wget](https://www.gnu.org/software/wget/)
-   [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)
-   [xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr)
-   [zsync](http://zsync.moria.org.uk/)

Usage
=====

Graphical User Interfaces
-------------------------

While `quickemu` and `quickget` are designed for the terminal, a
graphical user interface is also available:

-   **[Quickgui](https://github.com/quickgui/quickgui)** by [Mark
    Johnson](https://github.com/marxjohnson) and [Yannick
    Mauray](https://github.com/ymauray).

Many thanks to [Luke Wesley-Holley](https://github.com/Lukewh) and
[Philipp Kiemle](https://github.com/daPhipz) for creating the
**[Quickemu icons](https://github.com/Lukewh/quickemu-icons)** 🎨

### Quickgui for Ubuntu

``` {.bash}
sudo add-apt-repository ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install quickgui
```

Install Quickemu
================

Ubuntu
------

Quickemu is available from a PPA for Ubuntu users. The Quickemu PPA also
includes a back port of QEMU 6.0.0 for 20.04 (Focal) and 21.04
(Hirsute). To install Quickemu and all the dependencies run the
following in a terminal:

``` {.bash}
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt update
sudo apt install quickemu
```

Other Linux
-----------

``` {.bash}
git clone --depth=1 https://github.com/wimpysworld/quickemu
cd quickemu
```

Now install all the **Requirements** documented above.

### Other sources

[Repology.org](https://repology.org/) found the following releases have
been packaged.

#### Quickemu

[![Packaging
status](https://repology.org/badge/vertical-allrepos/quickemu.svg)](https://repology.org/project/quickemu/versions)

#### Quickgui

[![Packaging
status](https://repology.org/badge/vertical-allrepos/quickgui.svg)](https://repology.org/project/quickgui/versions)

Ubuntu Guest
------------

`quickget` will automatically download an Ubuntu release and create the
virtual machine configuration.

``` {.bash}
quickget ubuntu focal
quickemu --vm ubuntu-focal.conf
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

``` {.bash}
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
-   `ubuntu-kylin` (Ubuntu Kylin)
-   `ubuntu-mate` (Ubuntu MATE)
-   `ubuntu-studio` (Ubuntu Studio)
-   `ubuntu` (Ubuntu)
-   `xubuntu` (Xubuntu)

Other Linux Guests
------------------

`quickget` also supports:

-   `alma` (Alma Linux)
-   `alpine` (Alpine Linux)
-   `archlinux` (Arch Linux)
-   `arcolinux` (Arco Linux)
-   `cachyos` (CachyOS)
-   `debian` (Debian)
-   `elementary` (elementary OS)
-   `fedora` (Fedora)
-   `garuda` (Garuda Linux)
-   `gentoo` (Gentoo)
-   `haiku` (Haiku)
-   `kali` (Kali)
-   `kdeneon` (KDE Neon)
-   `kolibrios` (KolibriOS)
-   `linuxmint-cinnamon` (Linux Mint Cinnamon)
-   `linuxmint-mate` (Linux Mint MATE)
-   `linuxmint-xfce` (Linux Mint XFCE)
-   `manjaro-budgie` (Manjaro Budgie)
-   `manjaro-cinnamon` (Manjaro Cinnamon)
-   `manjaro-deepin` (Manjaro Deepin)
-   `manjaro-gnome` (Manjaro Gnome)
-   `manjaro-i3` (Manjaro i3)
-   `manjaro-kde` (Manjaro KDE)
-   `manjaro-mate` (Manjaro MATE)
-   `manjaro-xfce` (Manjaro XFCE)
-   `mxlinux-fluxbox` (MX Linux Fluxbox)
-   `mxlinux-kde` (MX Linux KDE)
-   `mxlinux-xfce` (MX Linux XFCE)
-   `nixos-gnome` (NixOS Gnome)
-   `nixos-minimal` (NixOS Minimal)
-   `nixos-plasma5` (NixOS KDE)
-   `opensuse` (openSUSE)
-   `oraclelinux` (Oracle Linux)
-   `popos` (Pop!\_OS)
-   `regolith` (Regolith Linux)
-   `rockylinux` (Rocky Linux)
-   `solus` (Solus)
-   `tails` (Tails)
-   `void` (Void Linux)
-   `zorin` (Zorin OS)

### BSD Guest Support

-   `freebsd` (FreeBSD)
-   `openbsd` (OpenBSD)

Or you can download a Linux image and manually create a VM
configuration.

-   Download a .iso image of a Linux distribution
-   Create a VM configuration file; for example `debian-bullseye.conf`

``` {.bash}
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

-   Use `quickemu` to start the virtual machine:

``` {.bash}
quickemu --vm debian-bullseye.conf
```

-   Complete the installation as normal.
-   Post-install:
    -   Install the SPICE agent (`spice-vdagent`) to enable copy/paste
        and USB redirection.
    -   Install the SPICE WebDAV agent (`spice-webdavd`) to enable file
        sharing.

macOS Guest
-----------

`quickget` automatically downloads a macOS recovery image and creates a
virtual machine configuration.

``` {.bash}
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

``` {.bash}
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

Windows 8.1, 10 & 11 Guests
---------------------------

`quickget` can automatically download Windows 8.1, [Windows
10](https://www.microsoft.com/en-gb/software-download/windows10ISO) and
[Windows
11](https://www.microsoft.com/en-gb/software-download/windows11) along
with the [VirtIO drivers for
Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/)
and creates a virtual machine configuration.

``` {.bash}
quickget windows 11
quickemu --vm windows-11.conf
```

-   Complete the installation as you normally would.
-   All relevant drivers and services should be installed automatically.

### Regional versions

By default `quickget` will download the *"English International"*
release, but you can optionally specify one of the supported languages:
For example:

``` {.bash}
quickget windows 11 "Chinese (Traditional)"
```

The default Windows 11 configuration looks like this:

``` {.bash}
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

BSD Guests
----------

`quickemu` supports FreeBSD and OpenBSD.

``` {.bash}
quickget freebsd 13_0
quickemu --vm freebsd-13_0.conf
```

Other Guests
------------

-   `android` (Android x86)

Haiku Guests
------------

`quickemu` supports [Haiku](https://www.haiku-os.org/).

``` {.bash}
quickget quickget haiku r1beta3-x86_64
quickemu --vm haiku-r1beta3-x86_64.conf
```

At the moment the only way to share files between host and a Haiku guest
is by using SSH (having a SSH server running on the host):

On guest:

``` {.bash}
scp example.txt user@host-local-ip:/home/user # sending a file from guest to host
scp user@host-local-ip:/home/user/example.txt . # receiving a file from host to guest
```

`quickget` cannot automatically download and create virtual machines for
Haiku nightly versions, but they work if the ISO and configuration are
set up manually.

SPICE
=====

The following features are available while using the SPICE protocol:

-   Copy/paste between the guest and host
-   Host file sharing to the guest
-   USB device redirection

To use SPICE add `--display spice` to the Quickemu invocation, this
requires that the `spicy` client is installed, available from the
`spice-client-gtk` package in Debian/Ubuntu.

``` {.bash}
quickemu --vm ubuntu-focal.conf --display spice
```

Headless
--------

To start a VM with SPICE enabled, but no display attached use
`--display none`. This requires that the `spicy` client is installed,
available from the `spice-client-gtk` package in Debian/Ubuntu to
connect to the running VM

``` {.bash}
quickemu --vm ubuntu-focal.conf --display none
```

You can also use the `.ports` file in the VM directory to lookup what
SSH and SPICE ports the VM is connected to.

``` {.bash}
cat ubuntu-focal/ubuntu-focal.ports
```

Accessibility
=============

Qemu provides support for using BrlAPI to display braille output on a
real or fake device.

``` {.bash}
quickemu --vm ubuntu-impish.conf --accessibility braille --display sdl
```

or even

``` {.bash}
quickemu --vm ubuntu-impish.conf --acc brl --display sdl
```

BIOS and EFI
============

Since Quickemu 2.1.0 `efi` is the default boot option. If you want to
override this behaviour then add the following line to you VM
configuration to enable legacy BIOS.

-   `boot="legacy"` - Enable Legacy BIOS boot

Tuning CPU cores, RAM & disks
=============================

By default, Quickemu will calculate the number of CPUs cores and RAM to
allocate to a VM based on the specifications of your host computer. You
can override this default behaviour and tune the VM configuration to
your liking.

Add additional lines to your virtual machine configuration:

-   `cpu_cores="4"` - Specify the number of CPU cores allocated to the
    VM
-   `ram="4G"` - Specify the amount of RAM to allocate to the VM
-   `disk_size="16G"` - Specify the size of the virtual disk allocated
    to the VM

Disk preallocation
------------------

Preallocation mode (allowed values: `off` (default), `metadata`,
`falloc`, `full`). An image with preallocated metadata is initially
larger but can improve performance when the image needs to grow.

Specify what disk preallocation should be used, if any, when creating
the system disk image by adding a line like this to your VM
configuration.

-   `preallocation="metadata"`

CD-ROM disks
------------

If you want to expose an ISO image from the host to guest add the
following line to the VM configuration:

-   `fixed_iso="/path/to/image.iso"`

Floppy disks
------------

If you're like [Alan Pope](https://popey.com) you'll probably want to
mount a floppy disk image in the guest. To do so add the following line
to the VM configuration:

-   `floppy="/path/to/floppy.img"`

File Sharing
============

All File Sharing options will only expose `~/Public` (or localised
variations) for the current user to the guest VMs.

Samba 🐧 🍏 🪟
-----------

If `smbd` is available on the host, Quickemu will automatically enable
the built-in QEMU support for exposing a Samba share from the host to
the guest.

You can install the minimal Samba components on Ubuntu using:

``` {.bash}
sudo apt install --no-install-recommends samba
```

SPICE WebDAV 🐧 🪟
----------------

-   TBD

VirtIO-9P 🐧 🍏
-------------

-   TBD

Network port forwarding
=======================

Add an additional line to your virtual machine configuration. For
example:

-   `port_forwards=("8123:8123" "8888:80")`

In the example above:

-   Port 8123 on the host is forwarded to port 8123 on the guest.
-   Port 8888 on the host is forwarded to port 80 on the guest.

Bridged networking
==================

Connect your virtual machine to a preconfigured network bridge. Add an
additional line to your virtual machine configuration

-   `bridge="br0"`

USB redirection
===============

Quickemu supports USB redirection via SPICE pass-through and host
pass-through.

SPICE redirection (recommended)
-------------------------------

Using SPICE for USB pass-through is easiest as it doesn't require any
elevated permission, start Quickemu with `--display spice` and then
select `Input` -\> `Select USB Device for redirection` from the menu to
choose which device(s) you want to attach to the guest.

Host redirection **NOT Recommended**
------------------------------------

**USB host redirection is not recommended**, it is provided purely for
backwards compatibility to older versions of Quickemu. Using SPICE is
preferred, see above.

Add an additional line to your virtual machine configuration. For
example:

-   `usb_devices=("046d:082d" "046d:085e")`

In the example above:

-   The USB device with vendor\_id 046d and product\_id 082d will be
    exposed to the guest.
-   The USB device with vendor\_id 046d and product\_id 085e will be
    exposed to the guest.

If the USB devices are not writable, `quickemu` will display the
appropriate commands to modify the USB device(s) access permissions,
like this:

     - USB:      Host pass-through requested:
                  - Sennheiser Communications EPOS GTW 270 on bus 001 device 005 needs permission changes:
                    sudo chown -v root:user /dev/bus/usb/001/005
                    ERROR! USB permission changes are required 👆

TPM
===

Since Quickemu 2.2.0 a software emulated TPM device can be added to
guest virtual machines. Just add `tpm="on"` to your VM configuration.
`quickget` will automatically add this line to Windows 11 virtual
machines.

All the options
===============

Here are the usage instructions:

``` {.bash}


Usage
  quickemu --vm ubuntu.conf

You can also pass optional parameters
  --accessible            : Select accessible facilitation. 'braille' (default - currently requires --display sdl )
  --delete-disk           : Delete the disk image and EFI variables
  --delete-vm             : Delete the entire VM and it's configuration
  --display               : Select display backend. 'sdl' (default), 'gtk', 'none', or 'spice'
  --fullscreen            : Starts VM in full screen mode (Ctl+Alt+f to exit)
  --ignore-msrs-always    : Configure KVM to always ignore unhandled machine-specific registers
  --screen <screen>       : Use specified screen to determine the window size.
  --shortcut              : Create a desktop shortcut
  --snapshot apply <tag>  : Apply/restore a snapshot.
  --snapshot create <tag> : Create a snapshot.
  --snapshot delete <tag> : Delete a snapshot.
  --snapshot info         : Show disk/snapshot info.
  --status-quo            : Do not commit any changes to disk/snapshot.
  --version               : Print version

```

Desktop shortcuts
-----------------

Desktop shortcuts can be created for a VM, the shortcuts are saved in
`~/.local/share/applications`. Here is an example of how to create a
shortcut.

``` {.bash}
quickemu --vm ubuntu-focal-desktop.conf --shortcut
```

Screen and window size (Linux guests only)
------------------------------------------

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

``` {.bash}
xrandr --listmonitors | grep -v Monitors
```

The command will output something like this:

``` {.bash}
 0: +*HDMI-0 2560/597x1440/336+1920+0  HDMI-0
 1: +DVI-D-0 1920/527x1080/296+0+0  DVI-D-0
```

The first number is what needs to be passed to the `--screen` option.

For example:

``` {.bash}
quickemu --vm vm.conf --screen 0
```

The above uses the 2560x1440 screen to compute the size of the window,
which Quickemu sizes to 2048x1152. Without the `--screen` option,
Quickemu would have used the 1920x1080 monitor which results in a window
size of 1664x936.

References
==========

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
