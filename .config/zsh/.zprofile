id=$(id -u)

doas mkdir -p "${XDG_RUNTIME_DIR}"
doas chown $id:$id "${XDG_RUNTIME_DIR}"

if [ -z "${DISPLAY}" ] && [ $(tty) = /dev/tty1 ]; then
  exec dbus-run-session startx
fi
