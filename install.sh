#!/usr/bin/bash

ask() {
  while true; do
    read -rp "$1 [y/n]: " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer y or n." ;;
    esac
  done
}

echo "==> Installing base packages..."
sudo pacman -Syu --noconfirm --needed git base-devel xdg-user-dirs

if ! command -v paru &>/dev/null; then
  echo "==> Installing paru AUR helper..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru || exit
  makepkg -si --noconfirm
  cd - || exit
fi

if [[ -f packages.txt ]]; then
  echo "==> Installing packages from packages.txt..."
  paru -S --needed --noconfirm - <packages.txt
fi

declare -A modules=(
  ["bluetooth"]="bluetooth.txt"
)

for module in "${!modules[@]}"; do
  if ask "Do you want to install $module packages?"; then
    file="${modules[$module]}"
    if [[ -f "$file" ]]; then
      echo "==> Installing $module packages from $file..."
      paru -S --needed --noconfirm - <"$file"
    else
      echo "Package file $file not found, skipping $module."
    fi
  fi
done

echo "==> Initializing XDG user directories..."
sudo -u "$SUDO_USER" xdg-user-dirs-update

echo "==> All selected packages installed and user directories initialized!"

echo "==> Applying dotfiles with chezmoi..."
sudo -u "$SUDO_USER" chezmoi apply
