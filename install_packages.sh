#!/usr/bin/env bash
set -e

if ! command -v brew &>/dev/null; then
	echo ">> Installing brew, rerun after done"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	exit 0
fi
if ! command -v ollama &>/dev/null; then
	echo ">> Installing ollama, rerun after done"
	curl -fsSL https://ollama.com/install.sh | sh
	exit 0
fi

PACKAGES_APT=(
	brightnessctl
	build-essential
	curl
	dunst
	fonts-noto
	grim
	i3status
	dmenu
	libnotify4
	psmisc
	pulseaudio
	pulsemixer
	ristretto
	slurp
	sway
	swayidle
	swaylock
	tar
	thunar
	udisks2
	wl-clipboard
	zathura
)
PACKAGES_BREW=(
	bat
	diffr
	fd
	fzf
	git
	go
	htop
	hyperfine
	jq
	lazydocker
	lazygit
	neovim
	python@3.12
	ripgrep
	rust
	tldr
	tmux
	uv
	ydiff
	zsh-autosuggestions
	zsh-syntax-highlighting
)

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
