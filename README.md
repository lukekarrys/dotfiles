# lukekarrys/dotfiles

## Prerequisites

- [`brew`](https://brew.sh)
    - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- 1Password
    - `brew install --cask 1password`
    - `brew install 1password-cli`
    - Login to 1Password.app and connect it to the CLI in "Developer" settings
    - Confirm with `op whoami`
- [`chezmoi`](https://www.chezmoi.io/install/#one-line-package-install)
    - `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply lukekarrys`
