#!/bin/sh

lock="  Lock"
logout="  Logout"
suspend="  Suspend"
reboot="  Reboot"
shutdown="  Shutdown"

menu() {
  fuzzel --dmenu --anchor top-right --x-margin 260 --y-margin 4 --lines 4 --width 11 --hide-prompt --horizontal-pad 35 --vertical-pad 20"$@"
}

confirm() {
  answer=$(printf 'No\nYes\n' | menu --lines 2 --prompt "$1? ")
  [ "$answer" = "Yes" ]
}

choice=$(printf '%s\n' "$logout" "$suspend" "$reboot" "$shutdown" | menu)

case "$choice" in
"$logout") confirm "Logout" && swaymsg exit ;;
"$suspend") loginctl suspend ;;
"$reboot") confirm "Reboot" && loginctl reboot ;;
"$shutdown") confirm "Shutdown" && loginctl poweroff ;;
esac
