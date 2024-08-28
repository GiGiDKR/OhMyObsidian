your vault (you can name it anything). Then in the task, you'll see a "Variable Set" action, change the value to the **name of the folder** which contains the repository for that vault.
7. Give Termux the "Display over other apps" permission.
8. Add the Vault launch icons as Tasker widgets (use the widget type that allows you to add them to folders) to the home screen. Also, add the 3 helper tasks as widgets (as needed): 
   1. Sync Vaults   - syncs all vaults
   2. Vaults Status - outputs the **`git fetch && git status`** of each vault
   3. Sync Log      - outputs the sync log.

All vaults will sync at 4am every day using a Tasker profile.

[^1]: Do not use for now: code adaptation to come in version 1.0.2 
## Notes
- You should get a notification if a sync fails. This requires AutoNotification from the PlayStore. To disable this, disable the Sync Error Notification profile.
- The individual vault icons to open specific vaults can be a bit slow. I've tried different ways to open a vault. Faster ways had one of two problems. Either it would open the vault correctly, but then if you left the app, it would not appear in the recents list. Or, it would load the app, load the last vault used, then load the vault you wanted which ends up being slower then the current method. You can find almost all the methods I tried in the Open Vault task (they are disabled).
- If you prefer, you can have a popup menu (a scene or list dialog for example), to combine all the actions or vaults into one icon on your home screen.
- If this repository has new commits that you want, running the **`setup`** command should pull them down. After which, you may be prompted to run a command to update the setup script itself, if it was updated.

## Version history
- **1.0.0** : Initial version (adapted from [Obsidian-Android-Sync](https://github.com/DovieW/obsidian-android-sync)
- **1.0.1** : Added zsh-friendly configuration 
- **1.0.2** : WIP...