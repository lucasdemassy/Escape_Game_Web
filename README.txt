READ ME :

--> ATTENTION IMAGES : <--
  Vous devez impérativement créer un dossier Images où vous placerez toutes les images (png, jpg, svg, ...) 

BDD :
  
  L'éxécutable d'easyPHP-Devserver-17.0-setup.exe est joint pour installer le serveur.

  L'import de la base de données se fait sur phpMyAdmin, accessible sur le tableau de bord EasyPHP, dans la section "modules" :
  Il faut créer une base de données vide intitulée 'projet'. 
  Il y a un bouton 'import' en haut de la page qui permet de charger la base de données avec le fichier : 'projet.sql'.
  Vous pouvez alors laisser les valeurs par défaut et valider .

LANCER LE JEU :

  Lancer le fichier "escape_game.html" via EasyPHP en définissant un dossier de travail. 

MISES EN GARDE :

  Attention, si l'on clique trop vite durant les temps de chargement des Ajax : on peut dupliquer les objets dans l'inventaire.
  De même après résolution d'une devinette, il faut attendre qu'une deuxième popup s'ouvre et ne pas dézoomer trop vite 
  sinon la suite de l'énigme n'est pas débloquée.
  Pour récupérer l'âme dans le coffre, il faut cliquer sur l'icône de la fille. 

Certains objets peuvent 



DESCRIPTIF :

Les dossiers :

  Images 		contient toutes les images nécessaires au bon déroulement du jeu.


Les fichiers :

  escape_game.html 	définit la page d'accueil du jeu.
  escape_game.css 	décrit le style de la majorité des éléments du site.

  Projet.js		définit les fonctions du jeu (avec des ajax permettant de récupérer
			les éléments de la base de données) et son déroulement. 
  Projet.php		fait le lien entre la base de données et le fichier 'Projet.js'. 

  Carte.html 		contient les balises des éléments pour lancer le jeu (carte, demande de pseudo, bouton de validation).
  Carte.css 		décrit les dimensions et l'agencement de la carte et du bouton pour démarrer le jeu. 
  
  enigme.html 		contient les réponses aux énigmes. 
  loose.html		s'affiche si le joueur n'est pas assez rapide à résoudre le jeu.
  contributeurs.html 
  et geocube.html 	viennent compléter le site par des précisions sur les éléments du jeu.

  jquery-3.3.1.min.js	librairie jquery. 
  
