
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
  * `disk_size="16G"` - Specify the size of the virtual disk allocated to the VM

## Disk preallocation

Preallocation mode (allowed values: `off` (default), `metadata`, `falloc`, `full`).
An image with preallocated metadata is initially larger but can improve performance
when the image needs to grow.

Specify what disk preallocation should be used, if any, when creating the system
disk image by adding a line like this to your VM configuration.

  * `preallocation="metadata"`

## CD-ROM disks

If you want to expose an ISO image from the host to guest add the following line
to the VM configuration:

   * `fixed_iso="/path/to/image.iso"`

## Floppy disks

If you're like [Alan Pope](https://popey.com) you'll probably want to mount a
floppy disk image in the guest. To do so add the following line to the VM
configuration:

  * `floppy="/path/to/floppy.img"`

# File Sharing

All File Sharing options will only expose `~/Public` (or localised variations)
for the current user to the guest VMs.

## Samba 🐧 🍏 🪟

If `smbd` is available on the host, Quickemu will automatically enable the
built-in QEMU support for exposing a Samba share from the host to the guest.

You can install the minimal Samba components on Ubuntu using:

```bash
sudo apt install --no-install-recommends samba
```
## SPICE WebDAV 🐧 🪟

  * TBD

## VirtIO-9P 🐧 🍏

  * TBD

# Network port forwarding

Add an additional line to your virtual machine configuration. For example:

  * `port_forwards=("8123:8123" "8888:80")`

In the example above:

  * Port 8123 on the host is forwarded to port 8123 on the guest.
  * Port 8888 on the host is forwarded to port 80 on the guest.

# Bridged networking

Connect your virtual machine to a preconfigured network bridge.
Add an additional line to your virtual machine configuration

  * `bridge="br0"`

# USB redirection

Quickemu supports USB redirection via SPICE pass-through and host pass-through.

## SPICE redirection (recommended)

Using SPICE for USB pass-through is easiest as it doesn't require any elevated
permission, start Quickemu with `--display spice` and then select `Input` ->
`Select USB Device for redirection` from the menu to choose which device(s) you want
to attach to the guest.

## Host redirection **NOT Recommended**

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

# TPM

Since Quickemu 2.2.0 a software emulated TPM device can be added to guest
virtual machines. Just add `tpm="on"` to your VM configuration. `quickget` will
automatically add this line to Windows 11 virtual machines.
