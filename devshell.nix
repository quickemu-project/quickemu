{
  mkShell,
  cdrtools,
  curl,
  git,
  gnugrep,
  gnused,
  jq,
  lsb-release,
  ncurses,
  nixpkgs-fmt,
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
    gnugrep
    gnused
    jq
    lsb-release
    ncurses
    nixpkgs-fmt
    procps
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
