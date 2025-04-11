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

# Copy wallpapers
rsync -a eos-dwm/wallpapers/ "/home/${username}/Pictures/wallpapers"
chown -R "${username}:${username}" "/home/${username}/Pictures/wallpapers"

# Copy suckless software
rsync -a eos-dwm/suckless/ "/home/${username}/sw"
chown -R "${username}:${username}" "/home/${username}/sw"

SRC_ROOT="/home/${username}/sw"
BUILD_ROOT="/home/${username}/.local/build"
LINK_TARGET="/home/${username}/.local/bin"

mkdir -p "$LINK_TARGET"

# Step 1: Discover and build programs automatically
for dir in "$SRC_ROOT"/*; do
  [ -d "$dir" ] || continue

  if [ -f "$dir/Makefile" ] || [ -f "$dir/makefile" ]; then
    prg=$(basename "$dir")
    echo "Building $prg..."

    cd "$dir" || {
      echo "Can't cd into $dir"
      continue
    }

    # Clean build optional:
    make clean &>/dev/null
    rm config.h &>/dev/null

    # Run make and install to ~/.local/build/prg
    if make && make install PREFIX="$BUILD_ROOT/$prg"; then
      echo "Installed $prg to $BUILD_ROOT/$prg"
    else
      echo "Build or install failed for $prg"
    fi
  else
    echo "No Makefile in $dir — skipping"
  fi
done

# Step 2: Link all executables from ~/.local/build/*/bin to ~/.local/bin
echo "Linking executables to $LINK_TARGET..."
for bin_dir in "$BUILD_ROOT"/*/bin; do
  [ -d "$bin_dir" ] || continue

  find "$bin_dir" -type f -executable | while read -r file; do
    link_name="$LINK_TARGET/$(basename "$file")"

    if [ -e "$link_name" ]; then
      echo "Skipping existing: $link_name"
    else
      ln -s "$file" "$link_name"
      echo "Linked: $file → $link_name"
    fi
  done
done

# Step 3: Copy scripts
scripts=(wallpaper-changer bashmount)

for script in "${scripts[@]}"; do
    cp "eos-dwm/$script" "$LINK_TARGET"
    chown "${username}:${username}" "$LINK_TARGET/$script"
    chmod +x "$LINK_TARGET/$script"
done

# Step 4: Add ~/.local/bin to PATH if needed
if ! echo "$PATH" | grep -q "$LINK_TARGET"; then
  echo "Adding $LINK_TARGET to PATH in ~/.bashrc"
  echo "export PATH=\"$LINK_TARGET:\$PATH\"" >>/home/${username}/.bashrc
  echo "Run 'source ~/.bashrc' or restart your terminal to apply the changes."
else
  echo "$LINK_TARGET already in PATH"
fi

# Install lazyvim
git clone https://github.com/LazyVim/starter /home/${username}/.config/nvim
rm -rf /home/${username}/.config/nvim/.git

# Remove the repo
echo "Removing the EOS DWM repo..."
rm -rf eos-dwm

echo "Installation complete."
