#!/bin/bash   

# Colors for output 
RED='\033[0;31m' 
GREEN='\033[0;32m' 
YELLOW='\033[1;33m' 
NC='\033[0m' 
# No Color   
echo -e "${GREEN}Starting dotfiles installation...${NC}"
# Update system 
echo -e "${YELLOW}Updating system...${NC}" 
sudo pacman -Syu --noconfirm  
# Install essential packages 
echo -e "${YELLOW}Installing essential packages...${NC}" 
sudo pacman -S --needed --noconfirm \ 
hyprland \ 
waybar \ 
wofi \  
kitty \ 
mako \ 
grim \ 
slurp \
wl-clipboard \ 
ttf-jetbrains-mono-nerd \ 
ttf-font-awesome  
# Install AUR helper if not present 
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}Installing paru...${NC}" 
    git clone https://aur.archlinux.org/paru.git /tmp/paru 
    cd /tmp/paru 
    makepkg -si --noconfirm
    cd - 
fi 
# Install AUR packages 
echo -e "${YELLOW}Installing AUR packages...${NC}" 
paru -S --needed --noconfirm \  
catppuccin-gtk-theme-mocha \  
catppuccin-cursors-mocha \ 
papirus-folders-catppuccin-git  
# Apply cursor theme 
papirus-folders -C cat-mocha-mauve 
# Create necessary directories 
mkdir -p ~/.config/{hypr,waybar,wofi,mako,kitty}
mkdir -p ~/Pictures/screenshots mkdir -p ~/.local/bin 
# Symlink configurations (if using stow) 
# cd ~/dotfiles && stow */   
# Set executable permissions for scripts 
chmod +x ~/.local/bin/*
# Enable services 
systemctl --user enable --now pipewire pipewire-pulse wireplumber  
echo -e "${GREEN}Installation complete!${NC}" 
echo -e "${YELLOW}Please reboot to ensure all changes take effect.${NC}"