{
  mkShell,
  cdrtools,
  curl,
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
}:
mkShell {
  strictDeps = true;

  nativeBuildInputs = [
    cdrtools
    curl
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
  ];

  buildInputs = [];
}
