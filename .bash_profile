# Override the defautl PS1 variable
PS1="\u@\h:\w\$ "

if [ -f "$HOME/.extra" ]; then
  . "$HOME/.extra"
fi

if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# Add current directory last
PATH=.:$PATH

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# Set the number of open files to be 1024
ulimit -S -n 1024

export USE_CCACHE=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
