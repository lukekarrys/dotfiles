# Computer Setup Notes 2016-12-20

## Copy Files

- Copy `~/Dropbox`
- Copy `~/projects`
- Copy `~/Music`
- Point Dropdox at `~/Dropbox`
- Open iTunes and point at `~/Dropbox/iTunes\ Media`
- Open Photos and point at `~/Dropbox/Pictures/Photos\ Library.photoslibrary/`

## System Prefs

- Sharing
  - Enable File Sharing and Remote Login
- iCloud
  - Keep notes, find my mac, iCloud drive (not documents/data)
- Screen Saver
  - 20min
  - Hot Corners (Mission Control, Desktop, Screen Saver, -)
- Security
  - require password immediately
  - add lock screen email/phone
- Trackpad
  - Tap to click
- App Store
  - Turn off auto updates
- Internet accounts
  - Turn on contacts and calendars

```sh
# Super fast keyboard
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# Faster Dock and mission control animations
defaults write com.apple.Dock autohide-delay -float 0
defaults write -g QLPanelAnimationDuration -float 0.1

# Dont save to icloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Translucent dock hidden apps
defaults write com.apple.dock showhidden -bool true

# Expand dialogs for save and print
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# No shadow
defaults write com.apple.screencapture disable-shadow -bool true

# Restart
killall Finder
killall Dock
killall SystemUIServer

# TODO: save dialog no animation
```

## Finder

- Sidebar
  - Remove tags
  - Remove most other stuff
  - Disable all "All Files" views
- Dock
  - Auto hide
  - Add spacers + apps
- View Options
  - Always list

## Apps

### Brew

- Install homebrew [Docs](http://brew.sh/)
- `brew tap Homebrew/bundle` [Docs](https://github.com/Homebrew/homebrew-bundle)
- `brew bundle ~/.Brewfile`

### Other App Store Accounts

```sh
mas signout
mas signin andyet@me.com
mas install 975937182 # Fantastical 2
mas install 449830122 # HyperDock
mas install 775737590 # iA Writer
mas install 920404675 # Monodraw
```

### Natifier Apps

```
make-electron-app GitHub https://github.com
make-electron-app ROMWOD https://romwod.com/dashboard
make-electron-app Trello https://trello.com
```

### For All Apps

- Open each one and like do stuff with it?
- TODO: `mackup`

## Dev Env

- Install `xcode cli` [Docs](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/xcode-select.1.html)

```sh
xcode-select --install
```

- Change shell to homebrew's `zsh` [Docs](http://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/)

```sh
which zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

- Install `oh-my-zsh` [Docs](https://github.com/robbyrussell/oh-my-zsh#via-curl)

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

- Install `nvm` [Docs](https://github.com/creationix/nvm#install-script) and global `node` modules

```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
nvm install 6
npm install -g `cat installed-packages/npm.txt | tr '\n' ' '`
```

- Setup `sublime`

  - Download and install Ubuntu Mono font [Docs](http://font.ubuntu.com/) (double click to install)
  - Open `Sublime Text 3`
  - Link sublime text to dropbox`./.dotfile-bin/subl-link`
  - Restart sublime
  - Setup `packagecontrol` [Docs](https://packagecontrol.io/installation)

- Install `dotfiles` [Docs](https://github.com/lukekarrys/dotfiles)

```sh
cd ~/Desktop
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```

- Install `powerline` fonts [Docs](https://github.com/powerline/fonts#installation)

```sh
cd ~/projects/lukekarrys/dotfiles
./bootstrap
```

- Setup `iterm`

  - Open iTerm 2
  - Set to read preferences from `~/Dropbox/Apps/iTerm`

- Setup `ssh`

```sh
mkdir -p ~/.ssh/keys
# Create each of these keys
cat ~/.ssh/config | grep IdentityFile | awk '{print $2}' | xargs -n1 basename | uniq
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys # Add public keys for here
```

- Secure `/etc/ssh/sshd_config` [Docs](http://serverfault.com/questions/85992/how-do-i-setup-sshd-on-mac-os-x-to-only-allow-key-based-authentication)
