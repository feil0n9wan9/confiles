#!/usr/bin/env bash
#
# Copyright (c) 2016 Feilong Wang
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#
# The install script to setup a new system fast and easily.
#

{ # this ensures the entire script is downloaded #

fcfs_has() {
  type "$1" > /dev/null 2>&1
}

fcfs_install_dir() {
  echo ${FCFS_DIR:-"$HOME/.fcfs"}
}

fcfs_source() {
  echo "https://github.com/feil0n9wan9/confiles.git"
}

install_fcfs_from_git() {
  local INSTALL_DIR
  INSTALL_DIR="$(fcfs_install_dir)"

  if [ -d "$INSTALL_DIR/.git" ]; then
    echo "=> fcfs is already installed in $INSTALL_DIR, trying to update using git"
    printf "\r=> "
    command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch 2> /dev/null || {
      echo >&2 "Failed to update fcfs, run 'git fetch' in $INSTALL_DIR yourself."
      exit 1
    }
  else
    # Cloning to $INSTALL_DIR
    echo "=> Downloading fcfs from git to '$INSTALL_DIR'"
    printf "\r=> "
    mkdir -p "$INSTALL_DIR"
    command git clone  "$(fcfs_source)" "$INSTALL_DIR" || {
      echo >&2 "Failed to clone fcfs repo. Please report this!"
      exit 1
    }
  fi
  command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout --quiet master
}

install_fcfs_from_git

export HOST_OS=
UNAME=$(uname)
if [ "$UNAME" = "Linux" ]; then
    HOST_OS=linux
fi
if [ "$UNAME" = "Darwin" ]; then
    HOST_OS=darwin
fi

if [ -z $HOST_OS ]; then
    echo "Unable determine your system information from uname: $UNAME"
    command exit 1
fi

# Link dot files
for f in ".bash_profile .gitconfig .dir_colors"
do
    ln -s $FCFS_DIR/$f ~/$f
done

# Setup vim at last as it's most at risk.
source $FCFS_DIR/vim/install.sh || { 
    echo "Setup vim failed!" 
    exit 1
}

# Setup brew if on MacOS X
[ $HOST_OS = darwin ] && source brew.sh

echo "Setup system successfully!"
} # this ensures the entire script is downloaded #
