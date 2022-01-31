
## Windows 8.1, 10 & 11 Guests

`quickget` can automatically download Windows 8.1, [Windows 10](https://www.microsoft.com/en-gb/software-download/windows10ISO)
and [Windows 11](https://www.microsoft.com/en-gb/software-download/windows11)
along with the [VirtIO drivers for Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/)
and creates a virtual machine configuration.

```bash
quickget windows 11
quickemu --vm windows-11.conf
```

* Complete the installation as you normally would.
* All relevant drivers and services should be installed automatically.

### Regional versions

By default `quickget` will download the *"English International"* release, but
you can optionally specify one of the supported languages: For example:

```bash
quickget windows 11 "Chinese (Traditional)"
```

The default Windows 11 configuration looks like this:

```bash
guest_os="windows"
disk_img="windows-11/disk.qcow2"
iso="windows-11/Win11_EnglishInternational_x64.iso"
fixed_iso="windows-11/virtio-win.iso"
tpm="on"
```

* `guest_os="windows"` instructs `quickemu` to optimise for Windows.
* `fixed_iso=` specifies the ISO image that provides VirtIO drivers.
* `tpm="on"` instructs `quickemu` to create a software emulated TPM device using `swtpm`.
