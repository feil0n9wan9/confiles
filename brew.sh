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

# Whether Homebrew installed
fcfs_has "brew" || return 0

echo "=> Updating Homebrew..."
printf "\r=> "
command brew update

echo "=> Upgrading installed Homebrew formulas"
printf "\r=> "
command brew upgrade --all

BREW_INSTALL_LIST="bash bash-completion cmake coreutils cscope ctags curl \
dos2unix emacs enca gawk gdb gdbm git gmp gnupg go gradle groovy lua macvim \
maven mpfr node openssl p7zip sqlite valgrind wget xz"

echo "=> Installing new Homebrew formulas"
printf "\r=> "
for FORMULA in $BREW_INSTALL_LIST
do
    command brew install $FORMULA
done

unset BREW_INSTALL_LIST

echo "=> Homebrew and formulas have been setup"

} # this ensures the entire script is downloaded #
