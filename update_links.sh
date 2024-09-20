#!/usr/bin/env bash
set -ueo pipefail

mkdir -pv "$HOME/.config"
mkdir -pv "$HOME/.local"
mkdir -pv "$HOME/.local/bin"
mkdir -pv "$HOME/.ssh"
mkdir -pv "$HOME/code"
mkdir -pv "$HOME/downloads"
mkdir -pv "$HOME/documents"
mkdir -pv "$HOME/pictures"

link_file() {
	src="$1"
	dst="$2"
	if [ -L "$dst" ]; then
		rm "$dst"
		ln -sv "$src" "$dst"
	elif [ -e "$dst" ]; then
		diff -y "$src" "$dst" || true
		echo -n "File '$dst' exists, do you want to overwrite it? [y/N] "
		read -r response
		if [ "$response" != "y" ]; then
			return
		else
			rm -r "$dst"
			ln -sv "$src" "$dst"
		fi
	else
		ln -sv "$src" "$dst"
	fi
}

for src in "$PWD"/home/*; do
	if [ -d "$src" ]; then
		mkdir -pv "$HOME/.$(basename "$src")"
		for file in "$src"/*; do
			link_file "$file" "$HOME/.$(basename "$src")/$(basename "$file")"
		done
	else
		link_file "$src" "$HOME/.$(basename "$src")"
	fi
done

for src in "$PWD"/config/*; do
	link_file "$src" "$HOME/.config/$(basename "$src")"
done
for src in "$PWD"/bin/*; do
	link_file "$src" "$HOME/.local/bin/$(basename "$src")"
done
