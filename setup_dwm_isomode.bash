#!/usr/bin/env bash
username="$1"

# Clone the repo
echo "Cloning the EOS DWM repo..."
git clone https://github.com/haluk/eos-dwm

# Install the custom package list
echo "Installing needed packages..."
pacman -S --noconfirm --noprogressbar --needed --disable-download-timeout $(<./eos-dwm/packages-repository.txt)

# Deploy user configs
echo "Deploying user configs..."
rsync -a eos-dwm/.config "/home/${username}/"
rsync -a eos-dwm/home_config/ "/home/${username}/"
# Restore user ownership
chown -R "${username}:${username}" "/home/${username}"

# Copy suckless software
rsync -a eos-dwm/suckless/ "/home/${username}/sw"

# Remove the repo
echo "Removing the EOS DWM repo..."
rm -rf eos-dwm

echo "Installation complete."
