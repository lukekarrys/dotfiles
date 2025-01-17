#!/bin/sh

case "$(uname -s)" in
Darwin)
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
