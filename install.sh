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
  echo "v0.2.1"
}

fcfs_source() {
  echo "https://github.com/feil0n9wan9/confiles.git"
}

fcfs_get_os() {
  local HOST_UNAME
  HOST_UNAME="$(command uname -a)"
  local HOST_OS
  case "$HOST_UNAME" in
    Linux\ *) HOST_OS=linux ;;
    Darwin\ *) HOST_OS=darwin ;;
  esac
  echo "${HOST_OS-}"
}

#
# Return the dotfiles to apply based on the HOST_OS.
#
fcfs_get_dotfiles() {
  echo ".bash_profile .gitconfig .dir_colors"
}

fcfs_link_dotfiles() {
  local INSTALL_DIR
  INSTALL_DIR=$(fcfs_install_dir)

  # FIXME Allow user to agree or not
  echo "=> fcfs will create symbolic links in your HOME to override the olds"
  printf "\r=> "

  for f in $(fcfs_get_dotfiles)
  do
    command ln -sf "$INSTALL_DIR/$f" $HOME/$f 2> /dev/null
  done
}

install_fcfs_from_git() {
  local INSTALL_DIR
  INSTALL_DIR="$(fcfs_install_dir)"

  if [ -d "$INSTALL_DIR/.git" ]; then
    echo "=> fcfs is already installed in $INSTALL_DIR, trying to update using git"
    printf "\r=> "
    command git --git-dir="$INSTALL_DIR/.git" --work-tree="$INSTALL_DIR" fetch 2> /dev/null || {
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
  command git --git-dir="$INSTALL_DIR/.git" --work-tree="$INSTALL_DIR" checkout --quiet "$(fcfs_latest_version)"
  if [ ! -z "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/master)" ]; then
    if command git --git-dir="$INSTALL_DIR/.git" --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
      command git --git-dir="$INSTALL_DIR/.git" --work-tree="$INSTALL_DIR" branch --quiet -D master >/dev/null 2>&1
    else
      echo >&2 "Your version of git is out of date. Please update it!"
      command git --git-dir="$INSTALL_DIR/.git" --work-tree="$INSTALL_DIR" branch -D master >/dev/null 2>&1
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

  local HOST_OS
  HOST_OS=$(fcfs_get_os)

  local INSTALL_DIR
  INSTALL_DIR=$(fcfs_install_dir)

  fcfs_link_dotfiles

  # Setup vim 
  source "$INSTALL_DIR/vim/vim.sh"

  # Setup brew if on MacOS X
  [ $HOST_OS = darwin ] && source "$INSTALL_DIR/brew.sh"

  fcfs_reset

  echo "=> fcfs has been setup, close and reopen your terminal to start using new configurations."
}

#
# Unsets the various functions defined
# during the execution of the install script
#
fcfs_reset() {
  unset -f fcfs_has fcfs_install_dir fcfs_source install_fcfs_from_git \
    fcfs_get_dotfiles fcfs_link_dotfies fcfs_get_os fcfs_do_install \
    fcfs_latest_version fcfs_reset
}

[ "_$FCFS_ENV" = "_testing" ] || fcfs_do_install

} # this ensures the entire script is downloaded #
