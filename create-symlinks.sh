#!/bin/zsh

DOTFILES="/home/manu/Dropbox/dotfiles"

FILES=( bin .aliases .gtkrc-2.0 .xmodmaprc .zshrc .ackrc .fonts .dmenurc .Xresources )

for FILE in $FILES
do
	echo "ln -s $DOTFILES/$FILE $HOME/$FILE"
	ln -s $DOTFILES/$FILE $HOME/$FILE
done

CONFIGS=( awesome dunst gtk-2.0 gtk-3.0 git-cola lxsession nitrogen roxterm.sourceforge.net volumeicon xfce4 )
for CONFIG in $CONFIGS
do
	echo "ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG"
	ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG
done

echo "ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix"
ln -s $DOTFILES/.themes/Numix $HOME/.themes/Numix

echo "ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme"
ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme



mkdir $HOME/.config/sublime-text-3
mkdir $HOME/.config/sublime-text-3/Packages
mkdir $HOME/.config/sublime-text-3/Local
echo "ln -s $DOTFILES/.config/sublime-text-3/Packages/User $HOME/.config/sublime-text-3/Packages/User"
ln -s $DOTFILES/.config/sublime-text-3/Packages/User $HOME/.config/sublime-text-3/Packages/User

echo "ln -s $DOTFILES/.config/sublime-text-3/Packages/Theme\ -\ Cobalt2 $HOME/.config/sublime-text-3/Packages/Theme\ -\ Cobalt2"
ln -s $DOTFILES/.config/sublime-text-3/Packages/Theme\ -\ Cobalt2 $HOME/.config/sublime-text-3/Packages/Theme\ -\ Cobalt2

echo "ln -s $DOTFILES/.config/sublime-text-3/Local/License.sublime_license $HOME/.config/sublime-text-3/Local/License.sublime_license"
ln -s $DOTFILES/.config/sublime-text-3/Local/License.sublime_license $HOME/.config/sublime-text-3/Local/License.sublime_license
