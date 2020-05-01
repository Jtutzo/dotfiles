#! /usr/bin/env bash

set -o nounset
set -o errexit

TMP_FOLDER=$HOME/.tmp
FOLDER=jtutzo-dotfiles

mkdir -p ${TMP_FOLDER}/${FOLDER} && cd ${TMP_FOLDER}/${FOLDER}


echo "Install packages"
sudo pacman -Sy xorg-{server,xinit,apps} \
	i3-graps \
	lightdm \
	lightdm-gtk-greeter \
	termite \
	git

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
yourt -S polybar

# Install Nord gtk theme
git clone https://github.com/EliverLara/Nordic.git
sudo mkdir -p /usr/share/themes/Nord && sudo cp -r Nordic/gtk-3.0 /usr/share/themes/Nord
sudo sed -i 's|\(gtk-.*theme-name = \)\(.*\)|\1Nord|' /usr/share/gtk-3.0/settings.ini

# Install plug vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Config system"
cp -r .Xresources .vimrc .config .gitconfig $HOME

echo "Config keymap"
sudo localectl set-x11-keymap fr

echo "Enable lightdm service"
sudo systemctl enable lightdm

echo "Please reboot system"

rm ${TMP_FOLDER}/${FOLDER}

exit 0
