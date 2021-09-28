<h1 align="center">
  <img src=".github/logo.png" alt="Quickemu" />
  <br />
  Quickemu
</h1>

<p align="center"><b>Simple script to "manage" Qemu virtual machines.</b></p>
<div align="center"><img src=".github/screenshot.png" alt="Quickemu Screenshot" /></div>
<p align="center">Made with 💝 for <img src=".github/tux.png" align="top" width="18" /></p>

# Introduction

Quickemu is a simple script to *"manage"* Qemu virtual machines. Each virtual
machine configuration is a few lines long requiring minimal setup. The
main objective of the project is to enable quick testing of desktop Linux
distributions where the virtual machines configuration and disk images can be
stored anywhere, such as external USB storage or your home directory. **Windows
and macOS guests are also supported.**

Quickemu will attempt to *"do the right thing"* rather than expose rich
configuration options. Quickemu is a wrapper for [QEMU](https://www.qemu.org/).
See the video where I explain some of my motivations for creating this script.

We have a Discord for this project: [![Discord](https://img.shields.io/discord/712850672223125565?color=0C306A&label=WimpysWorld%20Discord&logo=Discord&logoColor=ffffff&style=flat-square)](https://discord.gg/sNmz3uw)

[![Replace VirtualBox with Bash & QEMU](https://img.youtube.com/vi/AOTYWEgw0hI/0.jpg)](https://www.youtube.com/watch?v=AOTYWEgw0hI)

## Requirements

Essential requirements:

  * [QEMU](https://www.qemu.org/) 6.0.0 or newer
  * [Coreutils](https://www.gnu.org/software/coreutils/)
  * [jq](https://stedolan.github.io/jq/)
  * [procps](https://gitlab.com/procps-ng/procps)
  * [usbutils](https://github.com/gregkh/usbutils)
  * [Wget](https://www.gnu.org/software/wget/)
  * [xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr)
  * [zsync](http://zsync.moria.org.uk/)

Optional requirements:

  * `python3` to run [macrecovery.py](https://github.com/acidanthera/OpenCorePkg/tree/master/Utilities/macrecovery) to download macOS recovery images; provided by `python3-minimal` in Debian/Ubuntu
  * `rot13` to *"decrypt"* the macOS OSK key; provided by `bsdgames` in Debian/Ubuntu
  * `spicy` to connect to VMs via the SPICE protocol; provided by `spice-client-gtk` in Debian/Ubuntu

# Install Quickemu

## Ubuntu

Quickemu is available from a PPA for Ubuntu users. The Quickemu PPA also
includes a back port of QEMU 6.0.0 for 20.04 (Focal) and 21.04 (Hirsute).

```bash
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt install quickemu
```

## Other Linux

```bash
git clone https://github.com/wimpysworld/quickemu
cd quickemu
```

# Usage

## Ubuntu Guest

`quickget` will automatically download an Ubuntu release and also create the
virtual machine configuration.

```bash
quickget ubuntu focal
quickemu --vm ubuntu-focal.conf
```

  * Complete the installation as normal.
  * Post-install:
    * Install the SPICE agent (`spice-vdagent`) to enable copy/paste and USB redirection
      * `sudo apt install spice-vdagent`
    * Install the SPICE WebDAV agent (`spice-webdavd`) to enable file sharing.
      * `sudo apt install spice-webdavd`

### Ubuntu devel (daily-live) images

`quickget` can also download/refresh devel images via `zsync` for Ubuntu
developers and testers.

```bash
quickget ubuntu devel
quickemu --vm ubuntu-devel.conf
```

You can run `quickget ubuntu devel` to refresh your daily development image as
often as you like, it will even automatically switch to a new series.

### Ubuntu Flavours

All the official Ubuntu flavours are supported, just replace `ubuntu` with your
preferred flavour.

  * `kubuntu`
  * `lubuntu`
  * `ubuntu-budgie`
  * `ubuntu-kylin`
  * `ubuntu-mate`
  * `ubuntu-studio`
  * `xubuntu`

## Linux Guest

  * Download a .iso image of a Linux distribution
  * Create a VM configuration file; for example `debian-bullseye.conf`

```bash
guest_os="linux"
disk_img="${HOME}/Quickemu/debian-bullseye/disk.qcow2"
iso="${HOME}/Quickemu/debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

  * Use `quickemu` to start the virtual machine:

```bash
quickemu --vm debian-bullseye.conf
```

  * Complete the installation as normal.
  * Post-install:
    * Install the SPICE agent (`spice-vdagent`) to enable copy/paste and USB redirection
    * Install the SPICE WebDAV agent (`spice-webdavd`) to enable file sharing.

## macOS Guest

`quickget` automatically downloads a macOS recovery image and automatically
creates a virtual machine configuration.

```bash
quickget macos catalina
quickemu --vm macos-catalina.conf
```

macOS `mojave`, `catalina` and `big-sur` are supported.

  * Use cursor keys to select the Hard Disk icon
    * Click **Disk Utility** and **Continue**
    * Select `Apple Inc. VirtIO Block Media` from the list and click **Erase**.
    * Enter a `Name:` for the disk and click **Erase**.
    * Click **Done**.
    * Close Disk Utility
    * Click **Reinstall macOS** and **Continue**
  * Complete the installation as you normally would.

The default macOS configuration looks like this:

```bash
guest_os="macos"
disk_img="${HOME}/Quickemu/macos-big-sur/RecoveryImage.img"
iso="${HOME}/Quickemu/macos-big-sur/disk.qcow2"
```

  * The `guest_os="macos"` line instructs Quickemu to optimise for macOS.

### macOS compatibility

There are some considerations when running macOS via Quickemu.

  * `quickemu` will automatically download the required [OpenCore](https://github.com/acidanthera/OpenCorePkg)
    bootloader and OVMF firmware from [OSX-KVM](https://github.com/kholia/OSX-KVM).
  * Supported macOS releases:
    * Mojave
    * Catalina
    * Big Sur
  * Optimised by default
    * Host CPU vendor is detected and guest CPU configuration is optimised accordingly.
    * [VirtIO block device](https://www.kraxel.org/blog/2019/06/macos-qemu-guest/) is used for the system disk (*available since macOS Mojave*).
    * [VirtIO `usb-tablet`](http://philjordan.eu/osx-virt/) is used for the mouse (*available since macOS El Capitan*).
    * `vmxnet3` network device is used (*available since macOS El Capitan*).
  * USB host pass-through is limited to UHCI (USB 2.0)
  * Not supported on macOS:
    * Copy/paste between the guest and host via SPICE agent.
    * File sharing between the guest and host via SPICE webdavd.
    * USB passthrough via SPICE.

## Windows 10 Guest

`quickget` automatically downloads [Windows 10](https://www.microsoft.com/en-gb/software-download/windows10ISO),
the [VirtIO drivers for Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/)
and creates a virtual machine configuration.

```bash
quickget windows 10
quickemu --vm windows-10.conf
```

  * During the Windows 10 install you will be asked *"Where do you want to install Windows?"*
    * Click **Load driver** and **OK** the the dialogue box that pops up.
    * Select `VirtIO SCSI controller (E:\amd64\w10\viostor.inf)` from the list and click **Next**.
    * The disk will now be available for partitioning and formatting.
  * Complete the installation as you normally would.
  * Post-install:
    * Run the VirtIO installer from the CD-ROM: drive.
    * Install [spice-webdavd](https://www.spice-space.org/download/windows/spice-webdavd/)
    * Install [UsbDk](https://www.spice-space.org/download/windows/usbdk/)

### Regional versions

By default `quickget` will download the *"English International"* release, but
you can optionally specify one of the supported languages: For example:

```bash
quickget windows 10 "Chinese (Traditional)"
```

The default Windows 10 configuration looks like this:

```bash
guest_os="windows"
disk_img="${HOME}/Quickemu/windows-10/disk.qcow2"
iso="${HOME}/Quickemu/windows-10/Win10_21H1_English_x64.iso"
driver_iso="${HOME}/Quickemu/windows-10/virtio-win.iso"
```

  * The `guest_os="windows"` line instructs `quickemu` to optimise for Windows.
  * The `driver_iso=` line specifies the ISO image that provides VirtIO drivers.

# SPICE

The following features are only available while using the SPICE protocol:

  * Copy/paste between the guest and host *(not available for macOS guests)*
  * Host file sharing to the guest *(not available for macOS guests)*
  * USB device redirection *(untested on macOS)*

To use SPICE add `--display spice` to the Quickemu invocation, this requires that
the `spicy` client is installed, available from the `spice-client-gtk` package
in Debian/Ubuntu.

```bash
quickemu --vm ubuntu-focal.conf --display spice
```

# BIOS and EFI

Since Quickemu 2.1.0 `efi` is the default boot option. If you want to override
this behaviour then add the following line to you VM configuration to enable
legacy BIOS.

  * `boot="legacy"` - Enable Legacy BIOS boot

# Tuning CPU cores, RAM & disks

By default, Quickemu will calculate the number of CPUs cores and RAM to allocate
to a VM based on the specifications of your host computer. You can override this
default behaviour and tune the VM configuration to your liking.

Add additional lines to your virtual machine configuration:

  * `cpu_cores="4"` - Specify the number of CPU cores allocated to the VM
  * `ram="4G"` - Specify the amount of RAM to allocate to the VM
  * `disk="16G"` - Specify the size of the virtual disk allocated to the VM

# Network port forwarding

Add an additional line to your virtual machine configuration. For example:

  * `port_forwards=("8123:8123" "8888:80")`

In the example above:

  * Port 8123 on the host is forwarded to port 8123 on the guest.
  * Port 8888 on the host is forwarded to port 80 on the guest.

# USB redirection

Quickemu supports USB redirection via SPICE passthrough and host passthrough.

## SPICE redirection (recommended)

Using SPICE for USB passthrough is easiest as it doesn't require any elevated
permission, start Quickemu with `--display spice` and then select `Input` ->
`Select USB Device for redirection` from the menu to chose which device(s) you want
to attach to the guest.

## Host redirection

**USB host redirection is not recommended**, it is provided purely for backwards
compatibility to older versions of Quickemu. Using SPICE is preferred, see above.

Add an additional line to your virtual machine configuration. For example:

  * `usb_devices=("046d:082d" "046d:085e")`

In the example above:

  * The USB device with vendor_id 046d and product_id 082d will be exposed to the guest.
  * The USB device with vendor_id 046d and product_id 085e will be exposed to the guest.

If the USB devices are not writable, `quickemu` will display the appropriate
commands to modify the USB device(s) access permissions, like this:

```
 - USB:      Host pass-through requested:
              - Sennheiser Communications EPOS GTW 270 on bus 001 device 005 needs permission changes:
                sudo chown -v root:user /dev/bus/usb/001/005
                ERROR! USB permission changes are required 👆
```

# All the options

Here are the usage instructions:

```
Usage
  quickemu --vm ubuntu.conf

You can also pass optional parameters
  --delete                : Delete the disk image.
  --display               : Select display backend. 'sdl' (default), 'gtk' or 'spice'
  --shortcut              : Create a desktop shortcut
  --snapshot apply <tag>  : Apply/restore a snapshot.
  --snapshot create <tag> : Create a snapshot.
  --snapshot delete <tag> : Delete a snapshot.
  --snapshot info         : Show disk/snapshot info.
  --status-quo            : Do not commit any changes to disk/snapshot.
  --fullscreen            : Starts VM in full screen mode (Ctl+Alt+f to exit)"
  --screen <screen>       : Use specified screen to determine the window size.
```

## Desktop shortcuts

Desktop shortcuts can be created for a VM, the shortcuts are saved in `~/.local/share/applications`. Here is an example of how to create a shortcut.

```bash
quickemu --vm ubuntu-focal-desktop.conf --shortcut
```

## Screen and window size

<ins>Note about screen and window size</ins>

`qemu` will always default to the primary monitor to display the VM's window.

Without the `--screen` option, `quickemu` will look for the size of the smallest
monitor, and use a size that fits on said monitor.

The `--screen` option forces `quickemu` to use the size of the given monitor to
compute the size of the window. **It wont't use that monitor to display the VM's
window if it's not the primary monitor**. This is useful if the primary monitor
if not the smallest one, and if the VM's window doesn't need to be moved around.

The `--screen` option is also useful with the `--fullscreen` option, again
because `qemu` will always use the primary monitor. In order for the fullscreen
mode to work properly, the resolution of the VM's window must match the
resolution of the screen.

To know which screen to use, type:

```bash
xrandr --listmonitors | grep -v Monitors
```

The command will output something like this:

```
 0: +*HDMI-0 2560/597x1440/336+1920+0  HDMI-0
 1: +DVI-D-0 1920/527x1080/296+0+0  DVI-D-0
```

The first number is what needs to be passed to the `--screen` option.

For example:

```bash
quickemu --vm vm.conf --screen 0
```

The above uses the 2560x1440 screen to compute the size of the window, which
Quickemu sizes to 2048x1152. Without the `--screen` option, Quickemu would have
used the 1920x1080 monitor which results in a window size of 1664x936.

# TODO

  - [ ] Add 9p support
  - [ ] Add `spice-app` support via `virt-viewer`; *requires `virt-viewer` 8.0 or newer*
  - [ ] Add support for `ignore_msrs` for macOS. `echo "options kvm ignore_msrs=Y" >> /etc/modprobe.d/kvm.conf && update-initramfs -k all -u`
  - [ ] Include macOS compatible firmware
  - [ ] Add BSD support
  - [ ] Improve disk management
  - [ ] [Add Faux OEM](https://code.launchpad.net/~ubuntu-installer/ubiquity/+git/ubiquity/+merge/379899)

# References

Useful reference that assisted the development of Quickemu.

  * macOS
    * <https://www.nicksherlock.com/2020/06/installing-macos-big-sur-on-proxmox/>
    * <https://passthroughpo.st/mac-os-adds-early-support-for-virtio-qemu/>
    * <https://github.com/kholia/OSX-KVM>
    * <https://github.com/thenickdude/KVM-Opencore>
    * <https://github.com/acidanthera/OpenCorePkg/tree/master/Utilities/macrecovery>
    * <https://www.kraxel.org/blog/2017/09/running-macos-as-guest-in-kvm/>
    * <https://www.nicksherlock.com/2017/10/passthrough-of-advanced-cpu-features-for-macos-high-sierra-guests/>
    * <http://philjordan.eu/osx-virt/>
    * <https://github.com/Dids/clover-builder>
  * Windows
    * <https://www.heiko-sieger.info/running-windows-10-on-linux-using-kvm-with-vga-passthrough/>
    * <https://leduccc.medium.com/improving-the-performance-of-a-windows-10-guest-on-qemu-a5b3f54d9cf5>
    * <https://frontpagelinux.com/tutorials/how-to-use-linux-kvm-to-optimize-your-windows-10-virtual-machine/>
    * <https://github.com/pbatard/Fido>
  * 9p & virtiofs
    * <https://wiki.qemu.org/Documentation/9psetup>
    * <https://www.linux-kvm.org/page/9p_virtio>
    * <https://superuser.com/questions/628169/how-to-share-a-directory-with-the-host-without-networking-in-qemu>
    * <https://virtio-fs.gitlab.io/>
