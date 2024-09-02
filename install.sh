#!/data/data/com.termux/files/usr/bin/bash

TEXT_COLOR='\033[34m'
RESET_COLOR='\033[0m'

USE_GUM=false

for arg in "$@"; do
    case $arg in
        --gum|-g)
            USE_GUM=true
            shift
            ;;
    esac
done

bash_banner() {
    clear
    echo -e '\n\033[44;97m               OHMYOBSIDIAN               \n\033[0m'
}

show_banner() {
    clear
    if $USE_GUM; then
        gum style \
            --foreground 33 \
            --border-foreground 33 \
            --border double \
            --align center \
            --width 40 \
            --margin "1 1 1 0" \
            "" "OHMYOBSIDIAN" ""
    else
        bash_banner
    fi
}

check_and_install_gum() {
    if $USE_GUM && ! command -v gum &> /dev/null; then
        bash_banner
        echo -e "${TEXT_COLOR}:: Installation de gum...${RESET_COLOR}"
        pkg update -y > /dev/null 2>&1 && pkg install gum -y > /dev/null 2>&1
    fi
}

finish() {
    local ret=$?
    if [ ${ret} -ne 0 ] && [ ${ret} -ne 130 ]; then
        echo
        if $USE_GUM; then
            gum style --foreground 196 "ERREUR: Installation de OhMyObsidian impossible."
        else
            echo -e "\e[38;5;196mERREUR: Installation de OhMyObsidian impossible.\e[0m"
        fi
        echo -e "\e[38;5;33mVeuillez vous référer au(x) message(s) d'erreur ci-dessus.\e[0m"
    fi
}

trap finish EXIT

check_and_install_gum
show_banner

if $USE_GUM; then
    if gum confirm --prompt.foreground="33" --selected.background="33" "    Changer de dépôt Termux ?    "; then
        termux-change-repo
    fi
else
    echo -ne "${TEXT_COLOR}"
    read -p "  Changer de dépôt Termux ? (o/n) " change_repo
    echo -ne "${RESET_COLOR}"
    if [[ "$change_repo" == "o" || "$change_repo" == "O" ]]; then
        termux-change-repo
    fi
fi

show_banner
if $USE_GUM; then
    gum spin --spinner dot --spinner.foreground="33" --title.foreground="33" --title "Configuration du stockage externe" -- termux-setup-storage
else
    show_banner
    echo -e "${TEXT_COLOR}:: Configuration du stockage externe${RESET_COLOR}"
    termux-setup-storage
fi

if $USE_GUM; then
    gum spin --spinner dot --spinner.foreground="33" --title.foreground="33" --title "Mise à jour des paquets" -- pkg update -y
else
    show_banner
    echo -e "${TEXT_COLOR}:: Mise à jour des paquets${RESET_COLOR}"
    pkg update -y > /dev/null 2>&1
fi

for pkg in git openssh termux-api; do
    if $USE_GUM; then
        gum spin --spinner dot --spinner.foreground="33" --title.foreground="33" --title "Installation de $pkg" -- pkg install -y $pkg
    else
        show_banner
        echo -e "${TEXT_COLOR}:: Installation de $pkg${RESET_COLOR}"
        pkg install -y $pkg > /dev/null 2>&1
    fi
done

if $USE_GUM; then
    gum spin --spinner dot --spinner.foreground="33" --title.foreground="33" --title "Création des répertoires nécessaires" -- mkdir -p /storage/emulated/0/Documents/Repository/Obsidian $HOME/OhMyObsidian
else
    show_banner
    echo -e "${TEXT_COLOR}:: Création des répertoires nécessaires${RESET_COLOR}"
    mkdir -p /storage/emulated/0/Documents/Repository/Obsidian $HOME/OhMyObsidian
fi

REPO_PATH="$HOME/storage/shared/Documents/Repository/OhMyObsidian"
if [ -d "$REPO_PATH" ]; then
    if $USE_GUM; then
        gum style --foreground 33 "Dépôt OhMyObsidian déjà existant"
    else
        echo -e "${TEXT_COLOR}Dépôt OhMyObsidian déjà existant${RESET_COLOR}"
    fi
else
    if $USE_GUM; then
        gum spin --spinner dot --spinner.foreground="33" --title.foreground="33" --title "Clonage du dépôt OhMyObsidian" -- git clone https://github.com/GiGiDKR/OhMyObsidian.git "$REPO_PATH"
    else
        show_banner
        echo -e "${TEXT_COLOR}:: Clonage du dépôt OhMyObsidian${RESET_COLOR}"
        git clone https://github.com/GiGiDKR/OhMyObsidian.git "$REPO_PATH" > /dev/null 2>&1
    fi
fi

cp "$REPO_PATH/setup" "$HOME/OhMyObsidian/"
chmod +x "$HOME/OhMyObsidian/setup"

if $USE_GUM; then
    export USE_GUM=true
else
    export USE_GUM=false
fi

cd $OBSIDIAN_DIR_PATH

source "$HOME/OhMyObsidian/setup"

rm "$0"

if command -v zsh > /dev/null 2>&1; then
  exec zsh
fi

cd $OBSIDIAN_DIR_PATH
