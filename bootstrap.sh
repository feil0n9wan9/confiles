#!/bin/sh

# Copyright (c) 2016 Feilong Wang

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# The bootstrap script for setup a system fast and easily.

git clone https://github.com/feil0n9wan9/confiles.git ~/.confiles

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
    exit -1
fi

# Set up vim
ln -s ~/.confiles/vim/$HOST_OS/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Set up system successfully!"
