
/* Création de la carte */
var mymap = L.map('mapid').setView([48.841, 2.588], 18);  //Création de la carte avec une vue initiale sur l'ENSG

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=sk.eyJ1IjoibHVjYXNkZW1hc3N5IiwiYSI6ImNqb2VvMTV5dDF6MnMzd294cmI2anpqNjAifQ.-rXQcctd6dUBB50-Be7I6g', {
attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
maxZoom: 18,
id: 'mapbox.streets',
accessToken: 'your.mapbox.access.token'
}).addTo(mymap);  //Le token a été obtenu via le site Mapbox en créant un compte

/* Création des couches de la carte */
var Visible_layer = new L.LayerGroup(); //Création d'un groupe de couche qui sera affiché
var Invisible_layer = new L.LayerGroup(); //Création d'un groupe de couche non-affiché
Visible_layer.addTo(mymap); //Ajout du groupe des couches visibles à la carte

/* EVENTS */
window.addEventListener("load", function(){ //Quand la fenêtre est chargée, on fait apparaître les icônes qui doivent être chargées en début de partie
  var ajax = new XMLHttpRequest();
  // méthode HTTP utilisée et fichier à charger
  ajax.open('GET', "Projet.php?load=1"); // envoi la requête
  ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  // on écoute l’évènement load de la requête
  ajax.addEventListener("load",  AffichageAjax);  //Affichage des icônes
  ajax.send();   //Envoi de l'AJAX
});

mymap.on('zoomend', ZoomProcess); //Quand le niveau de zoom de la carte change, on ne rend visible que les couches dont le niveau de zoom est inférieur au niveau de zoom de la carte

/* FUNCTIONS */
function AffichageAjax(){ //Fonction qui affiche l'objet suivant
  var result = JSON.parse(this.responseText) ; //Conversion des données JSON en tableau associatif
  for (var i = 0; i < result.length; i++) { //On parcourt l'ensemble des résultats données par l'AJAX
    if (result[i]["loaded"] == '0') { //Si l'objet n'est pas déjà chargé, on le charge (cela évite les doublons)
      var icon = L.icon({ //Définition de l'icône du marqueur
          iconUrl: "Images/" + result[i]["icon_image"], //On définit l'image de l'icône
          iconSize: [result[i]['icon_width'], result[i]['icon_height']],  //On définit la taille de l'icône
          className: result[i]["zoom_level"], //Le niveau de zoom de l'icône est stocké dans le nom de classe de l'icône
      });
      var popup = L.popup({'className':result[i]['id']}).setContent(result[i]['content']);  //Le nom de classe de la popup contient l'id de l'objet dans la base de donnée. On définit également son contenu
      var marker = L.marker([result[i]['ST_X(icon_position)'], result[i]['ST_Y(icon_position)']], {icon: icon}) //On créé un marqueur à une position donnée et avec une icône rensignée
      .bindPopup(popup) //On lui rajoute aussi la popup
      if (result[i]["locked"] == '0') { //Si l'objet n'est pas bloqué, on affiche l'objet suivant
        marker.on('click', function(){
          var ajax1 = new XMLHttpRequest();
          // méthode HTTP utilisée et fichier à charger
          var popup_name = this.getPopup().options['className'];
          ajax1.open('GET', "Projet.php?id=" + popup_name); // envoi la requête pour récupérer les attributs de l'objet suivant
          ajax1.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
          // on écoute l’évènement load de la requête
          ajax1.addEventListener('load',  AffichageAjax); //On affiche l'objet
          ajax1.send(); //Envoi de l'AJAX
        })
        if (result[i]["recoverable"] == '1') {  //Si l'objet est récupérable
          marker.on('click', function(){  //Quand on clique sur l'objet
            addInventory(icon.options.iconUrl);  //Cela rajoute l'image dans l'inventaire
            Visible_layer.removeLayer(this);  //Et on supprime l'icône des couches visibles
          })
        }
      }
      Invisible_layer.addLayer(marker); //Ajout du marqueur dans la couche invisible pour éviter qu'il s'affiche même si son niveau de zoom ne lui permet pas
      var ajax2 = new XMLHttpRequest();
      ajax2.open('GET', "Projet.php?update=" + result[i]["id"]); // On met à jour la base de donnée en renseignant que la couche a bien été chargée
      ajax2.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
      // on écoute l’évènement load de la requête
      ajax2.addEventListener('load',  function(){});
      ajax2.send();
    }
  }
  AffichageZoom();  //On vérifie si la couche peut être affichée en fonction du niveau de zoom
}


