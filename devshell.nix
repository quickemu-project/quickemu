{
  mkShell,
  cdrtools,
  curl,
  gawk,
  git,
  glxinfo
  gnugrep,
  gnused,
  jq,
  ncurses,
  nixpkgs-fmt,
  pciutils,
  procps,
  python3,
  qemu,
  socat,
  spice-gtk,
  swtpm,
  unzip,
  usbutils,
  util-linux,
  xdg-user-dirs,
  xrandr,
  zsync,
  OVMF,
  OVMFFull,
}:
mkShell {
  strictDeps = true;

  nativeBuildInputs = [
    cdrtools
    curl
    gawk
    git
    glxinfo
    gnugrep
    gnused
    jq
    ncurses
    nixpkgs-fmt
    procps
    pciutils
    python3
    qemu
    socat
    spice-gtk
    swtpm
    unzip
    usbutils
    util-linux
    xdg-user-dirs
    xrandr
    zsync
    OVMF
    OVMFFull
  ];

  buildInputs = [];
}
