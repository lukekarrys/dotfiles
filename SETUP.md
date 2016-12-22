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
- Keyboard
  - `defaults write NSGlobalDomain KeyRepeat -int 1 && defaults write NSGlobalDomain InitialKeyRepeat -int 10`
- Trackpad
  - Tap to click
- App Store
  - Turn off auto updates
- Internet account
  - Turn on contacts and calendars
- Make animations happen faster
  - Dock `defaults write com.apple.Dock autohide-delay -float 0; killall Dock`
  - Mission Control `defaults write com.apple.dock expose-animation-duration -float 0.1`
- Other system stuff not in prefs
  - No iCloud saving `defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false`
  - Translucent hidden apps `defaults write com.apple.dock showhidden -bool true`

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

### App Store Apps

TODO: `mas-cli` and add to `.Brewfile`

**lukekarrys@gmail.com**
- Xcode
- Apple apps
- Duplicate Photos Finder
- Day One
- Slack
- Daisy Disk
- Divvy
- Letterpress
- Due

**andyet**
- Fantastical
- Hyperdock
- Monodraw
- iA Writer

### Brew

- Install homebrew [Docs](http://brew.sh/)
- `brew tap Homebrew/bundle` [Docs](https://github.com/Homebrew/homebrew-bundle)
- `brew bundle ~/.Brewfile`

### Fluid Apps

- GitHub Fluid
- Trello Fluid

### For All Apps

- Open each one and like do stuff with it?


## Dev

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
  - Open `Sublime Text 3`
  - Setup `packagecontrol` [Docs](https://packagecontrol.io/installation)
  - `cat installed-packages/sublime.txt | sed "s/[\",]//g" | sed "s/^ *//g" | sed '1d' | sed '$d' | tr '\n' ',' | pbcopy`
  - `Cmd + Shift + P > Advanced Install` and paste

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
  - `mkdir -p ~/.ssh/keys`
  - Create files in `~/.ssh/keys` for stuff in `~/.ssh/config`
  - `touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys` and copy keys there
  - Secure `/etc/ssh/sshd_config` [Docs](http://serverfault.com/questions/85992/how-do-i-setup-sshd-on-mac-os-x-to-only-allow-key-based-authentication)
