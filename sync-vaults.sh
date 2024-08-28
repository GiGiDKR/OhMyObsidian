#!/data/data/com.termux/files/usr/bin/bash

clear

source /data/data/com.termux/files/usr/etc/bash.bashrc

LOCK_FILE="$HOME/OhMyObsidian/sync-vaults.lock"

# Function to remove the lock file 
cleanup() {
    rm -f "$LOCK_FILE"
    exit 1
}

# Trap to catch interruptions 
trap cleanup INT TERM

# Function to wait for the lock to be released 
wait_for_lock_release() {
    while [ -e "$LOCK_FILE" ]; do
        sleep 1
    done
}

if [ -e "$LOCK_FILE" ]; then
    if [ -z "$(ps -p $(cat "$LOCK_FILE") -o pid=)" ]; then
        echo "Removing stale lock file."
        rm -f "$LOCK_FILE"
    else
        wait_for_lock_release
    fi
fi

# Store PID in lock file 
echo $$ > "$LOCK_FILE"

skip_pause=false
for arg in "$@"; do
  if [ "$arg" == "--skip-pause" ]; then
    skip_pause=true
    break
  fi
done

source "$HOME/OhMyObsidian/log_helper.sh"
log_file="$HOME/OhMyObsidian/sync.log"
setup_logging "$log_file"

cmd () {
  printf "\n\033[0;34m%s\033[0m\n" "$(basename "$PWD")"
  "$HOME/OhMyObsidian/git-sync" -ns 2>&1 | tee "$LAST_SYNC_PATH"
  if [ $? -ne 0 ]; then
    cat "$LAST_SYNC_PATH" >> "$NOTIFICATION_PATH"
  fi
}

git_repos=()

# Fill the table with the Git repositories from the Obsidian folder 
for dir in "$OBSIDIAN_DIR_PATH"/*; do
  if [ -d "$dir" ]; then
    cd "$dir"
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      git_repos+=("$dir")
    fi
  fi
done

msg="You can try running 'setup' to see if it helps."

# Exit if no Git repository found 
if [ ${#git_repos[@]} -eq 0 ]; then
  echo -e "${YELLOW}No Git repositories found in the Obsidian folder.\n${msg}${RESET}"
  cleanup
fi

if [[ -n "$1" && "$1" != "--skip-pause" ]]; then
  if [[ " ${git_repos[@]} " =~ " $OBSIDIAN_DIR_PATH/$1 " ]]; then
    (cd "$OBSIDIAN_DIR_PATH/$1" && cmd)
  else
    echo -e "${RED}Specified directory doesn't exist or is not a Git repository.\n${msg}${RESET}"
    cleanup
  fi
else
  for repo in "${git_repos[@]}"; do
    (cd "$repo" && cmd)
  done
fi

log_cleanup "$log_file"

if [ "$skip_pause" = false ]; then
  echo -e '\n\033[44;97mPress enter to finish...\033[0m'
  read -r none
fi

rm -f "$LOCK_FILE"
exit 0