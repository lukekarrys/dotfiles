#!/bin/sh

case "$(uname -s)" in
Darwin)
    # Install Homebrew if it's not installed
    if ! type brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv bash)"' >> "${HOME}/.bash_profile"
        eval "$(/opt/homebrew/bin/brew shellenv bash)"
    fi

    # Install 1Password if it's not installed
    if ! type op &> /dev/null; then
        echo "Installing 1Password..."
        brew install --cask --adopt 1password
        brew install --cask --adopt 1password-cli
        echo "Opening 1Password. Please log into your account and enable CLI integration."
        open "/Applications/1Password.app"
        echo "Press Enter to continue."
        read
    fi
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
