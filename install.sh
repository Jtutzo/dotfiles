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
	ttf-font-awesome \
	volumeicon \
	networkmanager \
	gnome-keyring \
	network-manager-applet \
	lxappearance \
	qt5ct \
	arc-gtk-theme \
	papirus-icon-theme

echo 'export QT_QPA_PLATFORMTHERME="qt5ct"' >> $HOME/.profile

# Install yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si --needed --noconfirm
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si --needed --noconfirm
cd ..

# Install polybar
yaourt -S --noconfirm --needed \
	polybar \
	ttf-material-design-icons

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

sudo cp ${DIR}/.config/gtk-3.0/settings.ini /usr/share/gtk-3.0/

echo "Config keymap"
sudo localectl set-x11-keymap fr

echo "Enable lightdm service"
sudo systemctl enable lightdm
sudo systemctl enable NetworkManager

echo "Please reboot system"

rm -rf ${TMP}

exit 0
