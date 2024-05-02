<div align="center">

<img src=".github/logo.png" alt="Quickemu" width="256" />

# Quickemu

**Quickly create and run optimised Windows, macOS and Linux virtual machines:**

</div>

``` shell
quickget ubuntu-mate 22.04
quickemu --vm ubuntu-mate-22.04.conf
```

<div align="center">

<img src=".github/screenshot.png" alt="Quickemu Screenshot" />

**Made with 💝 for <img src=".github/tux.png" align="top" width="24" alt="Tux (Linux)"/>**

We have a Discord for this project:

[![Discord](https://img.shields.io/discord/712850672223125565?color=0C306A&label=WimpysWorld%20Discord&logo=Discord&logoColor=ffffff&style=flat-square)](https://discord.gg/sNmz3uw)

</div>

## Introduction

**Quickemu** is a wrapper for the excellent
[QEMU](https://www.qemu.org/) that attempts to automatically *"do the
right thing"*, rather than expose exhaustive configuration options. You
decide what operating system you want to run, and Quickemu will figure
out the best way to do it for you.

The original objective of the project was to [enable quick testing of
Linux distributions](https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines) where the virtual machine
configurations can be stored anywhere (such as external USB storage or
your home directory) and no elevated permissions are required to run the
virtual machines.

**Quickemu now also includes comprehensive support for
[macOS](#creating-macos-guests-) and
[Windows](#creating-windows-guests-)**.

## Features

-   **macOS** Sonoma, Ventura, Monterey, Big Sur, Catalina, Mojave &
    High Sierra
-   **Windows** 10 and 11 including TPM 2.0
-   [Ubuntu](https://ubuntu.com/desktop) and all the **[official Ubuntu
    flavours](https://ubuntu.com/download/flavours)**
-   **Nearly 1000 operating system editions are supported!**
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

## Quick start

[Once Quickemu is installed](https://github.com/quickemu-project/quickemu/wiki/01-Installation), there are two simple steps to create and run a virtual machine:

- `quickget` automatically downloads the ISO image for the operating system you want to run and creates a configuration file for the virtual machine.

```shell
quickget nixos unstable
```

- `quickemu` starts the virtual machine using the configuration file created by `quickget`.

```shell
quickemu --vm nixos-unstable.conf
```
- Execute `quickget` (with no arguments) to see a list of all the supported operating systems.

## Documentation

The wiki describes how to quickly get up and running with `quickemu` and also covers more advanced configuration and usage.

- [**Installation**](https://github.com/quickemu-project/quickemu/wiki/01-Installation) 💾
- [**Create Linux virtual machines**](https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines) 🐧
- [**Create macOS virtual machines**](https://github.com/quickemu-project/quickemu/wiki/03-Create-macOS-virtual-machines) 🍏
- [**Create Windows virtual machines**](https://github.com/quickemu-project/quickemu/wiki/04-Create-Windows-virtual-machines) 🪟
- [**Advanced quickemu configuration**](https://github.com/quickemu-project/quickemu/wiki/05-Advanced-quickemu-configuration) 🔧
- [**Advanced quickget features**](https://github.com/quickemu-project/quickemu/wiki/06-Advanced-quickget-features) 🤓
- [**Alternative frontends**](https://github.com/quickemu-project/quickemu/wiki/07-Alternative-frontends) 🧑‍💻

## Configuration

Here are the usage instructions:

``` text

Usage
  quickemu --vm ubuntu.conf [optional params]

List of optional parameters:
  --access                          : Enable remote spice access support. 'local' (default), 'remote', 'clientipaddress'
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
  --width <width>                   : Set VM screen width. Does nothing without --height
  --height <height>                 : Set VM screen height. Does nothing without --width
  --ssh-port <port>                 : Set ssh-port manually
  --spice-port <port>               : Set spice-port manually
  --public-dir <path>               : Expose share directory. @Options: '' (default: xdg-user-dir PUBLICSHARE), '<directory>', 'none'
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
  --sound-card <type>               : Set sound card. @Options: 'intel-hda' (default), 'ac97', 'es1370', 'sb16', 'none'
  --extra_args <arguments>          : Pass additional arguments to qemu
  --version                         : Print version
```

## References

Here's a collection of useful references that assisted the development of Quickemu.

-   General
    -   [QEMU's documentation!](https://qemu.readthedocs.io/en/latest/)
    -   <https://pve.proxmox.com/wiki/Qemu/KVM_Virtual_Machines>
    -   <https://www.kraxel.org/blog/2020/01/qemu-sound-audiodev/>
-   macOS
    -   <https://www.nicksherlock.com/2020/06/installing-macos-big-sur-on-proxmox/>
    -   <https://passthroughpo.st/mac-os-adds-early-support-for-virtio-qemu/>
    -   <https://github.com/kholia/OSX-KVM>
    -   <https://github.com/thenickdude/KVM-Opencore>
    -   <https://gist.github.com/MCJack123/943eaca762730ca4b7ae460b731b68e7>
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
