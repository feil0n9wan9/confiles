#!/usr/bin/env bash

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

fcfs_latest_version() {
  echo "v0.1.0"
}

fcfs_source() {
  echo "https://github.com/feil0n9wan9/confiles.git"
}

fcfs_get_dotfiles() {
  echo ".bash_profile .gitconfig .dir_colors"
}

fcfs_get_os() {
  local FCFS_UNAME
  FCFS_UNAME="$(command uname -a)"
  local FCFS_OS
  case "$FCFS_UNAME" in
    Linux\ *) FCFS_OS=linux ;;
    Darwin\ *) FCFS_OS=darwin ;;
  esac
  echo "${FCFS_OS-}"
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
  command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout --quiet "$(fcfs_latest_version)"
  if [ ! -z "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/master)" ]; then
    if command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
      command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet -D master >/dev/null 2>&1
    else
      echo >&2 "Your version of git is out of date. Please update it!"
      command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch -D master >/dev/null 2>&1
    fi
  fi
  return
}

fcfs_do_install() {
  if fcfs_has "git"; then
    install_fcfs_from_git
  else
    echo >&2 "You need git to install fcfs"
    exit 1
  fi

  local FCFS_OS
  FCFS_OS=$(fcfs_get_os)
  if [ -z $FCFS_OS ]; then
    echo >&2 "Unable determine your OS type from uname: $UNAME"
    exit 2
  fi

  # Link dot files
  local FCFS_OPTIONS
  if [ ! -d "$INSTALL_DIR/.git" ]; then
    FCFS_OPTIONS=f
  fi  

  for f in $(fcfs_get_dotfiles)
  do
    echo "=> Create symbol link $HOME/$f to $FCFS_DIR/$f"
    command ln -s$FCFS_OPTIONS $FCFS_DIR/$f ~/$f > /dev/null 2>&1
  done

  # Setup vim 
  source $FCFS_DIR/vim/vim.sh

  # Setup brew if on MacOS X
  [ $FCFS_OS = darwin ] && source brew.sh

  fcfs_reset

  echo "=> Setup system successfully!"
}

#
# Unsets the various functions defined
# during the execution of the install script
#
fcfs_reset() {
  unset -f fcfs_has fcfs_install_dir fcfs_source install_fcfs_from_git \
    fcfs_get_dotfiles fcfs_get_os fcfs_do_install
}

[ "_$FCFS_ENV" = "_testing" ] || fcfs_do_install

} # this ensures the entire script is downloaded #
