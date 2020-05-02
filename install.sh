#! /usr/bin/env bash

set -o nounset
set -o errexit

DIR=`pwd`
TMP=$HOME/.tmp/.dotfiles

mkdir -p ${TMP} && cd ${TMP}


echo "Install packages"
sudo pacman -Sy --noconfirm xorg-{server,xinit,apps} \
	i3 \
	lightdm \
	lightdm-gtk-greeter \
	termite \
	git \
	feh \
	rofi \
	neofetch \
	firefox \
	ttf-font-awesome


# Install yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

# Install polybar
yaourt -S --noconfirm polybar \
	ttf-material-design-icons

# Install Nord gtk theme
git clone https://github.com/EliverLara/Nordic.git
sudo mkdir -p /usr/share/themes/Nord && sudo cp -r Nordic/gtk-3.0 /usr/share/themes/Nord
sudo sed -i 's|\(gtk-.*theme-name = \)\(.*\)|\1Nord|' /usr/share/gtk-3.0/settings.ini

# Install plug vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's|\(ZSH_THEME=\)\(".*"\)|\1"simple"|' $HOME/.zshrc

echo "Config system"
cp -r ${DIR}/.Xresources \
	${DIR}/.vimrc \
	${DIR}/.config \
	${DIR}/.gitconfig \
	${DIR}/wallpaper \
	$HOME

echo "Config keymap"
sudo localectl set-x11-keymap fr

echo "Enable lightdm service"
sudo systemctl enable lightdm

echo "Please reboot system"

rm -rf ${TMP}

exit 0
