#!/usr/bin/env bash
cd ~/.oh-my-zsh
git pull --autostash
cd ~

git clone git@github.com:sagischwarz/neovimconfig.git ~/.neovimconfig
ln -s ~/.neovimconfig/config/nvim ~/.config

sudo pacman -S neovim python-neovim xclip xsel ruby clang python-language-server python-rope python-pyflakes yapf python-pydocstyle python-pystemmer

sudo npm install -g neovim
gem install neovim

nvim +PlugInstall +UpdateRemotePlugins +qa
