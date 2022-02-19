
Or you can download a Linux image and manually create a VM configuration.

* Download a .iso image of a Linux distribution
* Create a VM configuration file; for example `debian-bullseye.conf`

```bash
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

If you already have a collection of ISOs downloaded you can have `quickget` find and copy your existing file into the VM directory.

```text
--isodir                : base path beneath which to find local ISO copy
                                       if a matching file is found it will be copied to the VM directory
--localiso              : optional local ISO filename - defaults to target filename
```

`quickget` will then continue to `wget` or `zsync` using that file as a prior copy.  If the target file exists in the VM directory `quickget` will raise an error if you run it with `--isodir`

* Use `quickemu` to start the virtual machine:

```bash
quickemu --vm debian-bullseye.conf
```

* Complete the installation as normal.
* Post-install:
  * Install the SPICE agent (`spice-vdagent`) to enable copy/paste and USB redirection.
  * Install the SPICE WebDAV agent (`spice-webdavd`) to enable file sharing.
