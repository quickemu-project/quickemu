#!/usr/bin/env bash

LAUNCHER=$(basename $0 .sh)
allcores=$(nproc --all)
if [ ${allcores} -ge 8 ]; then
  cores="4"
elif [ ${allcores} -ge 4 ]; then
  cores="2"
else
  cores="1"
fi

allram=$(free --mega -h | grep Mem | cut -d':' -f2 | cut -d'G' -f1 | sed 's/ //g')
if [ ${allram} -ge 64 ]; then
  ram="4G"
elif [ ${allram} -ge 16 ]; then
  ram="3G"
else
  ram="2G"
fi

disk="64G"

function vm_delete() {
  if [ -f "${disk_img}" ]; then
    rm "${disk_img}"
    echo "Deleted ${disk_img}"
  fi
  exit 0
}

function vm_restore() {
  if [ -f "${disk_img_snapshot}" ]; then
    mv "${disk_img_snapshot}" "${disk_img}"
  fi
  echo "Restored ${disk_img_snapshot}"
  exit 0
}

function vm_snapshot() {
  if [ -f "${disk_img_snapshot}" ]; then
    mv "${disk_img_snapshot}" "${disk_img_snapshot}.old"
  fi
  qemu-img create -b "${disk_img}" -f qcow2 "${disk_img_snapshot}"
  if [ $? -eq 0 ]; then
    echo "Created ${disk_img_snapshot}"
  else
    echo "Failed to create ${disk_img_snapshot}"
  fi
  exit 0
}

function vm_boot() {
  if [ ! -f "${disk_img}" ]; then
    # If there is no disk image, create a new image.
    qemu-img create -f qcow2 "${disk_img}" "${disk}"
  else
    # If there is a disk image, do not boot from the iso
    iso=""
  fi

  # Determine what display to use
  ver=$(qemu-${ENGINE} -version | head -n1 | cut -d' ' -f4 | cut -d'(' -f1)
  if [ "${ENGINE}" == "virgil" ]; then
    display="-display sdl,gl=on"
  elif [ "${ver}" == "2.11.1" ]; then
    display="-display sdl"
    # Fix stuttering mouse pointer when SDL backend is used.
    export SDL_VIDEO_X11_DGAMOUSE=0
  else
    display="-display gtk,grab-on-hover=on"
  fi

  # Determine the most suitable 16:9 resolution of for VM based
  # on the lowest resolution connected monitor.
  LOWEST_WIDTH=$(xrandr --listmonitors | grep -v Monitors | cut -d' ' -f4 | cut -d'/' -f1 | sort | head -n1)
  if [ ${LOWEST_WIDTH} -ge 3840 ]; then
    xres=3200
    yres=1800
  elif [ ${LOWEST_WIDTH} -ge 2560 ]; then
    xres=2048
    yres=1152
  elif [ ${LOWEST_WIDTH} -ge 1920 ]; then
    xres=1664
    yres=936
  elif [ ${LOWEST_WIDTH} -ge 1280 ]; then
    xres=1152
    yres=648
  else
    xres=800
    yres=600
  fi

  if [ ${ENABLE_EFI} -eq 1 ]; then
    if [ "${ENGINE}" == "virgil" ]; then
      BIOS="-bios /snap/qemu-virgil/current/usr/share/qemu/OVMF.fd"
    else
      BIOS="-bios /usr/share/qemu/OVMF.fd"
    fi
    echo "${BIOS}"
  fi

  # If smbd is available, export $HOME to the guest via samba
  if [ "${ENGINE}" == "virgil" ] && [ -e /snap/qemu-virgil/current/usr/sbin/smbd ]; then
      SAMBA=",smb=${HOME}"
  elif [ "${ENGINE}" == "system-x86_64" ] && [ -e /usr/sbin/smbd ]; then
      SAMBA=",smb=${HOME}"
  else
      SAMBA=""
  fi

  if [ -n "${SAMBA}" ]; then
    echo "NOTE! ${HOME} will be available on the guest via smb://10.0.2.4/qemu"
  else
    echo "NOTE! %{HOME} will not be available in the guest. 'smbd' not found."
  fi

  # Boot the iso image
  qemu-${ENGINE} ${BIOS} \
    -cdrom "${iso}" \
    -drive "file=${disk_img},format=qcow2,if=virtio,aio=native,cache.direct=on" \
    -enable-kvm \
    -machine q35,accel=kvm \
    -cpu host,kvm=on \
    -m ${ram} \
    -smp ${cores} \
    -net nic,model=virtio \
    -net user"${SAMBA}" \
    -rtc base=localtime,clock=host \
    -soundhw hda \
    -usb -device usb-kbd -device usb-tablet \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 \
    -device qemu-xhci \
    -device virtio-vga,virgl=on,xres=${xres},yres=${yres} \
    ${display} \
    "$@"
}

function usage() {
  echo
  echo "Usage"
  echo "  ${LAUNCHER} --vm ubuntu.conf"
  echo
  echo "You can also pass optional parameters"
  echo "  --delete   : Delete the disk image."
  echo "  --efi      : Enable EFI BIOS (experimental)."
  echo "  --legacy   : Enable legacy BIOS (default)."
  echo "  --restore  : Restore the snapshot."
  echo "  --snapshot : Create a disk snapshot."
  echo "  --virgil   : Use virgil, if available."
  exit 1
}

BIOS=""
DELETE=0
ENABLE_EFI=0
ENGINE="system-x86_64"
RESTORE=0
SNAPSHOT=0
VM=""

while [ $# -gt 0 ]; do
  case "${1}" in
    -efi|--efi)
      ENABLE_EFI=1
      shift;;
    -delete|--delete)
      DELETE=1
      shift;;
    -legacy|--legacy)
      BIOS=""
      shift;;
    -restore|--restore)
      RESTORE=1
      shift;;
    -snapshot|--snapshot)
      SNAPSHOT=1
      shift;;
    -virgil|--virgil)
      ENGINE="virgil"
      SAMBA=""
      shift;;
    -vm|--vm)
      VM="$2"
      shift
      shift;;
    -h|--h|-help|--help)
      usage;;
    *)
      echo "ERROR! \"${1}\" is not a supported parameter."
      usage;;
  esac
done

if [ -z "${VM}" ] || [ ! -e "${VM}" ]; then
  echo "ERROR! VM not found."
  exit 1
else
  source "${VM}"
  if [ -n "${disk_img}" ]; then
    disk_img_snapshot="${disk_img}.snapshot"
    echo "${disk_img}"
    echo "${disk_img_snapshot}"
  else
    echo "ERROR! No disk_img defined."
    exit 1
  fi
fi

if [ ${DELETE} -eq 1 ]; then
  vm_delete
fi

if [ ${RESTORE} -eq 1 ]; then
  vm_restore
fi

if [ ${SNAPSHOT} -eq 1 ]; then
  vm_snapshot
fi

vm_boot
