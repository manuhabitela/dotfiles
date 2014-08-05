#!/bin/zsh

DOTFILES="/home/manu/Dropbox/dotfiles"

FILES=( bin .aliases .xmodmaprc .zshrc )

for FILE in $FILES
do
	echo "ln -s $DOTFILES/$FILE $HOME/$FILE"
	ln -s $DOTFILES/$FILE $HOME/$FILE
done

CONFIGS=( cairo-dock lxsession openbox pytyle sublime-text-2 sublime-text-3 xfce4 )
for CONFIG in $CONFIGS
do
	echo "ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG"
	ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG
done

echo "ln -s $DOTFILES/.themes/ACIDBoxCustom $HOME/.themes/ACIDBoxCustom"
ln -s $DOTFILES/.themes/ACIDBoxCustom $HOME/.themes/ACIDBoxCustom

echo "ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix"
ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix

echo "ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh"
ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme