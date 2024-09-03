# OhMyObsidian 📑

Synchronisez facilement vos coffres [Obsidian](https://github.com/obsidianmd/obsidian-releases) sur Android en utilisant Git (SSH) + [Termux](https://github.com/termux/termux-app). Créez des raccourcis avec [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.tasker) et automatisez la synchronisation que le coffre soit ouvert ou non. [^1]

Pour éviter les conflits, ajoutez les lignes suivantes à votre fichier **.gitignore** dans tous les coffres que vous synchroniserez avec Git. Si vous remarquez qu'un plugin a un fichier qui est souvent en conflit, l'ajouter également (n'oubliez pas de le retirer du suivi avec **`git rm --cached <file>`**) :

```gitignore
/.obsidian/workspace.json
/.obsidian/workspace-mobile.json
/.obsidian/plugins/obsidian-git/data.json
/conflict-files-obsidian-git.md
```

Pour éviter les conflits avec vos fichiers de notes, vous pouvez créer un fichier **.gitattributes** à la racine de vos coffres avec le contenu suivant**.

```gitattributes
*.md merge=union
```

## Installation de Termux

1. Installez [F-Droid](https://f-droid.org/en/) ou [Obtainium](https://github.com/ImranR98/Obtainium)
2. Installez Termux depuis [F-Droid](https://f-droid.org/en/packages/com.termux/) ou [Obtainium](https://github.com/termux/termux-app)

## Configuration de la synchronisation Obsidian

> [!IMPORTANT]
> Un script d'installation complet est disponible ~~avec l'utilisation optionnelle de [gum](https://github.com/charmbracelet/gum) pour obtenir une interface de script plus propre~~.
> Pour l'exécuter, entrez :
> ```bash
> curl -o $HOME/install.sh https://raw.githubusercontent.com/GiGiDKR/OhMyObsidian/main/install.sh && chmod +x $HOME/install.sh && $HOME/install.sh
> ```
> ~~🎀 Ajoutez `--gum` ou `-g` à la fin de la commande pour utiliser l'interface [gum](https://github.com/charmbracelet/gum)~~

### Installation manuelle

- **Optionnel** : Pour installer / mettre à jour les paquets, vous pouvez sélectionner un autre dépôt afin d'augmenter la vitesse de téléchargement : `termux-change-repo`

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
> [!WARNING]
> L'étape suivante définira [safe.directory](https://git-scm.com/docs/git-config/2.35.2#Documentation/git-config.txt-safedirectory) sur '*'

2. Exécutez le script de configuration :
```bash
cp "/storage/emulated/0/Documents/Repository/OhMyObsidian/setup" ~/OhMyObsidian/ && chmod +x "$HOME/OhMyObsidian/setup" && source "$HOME/OhMyObsidian/setup"
```
3. La commande ci-dessus copie une clé publique SSH dans votre presse-papiers (ou l'affiche à l'écran), collez-la dans le gestionnaire d'authentification de clé SSH de votre hôte Git (par exemple [GitHub](https://github.com/settings/keys)). Si vous souhaitez copier à nouveau la clé SSH, ré-exécutez le script **`setup`**.

4. Dans Termux, vous devriez maintenant être dans le répertoire Obsidian (vérifiez avec **`pwd`**) où vous pouvez cloner vos coffres Obsidian. Essayez de ne pas mettre de caractères spéciaux dans le nom de votre coffre.

- La documentation d'Obsidian en format Markdown est disponible dans le [dépôt GitHub](https://github.com/obsidianmd/obsidian-help/tree/master/fr).

> [!NOTE]
> - Synchronisez tous les coffres du dossier Obsidian :
> **`sync`**
> - Obtenez le statut de la synchronisation du coffre :
> **`status`** 
> - Ouvrez Obsidian depuis Termux : 
> **`open`**

> [!TIP]
> Par défaut Git ne se souvient pas de vos identifiants, ce qu'il est possible de modfiier avec un Credential Helper :
>
> Se souvenir de vos identifiants pendant une session :
> ```bash
> git config --global credential.helper cache
> ```
> Se souvenir pendant 1 heure :
> ```bash
> git config --global credential.helper 'cache --timeout=3600'
> ```
> Se souvenir de manière permanente (moins sécurisé) :
> ```bash
> git config --global credential.helper store
> ```

## Configuration de Tasker [^1]

[Voici une image](https://bit.ly/40hLIyt) de ce à quoi cela ressemble une fois terminé avec des raccourcis vers certaines fonctions utilitaires optionnelles. Chaque coffre aura sa propre icône. Cela permet de rendre la synchronisation plus efficace car sans cela, tous les coffres se synchronisent chaque fois dans un ordre spécifique. Au lieu de cela, seul le coffre que vous ouvrez est synchronisé immédiatement. Si vous n'utilisez qu'un seul coffre ou si cela ne vous dérange pas d'attendre que le coffre que vous venez d'ouvrir soit mis à jour, vous pouvez utiliser l'icône par défaut de l'application Obsidian. De plus, tous les coffres sont synchronisés une fois par jour (par défaut à 04H00).

1. Installez [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.tasker) depuis le Play Store.
2. Installez [F-Droid](https://f-droid.org/en/).
3. Installez [Termux:Tasker](https://f-droid.org/en/packages/com.termux.tasker/) et [Termux:API](https://f-droid.org/en/packages/com.termux.api/) depuis F-Droid (ou Obtainium : [Tasker](https://github.com/termux/termux-tasker) / [Termux:API](https://github.com/termux/termux-api))
2. Activez l'autorisation Termux dans les paramètres Android de l'application Tasker.
3. Ouvrez l'application Obsidian et ajoutez vos coffres depuis le dossier **`Obsidian`**.
4. Si vous utilisez le plugin Obsidian Git, vous devriez le désactiver pour cet appareil (depuis les paramètres du plugin).
5. Importez le "Projet Tasker" dans Tasker. Une fois importé, je vous recommande de réorganiser les tâches selon [cette image](https://imgur.com/a/6Gj6aRj) pour plus de simplicité (pour réorganiser les tâches, maintenez une tâche, puis faites-la glisser). Vous pouvez importer le projet de 2 manières. Vous pouvez utiliser ce [lien TaskerNet](https://taskernet.com/shares/?user=AS35m8n3cQwLQVpqM%2Fik6LZsANJ%2F8SkOXbatTM3JXxEQY4KYaxES06TbTgTRcO7ziHKZXfzQKT1B&id=Project%3AObsidian+Syncing), ou vous pouvez importer ([image](https://imgur.com/a/Fvyl8HF)) le fichier .xml depuis ce dépôt. Une fois importé validez les invités s'affichant à l'écran.
6. **Icônes de lancement de coffre** - Il y a 2 tâches exemples (Vault1 et Vault2). Renommez la tâche au nom de votre coffre (vous pouvez le nommer comme vous voulez). Ensuite, dans la tâche, vous verrez une action "Variable Set", changez la valeur en **nom du dossier** qui contient le dépôt pour ce coffre.
7. Donnez à Termux l'autorisation "Afficher par-dessus d'autres applications".
8. Ajoutez les icônes de lancement de coffre en tant que widgets Tasker (utilisez le type de widget qui vous permet de les ajouter à des dossiers) à l'écran d'accueil. Si besoin ajoutez également les 3 tâches d'aide en tant que widgets :
   1. Sync Vaults   - synchronise tous les coffres
   2. Vaults Status - affiche le **`git fetch && git status`** de chaque coffre
   3. Sync Log      - affiche le journal de synchronisation.

Tous les coffres seront synchronisés à 04H00 chaque jour en utilisant un profil Tasker.

[^1]: Ne pas utiliser pour le moment : adaptation à venir dans la v1.1

## Notes

- Vous devriez recevoir une notification si une synchronisation échoue. Cela nécessite AutoNotification du PlayStore. Pour désactiver cela, désactivez le profil de notification d'erreur de synchronisation.
- Les icônes de coffre individuelles pour ouvrir des coffres spécifiques peuvent être un peu lentes. J'ai essayé différentes façons d'ouvrir un coffre. Les méthodes plus rapides avaient l'un des deux problèmes. Soit cela ouvrait correctement le coffre, mais ensuite si vous quittiez l'application, il n'apparaissait pas dans la liste des applications récentes. Soit cela chargeait l'application, chargeait le dernier coffre utilisé, puis chargeait le coffre que vous vouliez, ce qui finit par être plus lent que la méthode actuelle. Vous pouvez trouver presque toutes les méthodes que j'ai essayées dans la tâche Open Vault (elles sont désactivées).
- Si vous préférez, vous pouvez avoir un menu contextuel (une scène ou une boîte de dialogue de liste par exemple), pour combiner toutes les actions ou coffres en une seule icône sur votre écran d'accueil.
- Si ce dépôt a de nouveaux commits que vous souhaitez, exécuter la commande **`setup`** devrait les télécharger. Après cela, il se peut que vous soyez invité à exécuter une commande pour mettre à jour le script de configuration lui-même, s'il a été mis à jour.

## Historique des versions

- 1.0 : Version initiale (adaptée de [Obsidian-Android-Sync](https://github.com/DovieW/obsidian-android-sync))
- 1.0.1 : Ajout de la configuration compatible zsh
- 1.0.2 : Traduction française 
- 1.0.3 : Ajout d'un [script](install.sh) d'installation automatisé
- **1.1** : En développement 
   - intégration de [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.tasker)
   - Intégration de [Gum](https://github.com/charmbracelet/gum)
