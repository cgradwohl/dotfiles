# bashrc
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# prompt
git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\] $ "

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
