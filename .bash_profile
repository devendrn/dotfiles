# .bash_profile

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    export GTK_THEME=Adwaita:dark
    exec sway
fi
