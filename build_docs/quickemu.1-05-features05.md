
* Full SPICE support including host/guest clipboard sharing
* VirtIO-webdavd file sharing for Linux and Windows guests
* VirtIO-9p file sharing for Linux and macOS guests
* [QEMU Guest Agent support](https://wiki.qemu.org/Features/GuestAgent); provides access to a system-level agent via standard QMP commands
* Samba file sharing for Linux, macOS and Windows guests (*if `smbd` is installed on the host*)
* VirGL acceleration
* USB device pass-through
* Smartcard pass-through
* Automatic SSH port forwarding to guests
* Network port forwarding
* Full duplex audio
* EFI (with or without SecureBoot) and Legacy BIOS boot
* Graphical user interfaces available

Quickemu is a wrapper for the excellent [QEMU](https://www.qemu.org/) that
attempts to automatically *"do the right thing"*, rather than expose exhaustive
configuration options.

We have a Discord for this project: [![Discord](https://img.shields.io/discord/712850672223125565?color=0C306A&label=WimpysWorld%20Discord&logo=Discord&logoColor=ffffff&style=flat-square)](https://discord.gg/sNmz3uw)

See this (old) video where I explain some of my motivations for creating Quickemu.

[![Replace VirtualBox with Bash & QEMU](https://img.youtube.com/vi/AOTYWEgw0hI/0.jpg)](https://www.youtube.com/watch?v=AOTYWEgw0hI)
