export NVM_DIR="/Users/lukekarrys/.nvm"
function loadnvm() { . "$NVM_DIR/nvm.sh"; }

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  # If there is a package json or nvmrc and nvm hasnt been loaded yet, then load it
  if [[ -a "package.json" || -a ".nvmrc" ]]; then
    if ! type "nvm" > /dev/null; then
      loadnvm
    fi
  fi

  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif type "nvm" > /dev/null; then
    if [[ $(nvm version) != $(nvm version default)  ]]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
