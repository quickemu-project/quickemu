<h1 align="center">
  <img src=".github/logo.png" alt="Quickemu" />
  <br />
  Quickemu
</h1>

<p align="center"><b>Simple shell script to "manage" Qemu virtual machines.</b></p>
<div align="center"><img src=".github/screenshot.png" alt="Quickemu Screenshot" /></div>
<p align="center">Made with 💝 for <img src="https://raw.githubusercontent.com/anythingcodes/slack-emoji-for-techies/gh-pages/emoji/tux.png" align="top" width="24" /></p>

## Introduction

Quickemu is a very simple script to "manage" Qemu virtual machines. Each
virtual machine configuration is broadly the same requiring minimal setup. The
main objective of the project is to enable quick testing of desktop Linux
distributions where the virtual machines can be stored anywhere, such as
external USB storage.

Quickemu is opinionated and will attempt to *"do the right thing"* rather than
expose rich configuration options. Quickemu is a frontend to the fully
accelerated [qemu-virgil](https://snapcraft.io/qemu-virgil). See the video
where I explain some of my motivations for creating this script.

[![Replace VirtualBox with Bash & QEMU](https://img.youtube.com/vi/AOTYWEgw0hI/0.jpg)](https://www.youtube.com/watch?v=AOTYWEgw0hI)

## Installation

Clone this repository:

```
git clone https://github.com/wimpysworld/quickemu.git
```

Install the `qemu-virgil` snap. You can find details about how to install snapd
and `qemu-virgil`  on the [Snap Store page for qemu-virgil](https://snapcraft.io/qemu-virgil)

```bash
snap install qemu-virgil --edge
snap connect qemu-virgil:kvm
snap connect qemu-virgil:removable-media
```

## Usage

  * Download a .iso image of a Linux distribution
  * Create a VM configuration file; for example `ubuntu.conf`

```
iso="/media/$USER/Quickemu/ubuntu/focal-desktop-amd64.iso"
disk_img="/media/$USER/Quickemu/ubuntu/focal-desktop-amd64.qcow2"
disk=128G
```

  * Use `quickemu` to start the virtual machine:

```
./quickemu --vm ubuntu-focal-desktop.conf
```

Which will output something like this:

```
Starting /media/martin/Quickemu/ubuntu-focal-desktop.conf
 - QEMU:     /snap/bin/qemu-virgil v4.2.0
 - BIOS:     Legacy
 - Disk:     /media/martin/Quickemu/ubuntu/focal-desktop-amd64.qcow2 (64G)
 - ISO:      /media/martin/Quickemu/ubuntu/focal-desktop-amd64.iso
 - CPU:      4 Core(s)
 - RAM:      4G
 - GL:       on
 - Virgil3D: on
 - Output:   SDL
 - Display:  1664x936
 - smbd:     /home/martin will be exported to the guest via smb://10.0.2.4/qemu
 - ssh:      22221/tcp is connected. Login via 'ssh user@localhost -p 22221'
```

### Windows 10

You can use `quickemu` to run a Windows 10 virtual machine.

  * [Download Windows 10](https://www.microsoft.com/en-gb/software-download/windows10ISO)
  * [Download VirtIO drivers for Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-8/virtio-win.iso)
  * Create a VM configuration file; for example `windows10.conf`

```
iso="/media/$USER/Quickemu/windows10/Win10_1909_English_x64.iso"
driver_iso="/media/$USER/Quickemu/windows10/virtio-win-0.1.173.iso"
disk_img="/media/$USER/Quickemu/windows10/windows10.qcow2"
VIDEO_DRV="qxl"
```

  * Use `quickemu` to start the virtual machine:

```
./quickemu --vm windows10.conf
```

### All the options

Here are the full usage instructions:

```
Usage
  quickemu --vm ubuntu.conf

You can also pass optional parameters
  --delete                : Delete the disk image.
  --efi                   : Enable EFI BIOS.
  --snapshot apply <tag>  : Apply/restore a snapshot.
  --snapshot create <tag> : Create a snapshot.
  --snapshot delete <tag> : Delete a snapshot.
  --snapshot info         : Show disk/snapshot info.
  --status-quo            : Do not commit any changes to disk/snapshot.
```

## TODO

  - [x] Make display configuration more robust
  - [x] Improve stdout presentation
  - [x] Make disk image optionally size configurable
  - [x] Improve snapshot management
  - [ ] Create desktop launcher for a VM
  - [x] Fix Virgil 3D on EFI boot
  - [x] Get QEMU `-audiodev` working for audio input, something like:
