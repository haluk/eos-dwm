yay -S ttf-symbola

sudo sed -i 's/^#\(export FREETYPE_PROPERTIES="truetype:interpreter-version=40"\)/\1/' /etc/profile.d/freetype2.sh
