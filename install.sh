#!/bin/bash

TEXT_COLOR='\033[34m'
RESET_COLOR='\033[0m'

# Fonction pour afficher la bannière
show_banner() {
    clear
    echo -e '\033[44;97m  OhMyObsidian  \033[0m'
    echo
}

show_banner

echo -ne "${TEXT_COLOR}"
read -p "Changer de dépôt Termux ? (o/n) " change_repo
echo -ne "${RESET_COLOR}"
if [[ "$change_repo" == "o" || "$change_repo" == "O" ]]; then
    show_banner
    echo -e "${TEXT_COLOR}Changement du dépôt Termux...${RESET_COLOR}"
    termux-change-repo
fi

show_banner
echo -e "${TEXT_COLOR}Configuration du stockage externe...${RESET_COLOR}"
termux-setup-storage

show_banner
echo -e "${TEXT_COLOR}Installation des dépendances...${RESET_COLOR}"
pkg update > /dev/null 2>&1 && pkg upgrade -y > /dev/null 2>&1
pkg install -y git openssh termux-api > /dev/null 2>&1

show_banner
echo -e "${TEXT_COLOR}Création des répertoires nécessaires...${RESET_COLOR}"
mkdir -p /storage/emulated/0/Documents/Repository $HOME/OhMyObsidian

show_banner
echo -e "${TEXT_COLOR}Clonage du dépôt OhMyObsidian...${RESET_COLOR}"
git clone https://github.com/GiGiDKR/OhMyObsidian.git ~/storage/shared/Documents/Repository/OhMyObsidian

show_banner
echo -e "${TEXT_COLOR}Copie du script de configuration...${RESET_COLOR}"
cp "/storage/emulated/0/Documents/Repository/OhMyObsidian/setup" "$HOME/OhMyObsidian/"
chmod +x "$HOME/OhMyObsidian/setup"
source "$HOME/OhMyObsidian/setup"