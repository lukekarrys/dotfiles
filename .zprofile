export NVM_DIR="${HOME}/.nvm"

# Hardcode nvm version since I usually one use main version to speed up
# new shells while still getting node and npm modules in the path
# THIS NEEDS TO BE CHANGED WHENEVER the main nvm version is updated
export DEFAULT_NVM_VERSION="v6.9.5"
. "$NVM_DIR/nvm.sh" --no-use
export PATH="${PATH}:${NVM_DIR}/versions/node/${DEFAULT_NVM_VERSION}/bin"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
