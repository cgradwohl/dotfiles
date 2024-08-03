# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv (https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi