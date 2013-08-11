#!/bin/zsh

ZSH_FOLDER="$HOME/Dropbox/synced-config/oh-my-zsh"
ZSH_FILES=( aliases zprofile zshrc )

for file in $ZSH_FILES
do
	ln -s $ZSH_FOLDER/$file $HOME/.$file
done

ln -s $ZSH_FOLDER/theme $HOME/.oh-my-zsh/themes/leimi.zsh-theme



CONFIG_ROOT="$HOME/Dropbox/synced-config"
CONFIG_FOLDERS=( sublime-text-2 sublime-text-3 openbox lxsession pytyle cairo-dock )
for folder in $CONFIG_FOLDERS
do
	ln -s $CONFIG_ROOT/$folder $HOME/.config/$folder
done