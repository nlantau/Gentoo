# nlantau, 2021-07-16

## After kernel is built:
```sh
emerge -aq @module-rebuild # For nvidia
```

## GRUB-settings:
```sh
in /etc/default/grub:
GRUB_DEFAULT="1>2" # Used when 2nd entry in /boot/grub/grub.cfg is what we want to be the default kernel
```

## Useful utilities
* lsmod                     # Show loaded modules
* lspci -k                  # Show loaded drivers
* dmesg | grep -i firmware  # Show loaded firmware
