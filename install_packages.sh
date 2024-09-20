#!/usr/bin/env bash
set -ueo pipefail

# Check if doas exists
if ! command -v doas &>/dev/null; then
	superuser="sudo"
else
	superuser="doas"
fi

$superuser apt update && $superuser apt upgrade
$superuser apt install \
	bat \
	brightnessctl \
	build-essential \
	curl \
	fzf \
	git \
	grim \
	htop \
	i3status \
	jq \
	libnotify4 \
	lazygit \
	lazydocker \
	neovim \
	network-manager \
	nodejs \
	pulseaudio \
	pulsemixer \
	ripgrep \
	ristretto \
	slurp \
	sway \
	swayidle \
	swaylock \
	thunar \
	tmux \
	udisks2 \
	wl-clipboard \
	zathura
$superuser apt autoremove

if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
