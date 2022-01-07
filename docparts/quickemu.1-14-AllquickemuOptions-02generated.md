
Usage
  quickemu --vm ubuntu.conf

You can also pass optional parameters
  --delete-disk           : Delete the disk image and EFI variables
  --delete-vm             : Delete the entire VM and it's configuration
  --display               : Select display backend. 'sdl' (default), 'gtk', 'none', or 'spice'
  --fullscreen            : Starts VM in full screen mode (Ctl+Alt+f to exit)
  --ignore-msrs-always    : Configure KVM to always ignore unhandled machine-specific registers
  --screen <screen>       : Use specified screen to determine the window size.
  --shortcut              : Create a desktop shortcut
  --snapshot apply <tag>  : Apply/restore a snapshot.
  --snapshot create <tag> : Create a snapshot.
  --snapshot delete <tag> : Delete a snapshot.
  --snapshot info         : Show disk/snapshot info.
  --status-quo            : Do not commit any changes to disk/snapshot.
  --version               : Print version
