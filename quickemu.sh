#!/usr/bin/env bash

# Usage:
#  - sudo apt install qemu qemu-kvm libvirt-clients libvirt-daemon bridge-utils samba ovmf
#  - sudo apt install libvirt-bin # on 18.04
#  - sudo adduser ${SUDO_USER} kvm
#  - Download an ISO image
#  - Your home directory on the host will be available via samba on the guest VM via smb://10.0.2.4/qemu

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
xres="1440"
yres="900"
ver=$(qemu-system-x86_64 -version | head -n1 | cut -d' ' -f4 | cut -d'(' -f1)
if [ "${ver}" == "2.11.1" ]; then
  display="-display sdl"
  # Fix stuttering mouse pointer when SDL backend is used.
  export SDL_VIDEO_X11_DGAMOUSE=0
else
  display="-display gtk,grab-on-hover=on,zoom-to-fit=off"
fi

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

  # Boot the iso image
  qemu-${ENGINE} \
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
    -device virtio-vga,virgl=on,edid=on,xres=${xres},yres=${yres} \
    ${display} ${BIOS} \
    "$@"
}

function usage() {
  echo
  echo "Usage"
  echo "  ${LAUNCHER} --vm ubuntu.conf"
  echo
  echo "You can also pass optional parameters"
  echo "  --delete   : Delete the disk image."
  echo "  --restore  : Restore the snapshot."
  echo "  --snapshot : Create a disk snapshot."
  echo "  --virgil   : Use virgil, if available."
  exit 1
}

BIOS="-bios /usr/share/qemu/OVMF.fd"
DELETE=0
ENGINE="system-x86_64"
RESTORE=0
SAMBA=",smb=${HOME}"
SNAPSHOT=0
VM=""

while [ $# -gt 0 ]; do
  case "${1}" in
    -efi|--efi)
      BIOS="-bios /usr/share/qemu/OVMF.fd"
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
      BIOS=""
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
