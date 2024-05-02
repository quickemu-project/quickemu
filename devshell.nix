{
  mkShell,
  cdrtools,
  curl,
  lsb-release,
  ncurses,
  git,
  gnugrep,
  gnused,
  jq,
  nixpkgs-fmt,
  procps,
  python3,
  qemu,
  socat,
  swtpm,
  unzip,
  usbutils,
  util-linux,
  wget,
  xdg-user-dirs,
  xrandr,
  zsync,
}:
mkShell {
  strictDeps = true;

  nativeBuildInputs = [
    cdrtools
    curl
    lsb-release
    git
    gnugrep
    gnused
    jq
    nixpkgs-fmt
    procps
    python3
    qemu
    socat
    swtpm
    unzip
    usbutils
    util-linux
    wget
    xdg-user-dirs
    xrandr
    zsync
  ];

  buildInputs = [];
}
