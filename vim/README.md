# Vim Configuration File

The file contains vim configuration, vim plugin management and vim plugin configuration.


## Usage 

* Set up `~/.vimrc`. To try this configuration file, you can download the corresponding `vimrc` directly to avoid clone this repository. Assume currently on Ubuntu:
```bash
curl -o ~/.vimrc https://raw.githubusercontent.com/feil0n9wan9/confiles/master/vim/linux/vimrc
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
