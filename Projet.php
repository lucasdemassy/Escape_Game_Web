<?php
$link = mysqli_connect('localhost', 'root', '', 'projet');  //Connexion à la base de donnée
mysqli_set_charset($link, "utf8");  //encodage en utf8


/* Requête pour inscrire les 3 meilleurs scores dans le Hall of Fame */
if(isset($_GET["hall_of_fame"])) {
  $requete = "SELECT pseudo, temps FROM hall_of_fame ORDER BY temps LIMIT 3"; //On sélectionne les 3 meilleurs temps et les pseudos associés
  $result = mysqli_query($link, $requete);  // Requête effectué
  while($row = mysqli_fetch_assoc($result)) { //On parcourt l'ensemble des résultats de la requête
    $test[] = $row; //On concatène ces informations dans un tableau associatif
  }
  echo json_encode($test);  //On envoie les données au fichier javascript sous le format JSON
}

/* Requête pour charger les objets qui doivent apparaître en début de partie */
if (isset($_GET["load"])) {
  $requete = "UPDATE objet SET loaded = 0"; // On renseigne en début de partie qu'aucun n'objet n'est chargé
  mysqli_query($link, $requete);  // Requête effectué
  // On sélectionne tout les attributs des objets qui doivent apparaître en début de partie
  // Nous n'avons pas utiliser * pour sélectionner tout les attribut car icon_position de type geometry n'est pas adapté au format JSON
  $result = mysqli_query($link, "SELECT  id, ST_X(icon_position), ST_Y(icon_position), suivant, content, icon_image, icon_height, icon_width, name, locked, recoverable, zoom_level, loaded_at_start, loaded FROM objet WHERE loaded_at_start = 1");
  while($row = mysqli_fetch_assoc($result)) { //On parcourt l'ensemble des résultats de la requête
    $test[] = $row; //On concatène ces informations dans un tableau associatif
  }
  echo json_encode($test);  //On envoie les données au fichier javascript sous le format JSON
}

/* Requête pour charger l'objet suivant à celui renseigné  par le GET*/
if (isset($_GET["id"])) {
  $value = $_GET['id']; //ID de l'objet
  $result = mysqli_query($link, "SELECT suivant, loaded FROM objet WHERE id = '$value'"); //On sélectionne l'ID du prochain objet
  while($row = mysqli_fetch_assoc($result)) { //On parcourt l'ensemble des résultats de la requête
    $transition[] = $row; //On concatène ces informations dans un tableau associatif
  }
  if ($transition[0]['suivant'] == NULL) {  //Si le suivant n'est pas renseigné
    echo json_encode($transition);  //On envoie les données au fichier javascript sous le format JSON (comme le loaded vaut 1, il ne se passera rien dans le fichier javascript)
  }
  else {
    $liste_suivant = explode(',' , $transition[0]['suivant']);  //On récupère les id des objets suivants.
    for ($i=0; $i < count($liste_suivant); $i++) {  //On parcourt la liste des ID des objets suivants à afficher
      $sous_requete = $liste_suivant[$i]; //ID d'un objet à afficher
      // On sélectionne les attributs de l'objet à afficher
      $result_final = mysqli_query($link, "SELECT id, ST_X(icon_position), ST_Y(icon_position), suivant, content, icon_image, icon_height, icon_width, name, locked, recoverable, zoom_level, loaded_at_start, loaded FROM objet WHERE id = '$sous_requete'");
      while($row = mysqli_fetch_assoc($result_final)) { //On parcourt l'ensemble des résultats de la requête
        $test[] = $row; //On concatène ces informations dans un tableau associatif
      }
    }
    echo json_encode($test);  //On envoie les données au fichier javascript sous le format JSON
  }
}

/* Requête pour déterminer les attributs des objets source et destination lors d'un évènement "drop" */
if (isset($_GET["target"])) {
  $id = $_GET["target"];  //ID de l'objet cible
  $icon_image = $_GET["img"]; //URL de l'image de l'objet source
  //On sélectionne les attributs des objets source et cible
  $result = mysqli_query($link, "SELECT  id, ST_X(icon_position), ST_Y(icon_position), suivant, content, icon_image, icon_height, icon_width, name, locked, recoverable, zoom_level, loaded_at_start, loaded FROM objet WHERE (id = '$id' OR icon_image = '$icon_image')");
  while($row = mysqli_fetch_assoc($result)) { //On parcourt l'ensemble des résultats de la requête
    $test[] = $row; //On concatène ces informations dans un tableau associatif
  }
  echo json_encode($test);  //On envoie les données au fichier javascript sous le format JSON
}

/* Requête pour afficher l'objet que l'on veut débloquer */
if (isset($_GET["unlocked"])) {
  $id = $_GET["unlocked"];  //Id de l'objet à débloquer
  // On sélectionne les attributs de l'objet à débloquer
  $result = mysqli_query($link, "SELECT id, action, ST_X(icon_position), ST_Y(icon_position), suivant, content, icon_image, icon_height, icon_width, name, locked, recoverable, zoom_level, loaded_at_start, loaded FROM objet WHERE id = '$id'");
  while($row = mysqli_fetch_assoc($result)) { //On parcourt l'ensemble des résultats de la requête
    $test[] = $row; //On concatène ces informations dans un tableau associatif
  }
  echo json_encode($test);  //On envoie les données au fichier javascript sous le format JSON
}

/* Requête pour mettre à jour la base de donnée en indiquant que l'objet a été chargé*/
if (isset($_GET["update"])) {
  $id = $_GET["update"];  //ID de l'objet chargé
  $requete = "UPDATE objet SET loaded = 1 WHERE id = '$id'";  //Requête pour signifier que l'objet a bien été chargé
  if (mysqli_query($link, $requete) == true) {  //Requête effectué
    echo json_encode("Record updated successfully");
  }
  else {
    echo json_encode("Error updating record: " . mysqli_error($link));
  }
}

/* Requête pour insérer dans la table hall_of_fame le record et le pseudo d'un joueur*/
if (isset($_GET["pseudo"])) {
  $pseudo = $_GET["pseudo"];  //pseudo du joueur
  $temps = $_GET["temps"];  //temps qu'a mis le joueur à terminer la partie
  $requete = "INSERT INTO hall_of_fame (pseudo, temps) VALUES ('$pseudo', '$temps')"; //Requête pour insérer dans la table hall_of_fame le pseudo et le temps du joueur
  if (mysqli_query($link, $requete) == true) {  //Requête effectué
    echo json_encode("Record updated successfully");
  }
  else {
    echo json_encode("Error updating record: " . mysqli_error($link));
  }
}
?>
