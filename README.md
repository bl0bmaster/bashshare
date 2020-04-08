# Partager pleins de fichiers facilement en toute discrétion

## présentation

Script bash permettant de pousser rapidement des fichiers à envoyer par mail.

L'idée est de pouvoir en une commande créer une URL de type `https://www.gnagnagna.gna/~kikou/share/07feb7259e0653b2f093d74de2374c67aa55319b21db797cd2a66b705c87488eab452f4870ffa0017f25fe23d5e526a8403fa70e32109be6ba53bfe86b4ec9ab/` permettant d'accéder à tous les fichiers du répertoire. Et de recevoir cette URL directement dans ma boite mail ou je pourrais facilement la réexploiter.

J'ai créer ce script pour pouvoir fabriquer rapidement des répertoires de téléchargements avec une URL discrette pour faire du partage avec un tiers.

J'utilise Apache avec le module userdir. Ça permet d'être 100% statique sur le serveur.

Pour protéger mes URLs j'empêche le listing des différents répertoires de partage. L'URL `https://www.gnagnagna.gna/~kikou/share/` retourne une page vide. Les UUID(https://fr.wikipedia.org/wiki/Universal_Unique_Identifier) passés au sha512 étant complexe à deviner mes répertoires sont suffisamment discrets. 

## prérequis

### client / serveur

Ce script a besoin d'un serveur. Mais rien de compliqué à installé ou à gérer. Pas de langage de script côté serveur que du statique. 

### sur les machines clientes

 - la commande scp
 - la commande ssh

Il faut que la clef ssh soit bien configurée pour se connecter au serveur avec le bon login. 

### sur le server

#### apache

Je vous propose d'avancer avec un apache configuré avec le mode userdir. Mais on pourrait utiliser autre chose.

Dans cette page il faut remplacer kikou par le vrai nom de l'utilisateur distant.

```
sudo apt-get install apache2 libapache2-mod-ldap-userdir
sudo 
mkdir -p /home/kikou/public_html/share
touch /home/kikou/public_html/share/index.html

```
### mail

Il faut que la commande mail soit présente sur le serveur

### uuid / sha512

Il faut ques les commandes `uuid`, `sha512sum` et `sed` soient présentes sur le serveur.

## installation

Je mets mes scripts un peu complexe dans un répertoire `~/.bin/` et je mets le répertoire `~/bin` dans mon `PATH`.

Pour installer bashshare ça me donne les instructions suivantes : 

    cd ~/.bin/
    git clone https://github.com/bl0bmaster/bashshare.git
    cd ~/bin
    ln -s ../.bin/bashshare/bashshare.sh share

le `readlink` du script est là pour permettre toutes les folies (soyons fous) dans les liens symboliques.

## configuration

### ssh

Ce script considère que le lien ssh entre le client et le serveur se fait par clef et que la clef est associée au login correcte. Du coup ce script ne demande aucun credentials.
Vous trouverez de la doc ici :
https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
par exemple.

### fichier de config

Ce script a pour configuration un fichier bash qui sera sourcé.
    $HOME/.config/bashshare.conf

Les variables suivantes doivent y être mises.
	SERVER="le.serveur.sans.protocole.com"
	SHARE_DIRECTORY="public_html/share"
	SHARE_URL="https://le.serveur.sans.protocole.com/~user_du_userdir/share"
	MAIL="tommail@tondomaine.com"
    
 
## TODO 

 - permettre de lister les partages
 - permettre de supprimer les vieux partages
 - gérer les `.htaccess` par partage.
 - permettre d'utiliser d'autres couples clef/login que ceux par défaut ?
 - un installeur ?
 - réécrire tout ça en Python ?
