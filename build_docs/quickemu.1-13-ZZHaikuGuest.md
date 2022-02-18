
## Haiku Guests

`quickemu` supports [Haiku](https://www.haiku-os.org/).

```bash
quickget quickget haiku r1beta3-x86_64
quickemu --vm haiku-r1beta3-x86_64.conf
```

At the moment the only way to share files between host and a Haiku guest is by
using SSH (having a SSH server running on the host):

On guest:

```bash
scp example.txt user@host-local-ip:/home/user # sending a file from guest to host
scp user@host-local-ip:/home/user/example.txt . # receiving a file from host to guest
```

`quickget` cannot automatically download and create virtual machines for Haiku
nightly versions, but they work if the ISO and configuration are set up manually.
