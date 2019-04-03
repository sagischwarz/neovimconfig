#!/usr/bin/env bash
cd ~/.oh-my-zsh
git pull --autostash
cd ~

git clone git@github.com:jefuba/neovimconfig.git ~/.neovimconfig
ln -s ~/.neovimconfig/local/share/nvim ~/.local/share/nvim
ln -s ~/.neovimconfig/config/nvim ~/.config/nvim

sudo pacman -S neovim python-neovim xclip xsel ruby clang python-language-server python-rope python-pyflakes yapf python-pydocstyle python-pystemmer

sudo npm install -g neovim
gem install neovim

nvim +PlugInstall +UpdateRemotePlugins +qa
