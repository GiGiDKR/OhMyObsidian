# OhMyObsidian

Synchronisez facilement vos coffres Obsidian sur Android en utilisant Git (SSH) + Termux, avec automatisation et raccourcis via Tasker, que le coffre soit ouvert ou fermé.

[Voici une image](https://bit.ly/40hLIyt) de ce à quoi cela ressemble, une fois terminé avec des raccourcis vers certaines fonctions utilitaires optionnelles. Chaque coffre aura sa propre icône. Cela permet de synchroniser de manière plus efficace car sans cela, tous les coffres se synchronisent à chaque fois dans un ordre spécifique. Au lieu de simplement synchroniser immédiatement le coffre que vous ouvrez. Si vous n'utilisez qu'un seul coffre ou si vous ne vous souciez pas de l'inefficacité d'attendre que le coffre que vous venez d'ouvrir soit mis à jour, vous pouvez utiliser l'icône par défaut de l'application Obsidian. De plus, tous les coffres sont synchronisés une fois par jour (par défaut à 4h du matin).

Pour éviter les conflits, je vous recommande d'ajouter les lignes suivantes à votre fichier **.gitignore** dans tous vos coffres que vous synchroniserez avec Git. Si vous remarquez qu'un plugin a un fichier qui est souvent en conflit, vous voudrez l'ajouter également (n'oubliez pas de le retirer du suivi avec **`git rm --cached <file>`**):
```gitignore
/.obsidian/workspace.json
/.obsidian/workspace-mobile.json
/.obsidian/plugins/obsidian-git/data.json
/conflict-files-obsidian-git.md
```
Pour éviter les conflits avec vos fichiers de notes, vous pouvez créer un fichier **.gitattributes** à la racine de vos coffres avec le contenu suivant. Cela acceptera toujours les deux modifications pour les fichiers **`.md`**.
```gitattributes
*.md merge=union
```
## Configuration de Termux
1. Installez [F-Droid](https://f-droid.org/en/) ou [Obtainium](https://github.com/ImranR98/Obtainium)
2. Installez Termux depuis [F-Droid](https://f-droid.org/en/packages/com.termux/) ou [Obtainium](https://github.com/termux/termux-app)

## Configuration de la synchronisation Obsidian

> [!TIP]
> Pour installer / mettre à jour des paquets, vous pouvez sélectionner un dépôt particulier pour augmenter la vitesse de téléchargement :
> ```bash
> termux-change-repo
> ```

1. Exécutez les commandes suivantes :
```bash
termux-setup-storage
```
```bash
pkg update && pkg upgrade -y && pkg install -y git openssh termux-api
```
```bash
mkdir -p /storage/emulated/0/Documents/Repository $HOME/OhMyObsidian
```
```bash
git clone https://github.com/GiGiDKR/OhMyObsidian.git ~/storage/shared/Documents/Repository/OhMyObsidian
```
> [!IMPORTANT]
> Sachez que l'étape suivante définira [safe.directory](https://git-scm.com/docs/git-config/2.35.2#Documentation/git-config.txt-safedirectory) sur '*'
   
2. Exécutez le script de configuration :
```bash
cp "/storage/emulated/0/Documents/Repository/OhMyObsidian/setup" ~/OhMyObsidian/ && chmod +x "$HOME/OhMyObsidian/setup" && source "$HOME/OhMyObsidian/setup"
```
3. La commande ci-dessus a copié une clé publique SSH dans votre presse-papiers (ou l'a affichée à l'écran), collez-la dans les paramètres d'authentification des clés SSH de votre hôte Git (par exemple [Github](https://github.com/settings/keys)). Si vous souhaitez copier à nouveau la clé SSH, exécutez à nouveau le script **`setup`**.

4. Dans Termux, vous devriez maintenant être dans le répertoire Obsidian (vérifiez avec **`pwd`**) où vous devriez cloner vos coffres Obsidian. Essayez de ne pas mettre de caractères spéciaux dans le nom de votre coffre.

> [!NOTE]
> - Pour synchroniser tous les coffres dans le dossier Obsidian, exécutez :
> **`sync`**
> - Pour obtenir le statut de la synchronisation des coffres :
> **`status`** 
> - Pour ouvrir Obsidian depuis Termux : 
> **`open`**

> [!TIP]
> Par défaut, Git ne mémorise pas vos identifiants, mais il est possible de changer cela avec un Credential Helper :
>
> Afin de mémoriser vos identifiants pendant une session :
> ```bash
> git config --global credential.helper cache
> ```
> Pour mémoriser pendant 1 heure :
> ```bash
> git config --global credential.helper 'cache --timeout=3600'
> ```
> Mémoriser de manière permanente (moins sécurisé) :
> ```bash
> git config --global credential.helper store
> ```

## Configuration de Tasker [^1]
1. Installez [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.tasker) depuis le Play Store.
2. Installez [F-Droid](https://f-droid.org/en/).
3. Installez [Termux:Tasker](https://f-droid.org/en/packages/com.termux.tasker/) et [Termux:API](https://f-droid.org/en/packages/com.termux.api/) depuis F-Droid (ou depuis Obtainium : [Tasker](https://github.com/termux/termux-tasker) / [API](https://github.com/termux/termux-api))
2. Activez la permission Termux dans les paramètres Android de l'application Tasker.
3. Ouvrez l'application Obsidian et ajoutez vos coffres depuis le dossier **`Obsidian`**.
4. Si vous utilisez le plugin Obsidian Git, vous devriez le désactiver pour cet appareil. Vous pouvez le faire dans les paramètres du plugin.
5. Importez le "projet Tasker" dans Tasker. Une fois importé, je vous recommande de réorganiser les tâches en fonction de [cette image](https://imgur.com/a/6Gj6aRj) pour plus de simplicité (pour réorganiser les tâches, maintenez une tâche, puis faites-la glisser). Vous pouvez importer le projet de 2 façons. Vous pouvez utiliser ce [lien TaskerNet](https://taskernet.com/shares/?user=AS35m8n3cQwLQVpqM%2Fik6LZsANJ%2F8SkOXbatTM3JXxEQY4KYaxES06TbTgTRcO7ziHKZXfzQKT1B&id=Project%3AObsidian+Syncing), ou vous pouvez importer ([image](https://imgur.com/a/Fvyl8HF)) le fichier .xml depuis ce dépôt. Une fois importé, il y aura quelques invites, je pense une pour donner à Tasker "Accès à l'utilisation" et une pour activer tous les profils. Acceptez tout.
6. **Icônes de lancement de coffre** - Il y a 2 tâches d'exemple (Vault1 et Vault2). Renommez la tâche avec le nom de votre coffre (vous pouvez le nommer comme vous voulez). Ensuite, dans la tâche, vous verrez une action "Variable Set", changez la valeur par le **nom du dossier** qui contient le dépôt pour ce coffre.
7. Donnez à Termux la permission "Afficher par-dessus d'autres applications".
8. Ajoutez les icônes de lancement de coffre en tant que widgets Tasker (utilisez le type de widget qui vous permet de les ajouter aux dossiers) à l'écran d'accueil. Ajoutez également les 3 tâches d'assistance en tant que widgets (selon les besoins) :
   1. Sync Vaults   - synchronise tous les coffres
   2. Vaults Status - affiche le **`git fetch && git status`** de chaque coffre
   3. Sync Log      - affiche le journal de synchronisation.

Tous les coffres se synchroniseront à 4h du matin chaque jour en utilisant un profil Tasker.

[^1]: Ne pas utiliser pour l'instant : adaptation du code à venir dans la version 1.0.3

## Notes
- Vous devriez recevoir une notification si une synchronisation échoue. Cela nécessite AutoNotification du PlayStore. Pour désactiver cela, désactivez le profil de notification d'erreur de synchronisation.
- Les icônes de coffre individuelles pour ouvrir des coffres spécifiques peuvent être un peu lentes. J'ai essayé différentes manières d'ouvrir un coffre. Les méthodes plus rapides avaient l'un des deux problèmes. Soit cela ouvrait correctement le coffre, mais ensuite si vous quittiez l'application, il n'apparaissait pas dans la liste des récentes. Soit cela chargeait l'application, chargeait le dernier coffre utilisé, puis chargeait le coffre que vous vouliez, ce qui finit par être plus lent que la méthode actuelle. Vous pouvez trouver presque toutes les méthodes que j'ai essayées dans la tâche Open Vault (elles sont désactivées).
- Si vous préférez, vous pouvez avoir un menu popup (une scène ou une boîte de dialogue de liste par exemple), pour combiner toutes les actions ou coffres en une seule icône sur votre écran d'accueil.
- Si ce dépôt a de nouveaux commits que vous souhaitez, exécuter la commande **`setup`** devrait les récupérer. Après quoi, il se peut que vous soyez invité à exécuter une commande pour mettre à jour le script de configuration lui-même, s'il a été mis à jour.

## Historique des versions
- **1.0.0** : Version initiale (adaptée de [Obsidian-Android-Sync](https://github.com/DovieW/obsidian-android-sync)
- **1.0.1** : Ajout de la configuration compatible zsh
- **1.0.2** : Traduction française 
- **1.0.3** : En cours...

