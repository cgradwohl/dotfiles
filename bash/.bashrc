# dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# terminal prompt
eval "$(/opt/homebrew/bin/starship init bash)"export PYENV_ROOT="$HOME/.pyenv"

# pyenv (https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv)
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pyenv-virtualenv (https://github.com/pyenv/pyenv-virtualenv)
eval "$(pyenv virtualenv-init -)"

# alias
alias cgs="aws sso login --sso-session cgradwohl"
alias css="aws sso login --sso-session cloudspark"
alias dot="cd ~/CGradwohl/dotfiles"
alias gc="git commit -m"
alias gca="git commit -am"
alias goland="open -na 'GoLand.app'"
alias gp="git pull"
alias gpp="git push"
alias gs="git status"
alias idea="open -na 'IntelliJ IDEA Ultimate.app'"
alias k="kubectl"
alias nb="cd ~/CGradwohl/NoteBox"
alias pqs="aws sso login --sso-session playq"
alias pycharm="open -na 'PyCharm Professional Edition.app'"
alias tf="terraform"
alias tfdoc="terraform-docs markdown table --output-file README.md --output-mode inject"
alias tftest = "AWS_SDK_LOAD_CONFIG=1 TF_VAR_region=us-east-1 AWS_PROFILE=terratest go test -v -timeout 30m"

# init
fastfetch

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CGradwohl/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# not sure how this got here ?
export PATH="$PATH:$HOME/.local/bin"

