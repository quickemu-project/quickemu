{
  lib,
  mkShell,
  pkgs,
  stdenv,
  OVMF ? null,
  OVMFFull ? null,
}:
mkShell {
  packages =
    with pkgs;
    (
      [
        cdrtools
        curl
        gawk
        gnugrep
        gnused
        jq
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
      ]
      ++ lib.optionals stdenv.isLinux [
        mesa-demos
        usbutils
        xdg-user-dirs
      ]
      ++ lib.optionals (OVMF != null && OVMFFull != null) [
        OVMF
        OVMFFull
      ]
    );

  inputsFrom = with pkgs; [
    git
  ];

  shellHook = ''
    echo "**********************************************************************"
    echo "* 'direnv reload' to update '.direnv/bin/quickemu' for testing  *"
    echo "**********************************************************************"
    sed \
      ${
        lib.optionalString (OVMF != null && OVMFFull != null) ''
          -e '/OVMF_CODE_4M.secboot.fd/s|ovmfs=(|ovmfs=("${OVMFFull.firmware}","${OVMFFull.variables}" |' \
          -e '/OVMF_CODE_4M.fd/s|ovmfs=(|ovmfs=("${OVMF.firmware}","${OVMF.variables}" |' \
        ''
      } \
      -e '/cp "''${VARS_IN}" "''${VARS_OUT}"/a chmod +w "''${VARS_OUT}"' \
      -e 's,\$(command -v smbd),${pkgs.samba}/bin/smbd,' \
      quickemu > $PWD/.direnv/bin/quickemu
    chmod +x $PWD/.direnv/bin/quickemu
  '';
}
