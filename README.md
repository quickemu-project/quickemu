<h1 align="center">
  <img src=".github/logo.png" alt="Quickemu" />
  <br />
  Quickemu
</h1>

<p align="center"><b>Simple script to "manage" Qemu virtual machines.</b></p>
<div align="center"><img src=".github/screenshot.png" alt="Quickemu Screenshot" /></div>
<p align="center">Made with 💝 for <img src=".github/tux.png" align="top" width="18" /></p>

## Introduction

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
  * [procps](https://gitlab.com/procps-ng/procps)
  * [usbutils](https://github.com/gregkh/usbutils)
  * [Wget](https://www.gnu.org/software/wget/)
  * [xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr)

Optional requirements:

  * `rot13` to *"decrypt"* the macOS OSK key; found in the `bsdgames` package in Debian/Ubuntu
  * `spicy` to connect to VMs via the SPICE protocol; found in the `spice-client-gtk` package in Debian/Ubuntu

## Install Quickemu

### Ubuntu

Quickemu is available from a PPA for Ubuntu users. The Quickemu PPA also
includes a back port of QEMU 6.0.0 for 20.04 (Focal) and 21.04 (Hirsute).

```bash
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt install quickemu
```

## Usage

### Linux Guest

  * Download a .iso image of a Linux distribution
  * Create a VM configuration file; for example `ubuntu.conf`
    * The **default** `guest_os` is `linux`, so this is optional for Linux VM configs.
    * The `boot` option enables Legacy BIOS (`legacy`) or EFI (`efi`) booting. `legacy` is the default.

```bash
boot="legacy"
guest_os="linux"
iso="${HOME}/Quickemu/ubuntu/focal-desktop-amd64.iso"
disk_img="${HOME}/Quickemu/ubuntu/focal-desktop-amd64.qcow2"
```

  * Use `quickemu` to start the virtual machine:

```bash
quickemu --vm ubuntu-focal-desktop.conf
```

  * Complete the installation as normal.
  * Post-install:
    * Install the SPICE agent (`spice-vdagent`) to enable copy/paste and USB redirection
      * Debian/Ubuntu `sudo apt install spice-vdagent`
    * Install the SPICE WebDAV agent (`spice-webdavd`) to enable file sharing.
      * Debian/Ubuntu `sudo apt install spice-webdavd`

### Windows 10 Guest

You can use `quickemu` to run Windows 10 in a virtual machine.

  * [Download Windows 10](https://www.microsoft.com/en-gb/software-download/windows10ISO)
  * [Download VirtIO drivers for Windows](https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html#virtio-win-direct-downloads)
  * [Download `spice-webdavd` for Windows](https://www.spice-space.org/download/windows/spice-webdavd/)
    * Enables the Windows guest access to shared files on the host.
  * [Download UsbDk for Windows](https://www.spice-space.org/download/windows/usbdk/)
    * Enables the Windows guest access to redirected USB devices from the host.
  * Create a VM configuration file; for example `windows10.conf`
    * The `boot` option enables Legacy BIOS (`legacy`) or EFI (`efi`) booting. `legacy` is the default.
    * The `guest_os="windows"` line instructs `quickemu` to use optimise for Windows.

```bash
boot="legacy"
guest_os="windows"
iso="${HOME}/Quickemu/windows10/Win10_1909_English_x64.iso"
driver_iso="${HOME}/Quickemu/windows10/virtio-win-0.1.173.iso"
disk_img="${HOME}/Quickemu/windows10/windows10.qcow2"
```

  * Use `quickemu` to start the virtual machine:

```bash
quickemu --vm windows10.conf
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

### macOS Guest

There are some considerations when running macOS via Quickemu.

  * `quickemu` will automatically download the required [Clover EFI bootloader](https://sourceforge.net/projects/cloverefiboot/) and OVMF firmware from [the macOS-Simple-KVM project](https://github.com/foxlet/macOS-Simple-KVM).
  * **macOS 10.14.3 or newer is supported**:
    * [VirtIO block devices QEMU standard VGA are supported](https://www.kraxel.org/blog/2019/06/macos-qemu-guest/) since macOS 10.14.3 (Mohave).
    * [VirtIO `usb-tablet` devices are supported](http://philjordan.eu/osx-virt/) since macOS 10.11 (El Capitan).
    * [vmxnet3 network devices are supported](https://github.com/foxlet/macOS-Simple-KVM/blob/master/docs/guide-networking.md) since macOS 10.11 (El Capitan).
    * Running macOS on QEMU required the guest CPU is set to `Penryn`.
    *   This is a very old architecture, [so to unlock higher CPU performance; AVX, AES-NI, SSE et al are enabled](https://www.nicksherlock.com/2017/10/passthrough-of-advanced-cpu-features-for-macos-high-sierra-guests/).
  * UHCI USB (USB 2.0) is the fastest supported.
    * USB pass-through has not been tested.
  * Copy/paste between the guest and host is not supported in macOS.
  * File sharing is not supported on macOS.

You can use `quickemu` to run a macOS virtual machine.

  * Download macOS using `fetch-macos.py`

```bash
wget https://raw.githubusercontent.com/foxlet/macOS-Simple-KVM/master/tools/FetchMacOS/fetch-macos.py -O fetch-macos.py
python3 -m venv venv
. venv/bin/activate
python3 -m pip install requests click
python3 ./fetch-macos.py
qemu-img convert BaseSystem/BaseSystem.dmg -O raw BaseSystem.img
```

  * Create a VM configuration file; for example `macos.conf`
    * The `guest_os="macos"` line instructs `quickemu` to use optimise for macOS.
    * The `img=` sets the boot disk that you downloaded with `fetch-macos.py`

```bash
guest_os="macos"
img="${HOME}/Quickemu/macos/BaseSystem.img"
disk_img="${HOME}/Quickemu/macos/macos.qcow2"
```

  * Use `quickemu` to start the virtual machine:

```bash
quickemu --vm macos.conf
```

  * Boot from the BaseSystem (use cursor keys if the mouse doesn't work)
    * Click **Disk Utility** and **Continue**
    * Select `Apple Inc. VirtIO Block Media` that is ~138GB from the list and click **Erase**.
    * Enter a `Name:` for the disk and click **Erase**.
    * Click **Done**.
    * Close Disk Utility
    * Click **Reinstall macOS** and **Continue**
  * Complete the installation as you normally would.

## SPICE

The following features are only available while using the SPICE protocol:

  * Copy/paste between the guest and host *(not available for macOS guests)*
  * Host file sharing to the guest *(not available for macOS guests)*
  * USB device redirection *(untested on macOS)*

To use SPICE add `--display spice` to the Quickemu invocation, this requires that
the `spicy` client is installed, available from the `spice-client-gtk` package
in Debian/Ubuntu.

```bash
quickemu --vm ubuntu-focal-desktop.conf --display spice
```

## Tuning CPU cores, RAM & disks

By default, Quickemu will calculate the number of CPUs cores and RAM to allocate
to a VM based on the specifications of your host computer. You can override this
default behaviour and tune the VM configuration to your liking.

Add additional lines to your virtual machine configuration:

  * `cpu_cores="4"` - Specify the number of CPU cores allocated to the VM
  * `ram="4G"` - Specify the amount of RAM to allocate to the VM
  * `disk="16G"` - Specify the size of the virtual disk allocated to the VM

## Network port forwarding

Add an additional line to your virtual machine configuration. For example:

  * `port_forwards=("8123:8123" "8888:80")`

In the example above:

  * Port 8123 on the host is forwarded to port 8123 on the guest.
  * Port 8888 on the host is forwarded to port 80 on the guest.

## USB redirection

Quickemu support USB redirection via host passthrough and SPICE passthrough.

### SPICE redirection

Using SPICE for USB passthrough is easiest as it doesn't require any elevated
permission, start Quickemu with `--display spice` and then select `Input` ->
`Select USB Device for redirection` from the menu to chose which device(s) you want
to attach to the VM.

### Host redirection

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
                sudo chown -v root:martin /dev/bus/usb/001/005
                ERROR! USB permission changes are required 👆
```

## All the options

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

### Screen and window size

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

## TODO

  - [ ] `spice-app` support via `virt-viewer`.
  - [ ] Improve disk management.
  - [ ] [Add Faux OEM](https://code.launchpad.net/~ubuntu-installer/ubiquity/+git/ubiquity/+merge/379899).
