#!/bin/zsh

DOTFILES="/home/manu/Dropbox/dotfiles"

FILES=( bin .aliases .gtkrc-2.0 .xmodmaprc .zshrc )

for FILE in $FILES
do
	echo "ln -s $DOTFILES/$FILE $HOME/$FILE"
	ln -s $DOTFILES/$FILE $HOME/$FILE
done

CONFIGS=( awesome cairo-dock dunst gtk-2.0 gtk-3.0 lxsession nitrogen openbox pytyle roxterm.sourceforge.net sublime-text-2 sublime-text-3 volumeicon xfce4 )
for CONFIG in $CONFIGS
do
	echo "ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG"
	ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG
done

echo "ln -s $DOTFILES/.themes/ACIDBoxCustom $HOME/.themes/ACIDBoxCustom"
ln -s $DOTFILES/.themes/ACIDBoxCustom $HOME/.themes/ACIDBoxCustom

echo "ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix"
ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix

echo "ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme"
ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme