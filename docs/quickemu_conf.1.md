---
author: Martin Wimpress
date: November 26, 2023
footer: quickemu_conf
header: Quickemu Configuration Manual
section: 1
title: QUICKEMU_CONF
---

# NAME

quickemu_conf - Options and parameters in the quickemu \<vm\>.conf

# DESCRIPTION

**quickemu** will create and run highly optimised desktop virtual
machines for Linux, macOS and Windows. It uses sensible defaults, but
many configuration options can be overridden in the required
configuration file, which will as a minimum specify the path to the
installation ISO and QEMU disk for the installed VM

# OPTIONS

These are the options and defaults for the \<vm\>.conf file

``` bash
# Lowercase variables are used in the VM config file only
boot="efi"
cpu_cores=""
disk_img=""
disk_size=""
display=""
extra_args=""
fixed_iso=""
floppy=""
guest_os="linux"
img=""
iso=""
macaddr=""
macos_release=""
network=""
port_forwards=()
preallocation="off"
ram=""
secureboot="off"
tpm="off"
usb_devices=()
viewer="spicy"
ssh_port=""
spice_port=""
public_dir=""
monitor="socket"
monitor_telnet_port="4440"
monitor_telnet_host="localhost"
monitor_cmd=""
serial="socket"
serial_telnet_port="6660"
serial_telnet_host="localhost"
# options: ehci(USB2.0), xhci(USB3.0)
usb_controller="ehci"
# options: ps2, usb, virtio
keyboard="usb"
keyboard_layout="en-us"
# options: ps2, usb, tablet, virtio
mouse="tablet"
```

# EXAMPLES

``` bash
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

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

The default Windows 11 configuration looks like this:

``` bash
guest_os="windows"
disk_img="windows-11/disk.qcow2"
iso="windows-11/Win11_EnglishInternational_x64.iso"
fixed_iso="windows-11/virtio-win.iso"
tpm="on"
secureboot="on"
```

-   `guest_os="windows"` instructs `quickemu` to optimise for Windows.
-   `fixed_iso=` specifies the ISO image that provides VirtIO drivers.
-   `tpm="on"` instructs `quickemu` to create a software emulated TPM
    device using `swtpm`.

# BIOS and EFI

Since Quickemu 2.1.0 `efi` is the default boot option. If you want to
override this behaviour then add the following line to you VM
configuration to enable legacy BIOS.

-   `boot="legacy"` - Enable Legacy BIOS boot

# Tuning CPU cores, RAM & disks

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

## Disk preallocation

Preallocation mode (allowed values: `off` (default), `metadata`,
`falloc`, `full`). An image with preallocated metadata is initially
larger but can improve performance when the image needs to grow.

Specify what disk preallocation should be used, if any, when creating
the system disk image by adding a line like this to your VM
configuration.

-   `preallocation="metadata"`

## CD-ROM disks

If you want to expose an ISO image from the host to guest add the
following line to the VM configuration:

-   `fixed_iso="/path/to/image.iso"`

## Floppy disks

If you're like [Alan Pope](https://popey.com) you'll probably want to
mount a floppy disk image in the guest. To do so add the following line
to the VM configuration:

-   `floppy="/path/to/floppy.img"`

# File Sharing

All File Sharing options will only expose `~/Public` (or localised
variations) for the current user to the guest VMs.

## Samba 🐧 🍏 🪟

If `smbd` is available on the host, Quickemu will automatically enable
the built-in QEMU support for exposing a Samba share from the host to
the guest.

You can install the minimal Samba components on Ubuntu using:

``` bash
sudo apt install --no-install-recommends samba
```

If everything is set up correctly, the `smbd` address will be printed
when the virtual machine is started. For example:

     - smbd:     On guest: smb://10.0.2.4/qemu

If using a Windows guest, right-click on "This PC", click "Add a network
location", and paste this address, removing `smb:` and replacing forward
slashes with backslashes (in this example `\\10.0.2.4\qemu`).

## SPICE WebDAV 🐧 🪟

-   TBD

## VirtIO-9P 🐧 🍏

-   TBD

# Network port forwarding

Add an additional line to your virtual machine configuration. For
example:

-   `port_forwards=("8123:8123" "8888:80")`

In the example above:

-   Port 8123 on the host is forwarded to port 8123 on the guest.
-   Port 8888 on the host is forwarded to port 80 on the guest.

# Disable networking

To completely disable all network interfaces in a guest VM add this
additional line to your virtual machine configuration:

-   `network="none"`

# Restricted networking

You can isolate the guest from the host (and broader network) using the
restrict option, which will restrict networking to just the guest and
any virtual devices.

This can be used to prevent software running inside the guest from
phoning home while still providing a network inside the guest. Add this
additional line to your virtual machine configuration:

-   `network="restrict"`

# Bridged networking

Connect your virtual machine to a preconfigured network bridge. Add an
additional line to your virtual machine configuration:

-   `network="br0"`

If you want to have a persistent MAC address for your bridged network
interface in the guest VM you can add `macaddr` to the virtual machine
configuration. QEMU requires that the MAC address is in the range:
**52:54:00:AB:00:00 - 52:54:00:AB:FF:FF**

So you can generate your own MAC addresses with:

-   `macaddr="52:54:00:AB:51:AE"`

# USB redirection

Quickemu supports USB redirection via SPICE pass-through and host
pass-through.

## SPICE redirection (recommended)

Using SPICE for USB pass-through is easiest as it doesn't require any
elevated permission, start Quickemu with `--display spice` and then
select `Input` -\> `Select USB Device for redirection` from the menu to
choose which device(s) you want to attach to the guest.

## Host redirection **NOT Recommended**

**USB host redirection is not recommended**, it is provided purely for
backwards compatibility to older versions of Quickemu. Using SPICE is
preferred, see above.

Add an additional line to your virtual machine configuration. For
example:

-   `usb_devices=("046d:082d" "046d:085e")`

In the example above:

-   The USB device with vendor_id 046d and product_id 082d will be
    exposed to the guest.
-   The USB device with vendor_id 046d and product_id 085e will be
    exposed to the guest.

If the USB devices are not writable, `quickemu` will display the
appropriate commands to modify the USB device(s) access permissions,
like this:

     - USB:      Host pass-through requested:
                  - Sennheiser Communications EPOS GTW 270 on bus 001 device 005 needs permission changes:
                    sudo chown -v root:user /dev/bus/usb/001/005
                    ERROR! USB permission changes are required 👆

# TPM

Since Quickemu 2.2.0 a software emulated TPM device can be added to
guest virtual machines. Just add `tpm="on"` to your VM configuration.
`quickget` will automatically add this line to Windows 11 virtual
machines.

# AUTHORS

Written by Martin Wimpress.

# BUGS

Submit bug reports online at:
<https://github.com/quickemu-project/quickemu/issues>

# SEE ALSO

Full sources at: <https://github.com/quickemu-project/quickemu>

quickget(1), quickemu(1), quickgui(1)