function allowDrop(ev) {  //Autorise un objet HTML à être déposé
  ev.preventDefault();  //By default, data/elements cannot be dropped in other elements. To allow a drop, we must prevent the default handling of the element.
}

function drop(ev) {
  ev.preventDefault();  //Call preventDefault() to prevent the browser default handling of the data (default is open as link on drop)
  var data = ev.dataTransfer.getData("text"); //On récupère l'adresse de l'image transporté
  img_name = parent.document.getElementById(data).src
  img_name = img_name.split("/case_"); //On sépare cette adresse pour avoir le nom de l'image
  img_name = img_name[img_name.length - 1]; //On récupère seulement le nom du fichier image qui se trouve à la fin de l'adresse
  target = ev.target.offsetParent.classList[1]; //On récupère le nom de la popup où l'objet est relâché
  var ajax = new XMLHttpRequest();
  ajax.open('GET', "Projet.php?target=" + target + "&img=" + img_name); // envoi la requête
  ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  // on écoute l’évènement load de la requête
  ajax.addEventListener('load',  function(){
    // quand c’est fini, on affiche le résultat
    var result = JSON.parse(ajax.responseText) ; //Conversion de la réponse JSON en tableau associatif
    for (var i = 0; i < result.length; i++) { //Parcours des résultats pour définir les éléments source et destinataire.
      if (result[i]["id"] == target) {
        cible = result[i];  //Définition de l'objet cible qui reçoit l'image
      }
      if (result[i]["icon_image"] == img_name) {
        source = result[i]; //Définition de l'objet source qui transporte l'image
      }
    }
    Unlock(cible["locked"], source["id"], cible["id"]); //Déblocage de l'objet
  });
  ajax.send();  //Envoi de l'AJAX
}


function addInventory(imgURL){  //Modifie l'inventaire pour afficher une nouvelle image
  numero = 1;
  while (parent.document.getElementById("case" + numero).alt != "empty") {
    //Tant que les cases de l'inventaire sont remplis, on incrémente
    numero += 1
  }
  imgURL = imgURL.split('/');
  imgURL = imgURL[0] + "/case_" + imgURL[1];  //On créé l'adresse d'une image spécifique à l'inventaire
  parent.document.getElementById("case" + numero).src = imgURL; //On change l'image de la case
  parent.document.getElementById("case" + numero).alt = "full"; //On indique que la case est remplie
}


function ZoomProcess() {  //Fonction qui s'applique quand le niveau de zoom change
  DesaffichageZoom(); //Fonction qui désaffiche les objets avec un niveau de zoom supérieur à celui de la carte
  AffichageZoom();  //Fonction qui affiche les objets avec un niveau de zoom inférieur ou égal à celui de la carte
}

function AffichageZoom(){ //Fonction qui affiche les objets avec un niveau de zoom inférieur ou égal à celui de la carte
  Invisible_layer.eachLayer(function(layer){  //On parcourt l'ensemble des icônes invisibles
    zoom_level = layer.options.icon.options.className;  //On récupère, dans le nom de l'icône, le niveau de zoom requis pour que l'icône apparaisse
    if (mymap.getZoom() >= zoom_level) {  //Si le niveau de zoom de l'icône est inférieur ou égale à celui de la carte
        Visible_layer.addLayer(layer);  //On affiche l'icône en la rajoutant à la couche des visibles
        Invisible_layer.removeLayer(layer); //On supprime l'icône des couches invisibles
    }
  });
}

