[[ ! -d "$XDG_SCREENSHOTS_DIR" ]] && mkdir -p "$XDG_SCREENSHOTS_DIR"

if [[ -z $WAYLAND_DISPLAY ]] && [[ -n $XDG_VTNR ]] && [[ $XDG_VTNR -eq 1 ]] ; then
    exec sway --unsupported-gpu
fi
