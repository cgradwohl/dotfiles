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
alias idea='open -na "IntelliJ IDEA Ultimate.app"'
alias pycharm='open -na "PyCharm Professional Edition.app"'

# node
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
