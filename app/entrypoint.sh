#!/usr/bin/env bash
set -euo pipefail

_term() {
  >&2 echo "TERM"
  exit 0
}
trap "_term" TERM

_err() {
  >&2 echo "err: $*"
  exit 1
}

Xvfb :0 -screen 0 320x240x24 &
x11vnc -display :0 -passwd secret -forever &

/usr/games/chocolate-doom $@ &
doom_pid=$!

echo "started: $@"
wait $doom_pid
