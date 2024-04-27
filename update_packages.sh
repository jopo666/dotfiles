#!/usr/bin/env bash

doas apt update && doas apt upgrade
doas apt install \
	bat \
	bemenu \
	brightnessctl \
	build-essential \
	curl \
	firefox \
	fzf \
	git \
	grim \
	htop \
	i3status \
	jq \
	libnotify4 \
	mako-notifier \
	neovim \
	network-manager \
	nnn \
	nodejs \
	pulseaudio \
	pulsemixer \
	ristretto \
	shellcheck \
	slurp \
	sway \
	swayidle \
	swaylock \
	thunar \
	tmux \
	udisks2 \
	wl-clipboard \
	zathura
doas apt autoremove

# Install languages
if ! command -v cargo &>/dev/null; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if ! command -v zig &>/dev/null; then
	echo "Zig is not installed. Please install it manually."
fi
if ! command -v go &>/dev/null; then
	echo "Go is not installed. Please install it manually."
fi
