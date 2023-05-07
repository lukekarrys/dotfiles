# lukekarrys/dotfiles

## Prerequisites

- [`brew`](https://brew.sh)
    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

- 1Password
    - `brew install --cask 1password`
    - `brew install 1password-cli`
    - Login to 1Password.app and connect it to the CLI in "Developer" settings
    - Confirm with `op whoami`

- [`chezmoi`](https://www.chezmoi.io/install/#one-line-package-install)
    ```
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply lukekarrys
    ```

- Change default shell to Homebrew's `zsh`
    ```sh
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
    ```

## macOS Defaults

### 2023-05-07

Some notes from last time I did this:

- Some things are now in [this `onchange` script](run_onchange_after_macos_defaults.sh.tmpl)
- Turn off all notifications sounds and some off altogether
- Map Caps Lock to Escape in keyboard shortcuts

