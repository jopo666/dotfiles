#!/usr/bin/env bash
set -e

if ! command -v brew &>/dev/null; then
	echo ">> Installing brew, rerun after done"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	exit 0
fi

if ! command -v uv &>/dev/null; then
	echo ">> Installing uv, rerun after done"
	curl -LsSf https://astral.sh/uv/install.sh | sh
	exit 0
fi

if ! command -v zvm &>/dev/null; then
	echo ">> Installing zvm"
	curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
fi

PACKAGES_APT=(
	brightnessctl
	build-essential
	curl
	dmenu
	dunst
	fonts-hack
	fonts-noto
	git
	i3
	i3status
	make
	network-manager
	pulseaudio
	ristretto
	scrot
	tar
	thunar
	udisks2
	unclutter
	xclip
	xinit
	xss-lock
	xterm
	zathura
)

PACKAGES_BREW=(
	bat
	diffr
	fd
	fzf
	htop
	jq
	lazydocker
	lazygit
	neovim
	python@3.12
	ripgrep
	tmux
	uv
	ydiff
)

PACKAGES_UV=(
	autorandr
	tldr
)

for package in "${PACKAGES_UV[@]}"; do
	uv tool install $package
done

install_apt=()
for package in "${PACKAGES_APT[@]}"; do
	if ! dpkg -l | grep -q "$package"; then
		install_apt+=("$package")
	fi
done

if [ ${#install_apt[@]} -gt 0 ]; then
	echo ">> Installing packages from apt: ${install_apt[*]}"
	sudo apt update
	sudo apt install "${install_apt[@]}"
fi

installed_brew=$(brew list --installed-on-request | awk '{print $1}')
install_brew=()
for package in "${PACKAGES_BREW[@]}"; do
	if ! echo "$installed_brew" | grep -q "$package"; then
		install_brew+=("$package")
	fi
done
if [ ${#install_brew[@]} -gt 0 ]; then
	echo ">> Installing packages from brew: ${install_brew[*]}"
	brew install "${install_brew[@]}"
fi
