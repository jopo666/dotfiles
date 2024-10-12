#!/usr/bin/env bash
set -e

REPO="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"
FONTS=(Hack)

mkdir -p ~/.local/share/fonts
for FONT in "${FONTS[@]}"; do
	echo "Downloading and installing $FONT..."
	curl -OL "$REPO/$FONT.tar.xz"
	mkdir -p "$FONT"
	tar xf "$FONT.tar.xz" --directory="$FONT"
	mv -v "$FONT"/*.ttf ~/.local/share/fonts/
	rm -rf "$FONT" "$FONT.tar.xz"
	fc-cache -f
done

echo "Done!"
