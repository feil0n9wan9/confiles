# Vim Configuration File

The file contains vim configuration, vim plugin management and vim plugin configuration, etc.


## Usage

1. Set up `~/.vimrc`:
To try this configuration file, you could clone this project and link your `~/.vimrc` to corresponding vimrc in this project, such as on Ubuntu user home directory:
```bash
mkdir github
git clone https://github.com/feil0n9wan9/confiles.git github/confiles
ln -s confiles/vim/linux/vimrc .vimrc
```
2. Set up [Vundle](https://github.com/VundleVim/Vundle.vim):
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
3. Install plugins:
```bash
vim +PluginInstall +qall
```

4. Enjoy it:)
