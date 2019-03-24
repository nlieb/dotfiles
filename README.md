
### Config files (softlinked)

- `~/.config/gtk-3.0/gtk.css`
- `~/.emacs.el`

### Ubuntu 16.04 customization
Installed using `gnome-tweak-tool`. Each title is a Tweak Tool sidebar section:

#### Appearance
- Theme: `HighContrast`
- Icons: `Ubuntu-mono-light`
- Cursor: `DMZ-Black`


#### Typing
- Ctrl key position: Caps Lock as Ctrl

#### Fonts
- first istall Consolas, then tweak:
- Window Titles `Consolas Bold 12`
- Interface `Consolas Regular 12`
- Documents `Sans Regular 11`
- Monospace `Consolas Regular 13`

#### Disable annoying 1080ti LEDs
```
nvidia-settings --assign GPULogoBrightness=0
```

#### Disable NIC leds
https://pwmon.org/p/1900/quest-disable-lan-leds-intel-nuc/

Summary:

- Kernel Module Instructions: https://www.intel.com/content/www/us/en/support/articles/000005480/network-and-i-o/ethernet-products.html
- Download: https://downloadcenter.intel.com/download/15817

```
sudo modprobe -r e1000e
sudo modprobe e1000e
sudo ethtool -E enp0s31f6 magic 0x15b88086 offset 0x30 value 0xa5
sudo ethtool -E enp0s31f6 magic 0x15b88086 offset 0x31 value 0x14
```
