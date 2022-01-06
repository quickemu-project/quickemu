
Or you can download a Linux image and manually create a VM configuration.

* Download a .iso image of a Linux distribution
* Create a VM configuration file; for example `debian-bullseye.conf`

```bash
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```

* Use `quickemu` to start the virtual machine:

```bash
quickemu --vm debian-bullseye.conf
```

* Complete the installation as normal.
* Post-install:
  * Install the SPICE agent (`spice-vdagent`) to enable copy/paste and USB redirection.
  * Install the SPICE WebDAV agent (`spice-webdavd`) to enable file sharing.
