<h1 align="center">
  <img src=".github/logo.png" alt="Quickemu" />
  <br />
  Quickemu
</h1>

<p align="center"><b>Simple shell script to manage Qemu virtual machines.</b></p>
<div align="center"><img src=".github/screenshot.png" alt="Quickemu Screenshot" /></div>
<p align="center">Made with 💝 for <img src="https://raw.githubusercontent.com/anythingcodes/slack-emoji-for-techies/gh-pages/emoji/tux.png" align="top" width="24" /></p>

## Introduction

Quickemu is a very simple script to "manage" Qemu virtual machines. Each virtual
machine configuration is broadly the same requiring minimal setup. The main
objective of the project is to enable quick testing of desktop Linux
distributions where the virtual machines can be stored anywhere, such as external
USB storage.

See the video where I explain my motivations for creating this script.

[![Replace VirtualBox with Bash & QEMU](https://img.youtube.com/vi/AOTYWEgw0hI/0.jpg)](https://www.youtube.com/watch?v=AOTYWEgw0hI)

## Installation

### Ubuntu 19.10 or newer

Install qemu

```bash
sudo apt install qemu qemu-kvm libvirt-clients libvirt-daemon bridge-utils ovmf
sudo adduser ${SUDO_USER} kvm
```

Install `samba` *(optional)* if you want to share home directories with guest virtual machines

```bash
sudo apt install samba
```

Install the `qemu-virgil` snap *(optional)*

```bash
snap install qemu-virgil
snap connect qemu-virgil:kvm
snap connect qemu-virgil:removable-media
```

## Usage

  * Download a .iso image of a Linux distribution
  * Create a VM configuration file; for example `ubuntu.conf`

```
iso="/media/$USER/Quickemu/ubuntu/focal-desktop-amd64.iso"
disk_img="/media/$USER/Quickemu/ubuntu/focal-desktop-amd64.qcow2
disk=128G
```

  * Use `quickemu.sh` to start the virtual machine:

```
./quickemu --vm ubuntu-focal-desktop.conf
```

Here are the full usage instructions:

```
Usage
  quickemu --vm ubuntu.conf

You can also pass optional parameters
  --delete   : Delete the disk image.
  --efi      : Enable EFI BIOS (experimental).
  --restore  : Restore the snapshot.
  --snapshot : Create a disk snapshot.
  --virgil   : Use virgil, if available.
  --ssh      : Enable SSH to the machine (disabled by default).
  --ssh-port : Local port to forward to the machine (default 2222).
```

### SSH Access

SSH access to the QEMU virtual machine can be enabled by using the `--ssh` flag. This will portforward `TCP2222` on the host machine to `TCP22` on the QEMU guest machine. 

This does not install or start an SSH server within the guest itself, so you may need to enable this on a per-guest basis. For Ubuntu guests, you can enable this by installing `openssh-server`.

If the default port overlaps with another service on your host, you can override this with `--ssh-port $PORT`. This will still forward to port `TCP22` on the guest machine.

Example of usage: -

```
$ ./quickemu.sh --vm mate.conf --ssh --ssh-port 1111
Starting mate.conf
 - BIOS:     Legacy
 - Disk:     /home/$USER/Applications/quickemu/ubuntu-mate/focal-desktop-amd64.qcow2
 - Size:     20G
 - ISO:      /home/$USER/Applications/quickemu/ubuntu-mate/focal-desktop-amd64.iso
 - CPU:      2 Core(s)
 - RAM:      2G
 - UI:       sdl
 - GL:       on
 - smbd:     /home/stuh84 will be exported to the guest via smb://10.0.2.4/qemu

$ ssh quickemu@localhost -p 1111
quickemu@localhost's password: 
Welcome to Ubuntu Focal Fossa (development branch) (GNU/Linux 5.4.0-18-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

quickemu@ubuntu-mate:~$
```

## TODO

  - [x] Make display configuration more robust
  - [x] Improve stdout presentation
  - [x] Make disk image optionally size configurable
  - [ ] Improve snapshot management
