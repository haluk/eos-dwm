yay -S ttf-symbola ttf-joypixels slack-desktop zoom brave-beta-bin sioyek-git

sudo sed -i 's/^#\(export FREETYPE_PROPERTIES="truetype:interpreter-version=40"\)/\1/' /etc/profile.d/freetype2.sh

fc-cache -fv

# docker
sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
## store resources on home
mkdir "$HOME/.docker"
sudo systemctl stop docker
sudo mv /var/lib/docker "$HOME/.docker/data"
sudo mkdir /etc/docker
DATA_ROOT="${HOME}/.docker/data"
echo "{
  \"data-root\": \"${DATA_ROOT}\"
}" | sudo tee /etc/docker/daemon.json >/dev/null

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

## plugins
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/yuhonas/zsh-aliases-lsd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-lsd
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
git clone https://github.com/reegnz/jq-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/jq
mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/nnn
curl -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/nnn/_nnn https://raw.githubusercontent.com/jarun/nnn/master/misc/auto-completion/zsh/_nnn

# sdkman
curl -s "https://get.sdkman.io" | bash

# visidata
uv tool install visidata
