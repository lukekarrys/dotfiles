# lukekarrys/dotfiles

## Init

```sh
sh -c "$(curl -fsLS https://raw.githubusercontent.com/lukekarrys/dotfiles/main/init.sh)"
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

### Keeping Global Packages Synced

#### `npm`

```sh
# Install something
npmg install vlt
# Or check for updates
ncug
# Or update everyting
ncug -u
# Check if there are diffs between source and target
cz diff ~/.config/packages/npm/package.json
# Since the package.json is not a template, we can re-add
cz re-add ~/.config/packages/npm/package.json
```

### macOS Things That I'm Too Lazy to Learn How to Script

### Settings

- Turn off all notifications sounds and some off altogether
- Map Caps Lock to Escape in keyboard shortcuts
- Finder view everything as list
- Unlock with Apple Watch
- Turn on accounts in system settings so Raycast, Data can access calendars

### Configure Casks Installed Apps

- Login and sync VSCode
- Login and sync Raycast
- Bartender 5
- iStat Menus
- Choosy as the default browser
- Open Logi Options to install Bolt and restore from backup
- Open Things and sync from backup
- Open Data and sync calendars
