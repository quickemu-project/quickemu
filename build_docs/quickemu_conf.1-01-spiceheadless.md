# SPICE

The following features are available while using the SPICE protocol:

  * Copy/paste between the guest and host
  * Host file sharing to the guest
  * USB device redirection

To use SPICE add `--display spice` to the Quickemu invocation, this requires that
the `spicy` client is installed, available from the `spice-client-gtk` package
in Debian/Ubuntu.

```bash
quickemu --vm ubuntu-focal.conf --display spice
```

## Headless

To start a VM with SPICE enabled, but no display attached use `--display none`.
This requires that the `spicy` client is installed, available from the
`spice-client-gtk` package in Debian/Ubuntu to connect to the running VM

```bash
quickemu --vm ubuntu-focal.conf --display none
```

You can also use the `.ports` file in the VM directory to lookup what SSH and
SPICE ports the VM is connected to.

```bash
cat ubuntu-focal/ubuntu-focal.ports
```
