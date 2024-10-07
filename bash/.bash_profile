# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# bash completions
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
complete -o default -F __start_kubectl k

# pyenv (https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CGradwohl/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
