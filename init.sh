#!/bin/sh

set -x

case "$(uname -s)" in
Darwin)
  if [ -n "${HOMEBREW_PREFIX}" ] && [ -x "$HOMEBREW_PREFIX/bin/brew" ]; then
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv bash)"
  fi

  # XDG
  export XDG_CONFIG_HOME="/Users/lukekarrys/.config"
  export XDG_CACHE_HOME="/Users/lukekarrys/.cache"
  export XDG_DATA_HOME="/Users/lukekarrys/.local/data"
  export XDG_STATE_HOME="/Users/lukekarrys/.local/state"

  # Move things reported by xdg-ninja
  export NODE_REPL_HISTORY="/Users/lukekarrys/.local/state/node_repl_history"
  export TS_NODE_HISTORY="/Users/lukekarrys/.local/state/ts_node_repl_history"
  export PKG_CACHE_PATH="/Users/lukekarrys/.cache/pkg-cache"
  export WGETRC="/Users/lukekarrys/.cache/wgetrc"
  export NPM_CONFIG_CACHE="/Users/lukekarrys/.cache/npm"
  export NPM_CONFIG_USERCONFIG="/Users/lukekarrys/.cache/npmrc"
  export CARGO_HOME="/Users/lukekarrys/.local/data/cargo"
  export RUSTUP_HOME="/Users/lukekarrys/.local/data/rustup"

  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply --purge-binary lukekarrys
  ;;
*)
  echo "unsupported OS"
  exit 1
  ;;
esac
