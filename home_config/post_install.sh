yay -S ttf-symbola slack-desktop zoom

sudo sed -i 's/^#\(export FREETYPE_PROPERTIES="truetype:interpreter-version=40"\)/\1/' /etc/profile.d/freetype2.sh

fc-cache -fv

# docker
sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
