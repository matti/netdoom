#!/usr/bin/env bash
set -euo pipefail

_term() {
  >&2 echo "TERM"
  set +e
    kill -9 $doom_pid
  set -e
  exit 0
}
trap "_term" TERM

_err() {
  >&2 echo "err: $*"
  exit 1
}

case $1 in
  server)
    /usr/games/chocolate-doom -dedicated &
    doom_pid=$!
  ;;
  client)
    Xvfb :0 -screen 0 320x240x24 &
    x11vnc -display :0 -passwd secret -forever -shared -nocursor &

    /usr/games/chocolate-doom \
      -nomouse -nosound \
      -window -geometry 320x240 \
      -config /app/chocolate-doom.cfg \
      -connect server -nodes 3 &
    doom_pid=$!
  ;;
esac

wait $doom_pid
