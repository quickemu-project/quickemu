{ lib,
  mkShell,
  pkgs,
  stdenv,
}:
mkShell {
  packages = with pkgs; ([
    cdrtools
    curl
    gawk
    gnugrep
    gnused
    jq
    ncurses
    pciutils
    procps
    python3
    qemu_full
    samba
    socat
    spice-gtk
    swtpm
    unzip
    util-linux
    xorg.xrandr
    zsync
    OVMF
    OVMFFull
  ] ++ lib.optionals stdenv.isLinux [
    glxinfo
    usbutils
    xdg-user-dirs
  ]);

  inputsFrom = with pkgs; [
    git
  ];

  shellHook = ''
    echo "**********************************************************************"
    echo "* 'direnv reload' to update '.direnv/bin/quickemu' for testing  *"
    echo "**********************************************************************"
    sed \
      -e '/OVMF_CODE_4M.secboot.fd/s|ovmfs=(|ovmfs=("${pkgs.OVMFFull.firmware}","${pkgs.OVMFFull.variables}" |' \
      -e '/OVMF_CODE_4M.fd/s|ovmfs=(|ovmfs=("${pkgs.OVMF.firmware}","${pkgs.OVMF.variables}" |' \
      -e '/cp "''${VARS_IN}" "''${VARS_OUT}"/a chmod +w "''${VARS_OUT}"' \
      -e 's,\$(command -v smbd),${pkgs.samba}/bin/smbd,' \
      quickemu > $PWD/.direnv/bin/quickemu
    chmod +x $PWD/.direnv/bin/quickemu
  '';
}
