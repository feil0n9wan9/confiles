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
# The script should be sourced in $FCFSROOT/install.sh
# As it using a few of functions defined in install.sh
#


{ # this ensures the entire script is downloaded #

fcfs_has "vim" || return 0
fcfs_has "git" || return 0

vim_vundle_install_dir() {
  echo "$HOME/.vim/bundle/Vundle.vim"
}

vim_install_vundle_from_git() {
  local VUNDLE_INSTALL_DIR
  VUNDLE_INSTALL_DIR="$(vim_vundle_install_dir)"

  if [ -d "$VUNDLE_INSTALL_DIR/.git" ]; then
    echo "=> Vundle is already installed in $VUNDLE_INSTALL_DIR, trying to update using git"
    printf "\r=> "
    command git --git-dir="$VUNDLE_INSTALL_DIR/.git" --work-tree="$VUNDLE_INSTALL_DIR" fetch 2> /dev/null || {
      echo >&2 "Failed to update Vundle, run 'git fetch' in $VUNDLE_INSTALL_DIR yourself."
      exit 1
    }
  else
    # Cloning to $VUNDLE_INSTALL_DIR
    echo "=> Downloading Vundle from git to '$VUNDLE_INSTALL_DIR'"
    printf "\r=> "
    mkdir -p "$VUNDLE_INSTALL_DIR"
    command git clone  https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_INSTALL_DIR" || {
      echo >&2 "Failed to clone Vundle repo. Please report this!"
      exit 1
    }
  fi
  return
}

vim_link_vimrc() {
  local INSTALL_DIR
  INSTALL_DIR=$(fcfs_install_dir)

  # FIXME Allow user to agree or not
  echo "=> fcfs will create vim symbolic link in your HOME to override the old one"
  printf "\r=> "

  command ln -sf "$INSTALL_DIR/vim/.vimrc" $HOME/.vimrc 2> /dev/null
}

vim_do_install() {

  vim_link_vimrc

  vim_install_vundle_from_git

  # FIXME Maybe update
  echo "=> Installing vim plugins..."
  printf "\r=> "
  command vim +PluginInstall +qall > /dev/null 2>&1

  vim_reset

  echo "vim has been setup"
}

vim_reset() {
  unset -f vim_vundle_install_dir vim_install_vundle_from_git vim_link_vimrc \
    vim_do_install vim_reset
}

vim_do_install

} # this ensures the entire script is downloaded #
