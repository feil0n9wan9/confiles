PS1="\u@\h:\w\$ "

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/Workspace/go
export GOBIN=$GOPATH/bin

export GROOVY_HOME=/usr/local/opt/groovy/libexec

PATH=$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools:$HOME/Library/Android/ndk:$PATH

if [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if brew list | grep coreutils > /dev/null; then
  PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  alias ls='ls -F --show-control-chars --color=auto'
  eval `gdircolors -b $HOME/.dir_colors`
fi

PATH=$GOBIN:$PATH

if [ -d $HOME/bin ]; then
  PATH=$HOME/bin:$PATH
fi

PATH=.:$PATH

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# mount the android file image
function mountcases() { hdiutil attach $HOME/Documents/cases.dmg.sparseimage -mountpoint $HOME/Development/cases;  }

# unmount the android file image
function umountcases() { hdiutil detach $HOME/Development/cases;  }

# set the number of open files to be 1024
ulimit -S -n 1024

# for compile
export USE_CCACHE=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
