export PATH="${PATH}:/data/data/com.termux/files/home"

export STORAGE_PATH="/storage/emulated/0/Documents" # if modifying, also change line 2 in the setup script
export REPOS_PATH="$STORAGE_PATH/Repository" # if modifying, also change line 2 in the setup script
export SCRIPTS_REPO="OhMyObsidian" # if modifying, also change line 2 in the setup script
export SCRIPTS_REPO_PATH="$REPOS_PATH/$SCRIPTS_REPO"
export OBSIDIAN_DIR="Obsidian"
export OBSIDIAN_DIR_PATH="$REPOS_PATH/$OBSIDIAN_DIR"
export NOTIFICATION_PATH="$STORAGE_PATH/sync-error-notification"
export LAST_SYNC_PATH="$HOME/OhMyObsidian/last_sync.log"

alias sync="$HOME/OhMyObsidian/sync-vaults.sh --skip-pause"
alias status="bash $HOME/OhMyObsidian/vaults-status.sh"
alias open="bash $HOME/OhMyObsidian/open-vault.sh"
alias bashrc="nano /data/data/com.termux/files/usr/etc/bash.bashrc"
alias sbashrc="source /data/data/com.termux/files/usr/etc/bash.bashrc"
alias repos="cd $REPOS_PATH"
alias obsidian="cd $OBSIDIAN_DIR_PATH"
alias csetup="cp $SCRIPTS_REPO_PATH/setup $HOME/OhMyObsidian/"
alias storage="cd $STORAGE_PATH"

export RESET="\033[0m"
export GREEN="\033[1;32m"
export RED="\033[1;31m"
export BLUE="\033[1;34m"
export YELLOW="\033[1;33m"
