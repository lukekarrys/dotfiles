#!/bin/sh

case "$(uname -s)" in
Darwin)
    # Install Homebrew if it's not installed and then exit with instructions
    # to add brew to the PATH and run the script again.
    if ! type brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew has been installed. Please add it to your PATH and run the script again."
        exit 1
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
