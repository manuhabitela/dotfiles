#!/bin/zsh

DOTFILES="/home/manu/dotfiles"

FILES=( .icons bin .dircolors .gtkrc-2.0 .xmodmaprc .Xresources .zprofile .zshenv .zshrc .zshaliases )

for FILE in $FILES
do
	echo "ln -s $DOTFILES/$FILE $HOME/$FILE"
	ln -s $DOTFILES/$FILE $HOME/$FILE
done

CONFIGS=( awesome dunst gtk-3.0 lxsession neofetch picom roxterm.sourceforge.net redshift.conf )
for CONFIG in $CONFIGS
do
	echo "ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG"
	ln -s $DOTFILES/.config/$CONFIG $HOME/.config/$CONFIG
done

echo "ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme"
ln -s $DOTFILES/.oh-my-zsh/themes/leimi.zsh $HOME/.oh-my-zsh/themes/leimi.zsh-theme



mkdir $HOME/.config/sublime-text-3
mkdir $HOME/.config/sublime-text-3/Packages
mkdir $HOME/.config/sublime-text-3/Local
echo "ln -s $DOTFILES/.config/sublime-text-3/Packages/User $HOME/.config/sublime-text-3/Packages/User"
ln -s $DOTFILES/.config/sublime-text-3/Packages/User $HOME/.config/sublime-text-3/Packages/User
