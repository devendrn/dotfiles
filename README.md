# My dotfiles

## WM Setup

- Window Manager: [Sway](https://swaywm.org/)  
- Status bar: [Waybar](https://github.com/Alexays/Waybar)  
- Terminal: [Foot](https://codeberg.org/dnkl/foot)  
- Application launcher: [Fuzzel](https://codeberg.org/dnkl/fuzzel)  
- Notification daemon: [Mako](https://github.com/emersion/mako)  
- Text Editor: [Neovim](https://neovim.io/)  
- File manager: [PCManFM](https://github.com/lxde/pcmanfm)  
- Image Viewer: [qimv](https://github.com/easymodo/qimgv)  
- Browser: [Firefox](https://www.firefox.com)  
- Screenshot Utility: [grim](https://gitlab.freedesktop.org/emersion/grim), [slurp](https://github.com/emersion/slurp)  

## Tracking

https://wiki.archlinux.org/title/Dotfiles

**Replicate on new machine:**  
```sh
git clone --bare git@github.com:devendrn/dotfiles.git $HOME/.dotfiles
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## Assets

- **Wallpapers:** Put inside `~/Wallpapers/`
- **Notification daemon sound:**  `~/.config/sway/assets/notify.mp3`