function DesaffichageZoom(){  //Fonction qui désaffiche les objets avec un niveau de zoom supérieur ou égal à celui de la carte
  Visible_layer.eachLayer(function(layer){  //On parcourt l'ensemble des icônes visibles
    zoom_level = layer.options.icon.options.className;  //On récupère, dans le nom de l'icône, le niveau de zoom requis pour que l'icône apparaisse
    if (mymap.getZoom() < zoom_level) { //Si le niveau de zoom de l'icône est supérieur à celui de la carte
        Invisible_layer.addLayer(layer);  //On ajoute l'icône à la couche des invisibles
        Visible_layer.removeLayer(layer); //On fait disparaître l'icône en la supprimant de la couche des visibles
    }
  });
}


function Unlock(lock, key, target_id){  //Fonction qui débloque un objet, c'est à dire qu'il sera capble d'afficher l'objet suivant si on reclique dessus
  if (lock == key) {  //Si le serrure est égale à la clé donnée
    Visible_layer.eachLayer(function(layer){  //On parcourt chaque icône visible
      if (layer.isPopupOpen()) {  //Si sa popup est ouverte, on l'a ferme
        mymap.closePopup(layer.getPopup()); //Suppose qu'il n'y a qu'une Popup ouverte à la fois
      }
    });
    var ajax = new XMLHttpRequest();
    ajax.open('GET', "Projet.php?unlocked=" + target_id); // envoi la requête pour récupérer les attributs de l'objet à débloquer
    ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    // on écoute l’évènement load de la requête
    ajax.addEventListener('load',  function(){
        var result = JSON.parse(ajax.responseText) ; //Conversion de la réponse JSON en tableau associatif
        for (var i = 0; i < result.length; i++) { //On parcourt l'ensemble des résultats donnés par l'AJAX
          Visible_layer.eachLayer(function(layer){  //On parcourt chaque icône visible
            if (layer.getPopup().options['className'] == result[i]["id"]) {  //On récupère la couche dont on a fermé la popup précédemment
              layer.getPopup().setContent(result[i]['action']) //On modifie le contenu de cette popup
              mymap.openPopup(layer.getPopup());  //On ouvre cette popup
              var ajax = new XMLHttpRequest();
              // méthode HTTP utilisée et fichier à charger
              var popup_name = layer.getPopup().options['className'];  //On récupère l'id de l'objet qui est stocké dans le nom de classe de la popup
              ajax.open('GET', "Projet.php?id=" + popup_name); // envoi la requête pour récupérer les attributs de l'objet suivant à afficher
              ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
              // on écoute l’évènement load de la requête
              ajax.addEventListener('load',  AffichageAjax);  //Afichage de l'objet
              ajax.send();  //Envoi de l'AJAX
              if (result[i]["recoverable"] == '1') {  //Si l'objet est récupérable
                layer.on('click', function(){ //Quand on clique sur l'objet
                  addInventory(layer.options.icon.options.iconUrl); //Cela rajoute l'image dans l'inventaire
                  Visible_layer.removeLayer(this);  //Et on supprime l'icône des couches visibles
                })
              }
            }
          });
        }
    });
    ajax.send();  //Envoi de l'AJAX
  }
}


function Win(){ //Fonction appelé par la dernière popup et enregistre le score dans la base de donnée
  var temps = parent.document.getElementById('chrono').value; //On récupère le temps écoulé au format minute:seconde
  temps = temps.split(':'); //on divise le temps selon ':'
  temps = (parseInt(temps[0], 10)*60) + parseInt(temps[1], 10); //On convertit le temps en seconde
  var pseudo = document.getElementById('pseudo').value; //On récupère le pseudo du joueur renseigné en début de partie
  var ajax = new XMLHttpRequest();
  ajax.open('GET', "Projet.php?pseudo=" + pseudo + "&temps=" + temps);   //On met à jour la table hall_of_fame en renseignant le temps et le pseudo du joueur
  ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  ajax.addEventListener('load',  function(){console.log("Coucou");});  // on écoute l’évènement load de la requête
  ajax.send(); //envoi de l'AJAX
}
