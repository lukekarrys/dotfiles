#!/bin/sh

case "$(uname -s)" in
Darwin)
  if ! type brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi

  eval "$($HOMEBREW_PREFIX/bin/brew shellenv bash)"

  # Env vars that need to be set before chezmoi is run because they are
  # used by tools that get installed by brew bundle. Without these then
  # other dirs or config files will be created in the wrong place.
  export XDG_CONFIG_HOME="/Users/lukekarrys/.config"
  export XDG_CACHE_HOME="/Users/lukekarrys/.cache"
  export XDG_DATA_HOME="/Users/lukekarrys/.local/data"
  export XDG_STATE_HOME="/Users/lukekarrys/.local/state"
  export NPM_CONFIG_CACHE="/Users/lukekarrys/.cache/npm"
  export NPM_CONFIG_USERCONFIG="/Users/lukekarrys/.cache/npmrc"
  export CARGO_HOME="/Users/lukekarrys/.local/data/cargo"
  export RUSTUP_HOME="/Users/lukekarrys/.local/data/rustup"

  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply --purge-binary --verbose --force # TODO: add lukekarrys/dotfiles back after done local testing
  ;;
*)
  echo "unsupported OS"
  exit 1
  ;;
esac
