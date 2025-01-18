#!/bin/sh

case "$(uname -s)" in
Darwin)
  if [ "$(/usr/bin/uname -m)" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
  else
    HOMEBREW_PREFIX="/usr/local"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
  fi

  if ! type brew &> /dev/null; then
    # only install homebrew if repository directory does not exist
    if [ ! -d "$HOMEBREW_REPOSITORY" ]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # If brew is not in the path yet then eval the shellenv for the rest of this pre script
    # This will not affect any other chezmoi scripts
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv bash)"
    # The only bin installed from homebrew that chezmoi needs is 1Password so if its not in the
    # path yet, we will need to symlink it later.
    NEEDS_OP_SYMLINK="1"
  fi

  if ! type op &> /dev/null; then
    brew install --cask --adopt 1password
    brew install --cask --adopt 1password-cli
    echo "Opening 1Password. Please log into your account and enable CLI integration."
    open "/Applications/1Password.app"
    echo "Press Enter to continue."
    read
  fi

  # symlink the brew installed op to /usr/local/bin so chezmoi can find it by default
  if [ -n "$NEEDS_OP_SYMLINK" ]; then
    sudo mkdir -p /usr/local/bin
    OP="/usr/local/bin/op"
    if [ ! -f "$OP" ]; then
      sudo ln -s "$HOMEBREW_PREFIX/bin/op" "$OP"
    fi
  fi
  ;;
*)
  echo "unsupported OS"
  exit 1
  ;;
esac
