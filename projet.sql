-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mer. 05 déc. 2018 à 22:38
-- Version du serveur :  5.7.17
-- Version de PHP :  5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `projet`
--

-- --------------------------------------------------------

--
-- Structure de la table `hall_of_fame`
--

CREATE TABLE `hall_of_fame` (
  `id` int(3) NOT NULL,
  `pseudo` text CHARACTER SET utf8,
  `temps` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `hall_of_fame`
--

INSERT INTO `hall_of_fame` (`id`, `pseudo`, `temps`) VALUES
(34, 'Apo', 64),
(33, 'LUC', 96),
(39, 'Lucas', 53),
(40, 'Gaston', 101);

-- --------------------------------------------------------

--
-- Structure de la table `objet`
--

CREATE TABLE `objet` (
  `id` int(3) NOT NULL,
  `name` mediumtext CHARACTER SET utf8 NOT NULL,
  `icon_position` point DEFAULT NULL,
  `recoverable` tinyint(1) NOT NULL,
  `zoom_level` int(3) NOT NULL,
  `icon_image` mediumtext CHARACTER SET utf8 NOT NULL,
  `icon_height` double NOT NULL,
  `icon_width` double NOT NULL,
  `icon_anchor_x` double NOT NULL,
  `icon_anchor_y` double NOT NULL,
  `locked` mediumtext CHARACTER SET utf8 NOT NULL,
  `content` longtext CHARACTER SET utf8 NOT NULL,
  `loaded_at_start` tinyint(1) NOT NULL,
  `suivant` mediumtext COLLATE utf8_unicode_ci,
  `loaded` tinyint(4) NOT NULL DEFAULT '0',
  `action` longtext CHARACTER SET utf8
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `objet`
--

INSERT INTO `objet` (`id`, `name`, `icon_position`, `recoverable`, `zoom_level`, `icon_image`, `icon_height`, `icon_width`, `icon_anchor_x`, `icon_anchor_y`, `locked`, `content`, `loaded_at_start`, `suivant`, `loaded`, `action`) VALUES
(8, 'start', '�\0\0\0\0\0��S�kH@NbX9�@', 0, 5, 'cafe.png', 65, 50, 0, 0, '0', '<p> Janine a entendu parler d\'un vieux birbe perdant ses heures dans le plus vieux resto de Paris. Il aura sûrement des indices à propos du géocube. </p>', 1, '9', 1, NULL),
(9, 'resto', '�\0\0\0\0\0�Q��/mH@�7�{ֵ@', 0, 15, 'chef.png', 80, 50, 0, 0, '1', '<p> Bonjour mon jeune ami, sauras-tu répondre à cette énigme : <br>\r\nMon premier est bavard, <br>\r\nMon second est oiseau, <br>\r\nMon troisième est café,<br>\r\nMon tout est une pâtisserie. </p>\r\n\r\n\r\n\r\n<select id=\"respond\">\r\n<option value=\"\">-- Sélectionner une réponse --</option> \r\n<option value=\"langue\">Langue d\'oiseau</option> \r\n<option value=\"tiramisu\">Tiramisu</option> \r\n<option value=\"bavarois\">Bavarois au café</option> \r\n<option value=\"eclair\">Eclair au café</option>\r\n</select>\r\n<button onclick=\"Unlock(\'bavarois\', document.getElementById(\'respond\').value, 9)\">Valider</button>', 0, '10', 0, '<p> Bonne réponse. Prenez cette clé, vous en aurez besoin. Je ne sais où se trouve ce que vous recherchez, mais des informateurs traînent dans les bois aux alentours de Paris </p>'),
(10, 'clef', '�\0\0\0\0\0�O��mH@�wE�@', 1, 14, 'clef.png', 85, 85, 0, 0, '0', '<p> </p>', 0, '11,12', 0, NULL),
(11, 'mamie', '�\0\0\0\0\0���\"oH@@��$@', 0, 15, 'mamie.png', 70, 50, 0, 0, '0', '<p> Jeune homme, ne venez pas m\'embêter avec vos histoires. Les aliens, et puis quoi encore. Et bientôt nous irons coloniser d\'autres planètes tant que vous y êtes. M\'enfin.</p>', 0, NULL, 0, NULL),
(12, 'vincennes', '�\0\0\0\0\0%[]N	jH@=�[�w@', 0, 15, 'vincennes.png', 70, 50, 0, 0, '1', '<p>\r\nJe sais comment obtenir une monnaie d\'échange contre le géocube. Répondez à cette énigme pour savoir où vous rendre : <br>\r\nQu’est-ce qui a des racines que personne ne voit, <br>\r\nQui est plus grand que les arbres, <br>\r\nQui monte, qui monte, <br>\r\nEt pourtant ne pousse jamais ? \r\n</p>\r\n\r\n<select id=\"respond\">\r\n<option value=\"\">-- Sélectionner une réponse --</option> \r\n<option value=\"ascenseur\">Un ascenseur</option> \r\n<option value=\"montagne\">Une montagne</option> \r\n<option value=\"tour\">La Tour Eiffel</option> \r\n<option value=\"haricot\">Le haricot magique</option>\r\n</select>\r\n<button onclick=\"Unlock(\'montagne\', document.getElementById(\'respond\').value, 12)\">Valider</button>', 0, '13,16', 0, 'Rendez-vous au point de nivellement le plus haut de Paris.'),
(13, 'montmartre', '�\0\0\0\0\0�2�~qH@\n�W��@', 1, 16, 'montmartre.png', 80, 60, 0, 0, '10', '<div ondrop=\'drop(event)\' ondragover=\'allowDrop(event)\'>\r\n<img src=\"Images/serrure.jpg\" alt=\"serrure\" width=\"80px\" height=\"80px\" style=\"justify-content: center\">\r\n</div>\r\n<p>\r\nC\'est dans l\'impasse la plus sombre de Paris, où le diable rôde, que vous trouverez votre géocube. </p>\r\n\r\n<p> Attention, il est bien gardé. Insérer la clef pour libérer l\'âme contenue dans ce coffre, et pouvoir l\'échanger contre le géocube. </p>\r\n\r\n<p> Mais avant de vous y rendre, sachez que le géocube nécessite un code pour accéder à l\'étendue de ses pouvoirs : 666. </p>\r\n', 0, '14', 0, '<img src=\"Images/coffre_ouvert.png\" alt=\"coffre_ouvert\" width=\"80px\" height=\"80px\" style=\"justify-content: center\">'),
(14, 'diable', '�\0\0\0\0\0����mH@�\0D\Z4@', 0, 14, 'diable.png', 70, 50, 0, 0, '13', '<div ondrop=\'drop(event)\' ondragover=\'allowDrop(event)\'>\r\n<p> Jeune impudent. J\'espère que tu connais les conséquences de ta venue ici et que tu ne viens pas les mains vides... Si tu me donnes une âme, tu obtiendras ce que tu cherches !</p>\r\n</div>\r\n<p> \"Donner l\'âme en échange au diable\" </p>', 0, '15', 0, 'Je vois que tu connais mes goûts, celle-ci devrait me plaire. Voici comme convenu l\'objet de ta quête.'),
(15, 'geocube', '�\0\0\0\0\0\"��3�mH@��E�8@', 0, 14, 'geocube.png', 80, 80, 0, 0, '1', '<p> \"Veuillez entrer le mot de passe\" </p>\r\n<input type=\"text\" id=\"code\" >\r\n<button onclick=\"Unlock(\'666\', document.getElementById(\'code\').value, 15)\">Valider</button>', 0, NULL, 0, '\r\n<form action=\"#\">\r\n\r\n<p>Vous avez gagné !! Cliquez pour enregistrer votre temps</p>\r\n\r\n<input type=\"submit\" value=\"Finish\" onclick=\"Win()\"> \r\n  \r\n</form>'),
(16, 'singe', '�\0\0\0\0\0���&�mH@Bx�q�Z@', 0, 16, 'singe.png', 90, 90, 0, 0, '1', 'Gni gni gni', 0, NULL, 0, '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `hall_of_fame`
--
ALTER TABLE `hall_of_fame`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `objet`
--
ALTER TABLE `objet`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `hall_of_fame`
--
ALTER TABLE `hall_of_fame`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT pour la table `objet`
--
ALTER TABLE `objet`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
