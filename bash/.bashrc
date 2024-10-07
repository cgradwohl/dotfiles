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
alias playqsession="aws sso login --sso-session playq"
alias cgradwohlsession="aws sso login --sso-session cgradwohl"
alias cloudsparksession="aws sso login --sso-session cloudspark"

alias gc="git commit -m"
alias gca="git commit -am"
alias goland="open -na 'GoLand.app'"
alias gp="git pull"
alias gpp="git push"
alias gs="git status"
alias idea="open -na 'IntelliJ IDEA Ultimate.app'"
alias pycharm="open -na 'PyCharm Professional Edition.app'"
alias tf="terraform"
alias tfdoc="terraform-docs markdown table --output-file README.md --output-mode inject"

# init
neofetch


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CGradwohl/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
