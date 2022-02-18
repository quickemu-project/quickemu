# Accessibility

Qemu provides support for using BrlAPI to display braille output on a real or fake device.


```bash
quickemu --vm ubuntu-impish.conf --accessibility braille --display sdl
```
or even

```bash
quickemu --vm ubuntu-impish.conf --acc brl --display sdl
```

