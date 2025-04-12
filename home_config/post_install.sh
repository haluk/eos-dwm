yay -S ttf-symbola slack-desktop zoom

sudo sed -i 's/^#\(export FREETYPE_PROPERTIES="truetype:interpreter-version=40"\)/\1/' /etc/profile.d/freetype2.sh

fc-cache -fv

chsh -s /bin/zsh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
