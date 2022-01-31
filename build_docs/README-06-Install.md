
# Install Quickemu

## Ubuntu

Quickemu is available from a PPA for Ubuntu users. The Quickemu PPA also
includes a back port of QEMU 6.0.0 for 20.04 (Focal) and 21.04 (Hirsute). To
install Quickemu and all the dependencies run the following in a terminal:

```bash
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt update
sudo apt install quickemu
```

## Other Linux

```bash
git clone --depth=1 https://github.com/wimpysworld/quickemu
cd quickemu
```

Now install all the **Requirements** documented above.
