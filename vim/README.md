# Vim Configuration File

The file contains vim configuration, vim plugin management and vim plugin configuration, etc.

I am running on Ubuntu, but it will likely work on Mac OS X as well.

## Usage 

* Set up `~/.vimrc`. To try this configuration file, you can clone the repository and link your `~/.vimrc` to corresponding vimrc in the repository. Assume currently in user home directory on Ubuntu:
```bash
mkdir github
git clone https://github.com/feil0n9wan9/confiles.git github/confiles
ln -s github/confiles/vim/linux/vimrc .vimrc
```
* Set up [Vundle](https://github.com/VundleVim/Vundle.vim):
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
* Install plugins:
```bash
vim +PluginInstall +qall
```

* Enjoy it:)
