#!/bin/sh

case "$(uname -s)" in
Darwin)
  OP="/usr/local/bin/op"
  if [ -L "$OP" ]; then
    sudo rm "$OP"
  fi
  ;;
*)
  echo "unsupported OS"
  exit 1
  ;;
esac
