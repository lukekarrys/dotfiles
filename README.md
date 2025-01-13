# lukekarrys/dotfiles

## Prerequisites

- Install 1Password
- [`chezmoi`](https://www.chezmoi.io/install/#one-line-package-install)
    ```
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply lukekarrys
    ```

## Notes

### Check if entries are in $HOME that should be managed or moved

```sh
# This should return nothing. If it does list entries, they should either
# be added to .chezmoiignore, managed with chezmoi, or moved somewhere else.
chezmoi unmanaged

# This can be used to help see if any of the entries in $HOME can be moved
# somwhere else by setting a environ or the tool handles it natively
xdg-ninja --skip-unsupported 
```

## macOS Defaults

### 2023-05-07

Some notes from last time I did this:

- Some things are now in [this `onchange` script](run_onchange_after_macos_defaults.sh.tmpl)
- Turn off all notifications sounds and some off altogether
- Map Caps Lock to Escape in keyboard shortcuts
- Finder view everything as list
- Unlock with Apple Watch
- Open Logi Options to install Bolt and restore from backup
- Turn on accounts in system settings so Raycast, etc can access calendars
