#!/usr/bin/env sh

set -e

git clone --branch emacs-30.1 https://git.savannah.gnu.org/git/emacs.git "$HOME"/sw/emacs

# Where Emacs will be installed
PREFIX="$HOME/.local/build/emacs"

# Optional: clean old build
make distclean || true

# Compiler & linker optimization
export LD="/usr/bin/ld.gold"
export CFLAGS="-O2 -march=native -mtune=native -flto -fuse-ld=gold"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-Wl,-O1"

# Use all CPU cores
export MAKEFLAGS="-j$(nproc)"

./autogen.sh

./configure \
  --prefix="$PREFIX" \
  --with-native-compilation \
  --with-x \
  --with-x-toolkit=no \
  --with-modules \
  --with-json \
  --with-threads \
  --with-cairo \
  --with-libotf \
  --with-rsvg \
  --with-imagemagick \
  --with-png \
  --with-jpeg \
  --with-gif \
  --with-tiff \
  --with-libxml2 \
  --without-gconf \
  --without-gsettings \
  --without-sound \
  --without-dbus \
  --without-mailutils \
  --without-pop \
  --without-xwidgets \
  --without-xaw3d \
  --without-compress-install \
  --without-gpm \
  --without-makeinfo

# Build and install
make
make install

echo "✅ Emacs 30.1 built and installed to $PREFIX"

git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
"$HOME"/.config/emacs/bin/doom install
mkdir "$HOME/org" "$HOME/notes"
