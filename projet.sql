-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- H√¥te : 127.0.0.1
-- G√©n√©r√© le :  mer. 05 d√©c. 2018 √† 22:38
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
-- Base de donn√©es :  `projet`
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
-- D√©chargement des donn√©es de la table `hall_of_fame`
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
-- D√©chargement des donn√©es de la table `objet`
--

INSERT INTO `objet` (`id`, `name`, `icon_position`, `recoverable`, `zoom_level`, `icon_image`, `icon_height`, `icon_width`, `icon_anchor_x`, `icon_anchor_y`, `locked`, `content`, `loaded_at_start`, `suivant`, `loaded`, `action`) VALUES
(8, 'start', 'Ê\0\0\0\0\0œ˜S„•kH@NbX9¥@', 0, 5, 'cafe.png', 65, 50, 0, 0, '0', '<p> Janine a entendu parler d\'un vieux birbe perdant ses heures dans le plus vieux resto de Paris. Il aura s√ªrement des indices √† propos du g√©ocube. </p>', 1, '9', 1, NULL),
(9, 'resto', 'Ê\0\0\0\0\0†Q∫Ù/mH@Œ7¢{÷µ@', 0, 15, 'chef.png', 80, 50, 0, 0, '1', '<p> Bonjour mon jeune ami, sauras-tu r√©pondre √† cette √©nigme : <br>\r\nMon premier est bavard, <br>\r\nMon second est oiseau, <br>\r\nMon troisi√®me est caf√©,<br>\r\nMon tout est une p√¢tisserie. </p>\r\n\r\n\r\n\r\n<select id=\"respond\">\r\n<option value=\"\">-- S√©lectionner une r√©ponse --</option> \r\n<option value=\"langue\">Langue d\'oiseau</option> \r\n<option value=\"tiramisu\">Tiramisu</option> \r\n<option value=\"bavarois\">Bavarois au caf√©</option> \r\n<option value=\"eclair\">Eclair au caf√©</option>\r\n</select>\r\n<button onclick=\"Unlock(\'bavarois\', document.getElementById(\'respond\').value, 9)\">Valider</button>', 0, '10', 0, '<p> Bonne r√©ponse. Prenez cette cl√©, vous en aurez besoin. Je ne sais o√π se trouve ce que vous recherchez, mais des informateurs tra√Ænent dans les bois aux alentours de Paris </p>'),
(10, 'clef', 'Ê\0\0\0\0\0˝O˛ÓmH@ŸwEøµ@', 1, 14, 'clef.png', 85, 85, 0, 0, '0', '<p> </p>', 0, '11,12', 0, NULL),
(11, 'mamie', 'Ê\0\0\0\0\0¢≥Ã\"oH@@ˆÌ$@', 0, 15, 'mamie.png', 70, 50, 0, 0, '0', '<p> Jeune homme, ne venez pas m\'emb√™ter avec vos histoires. Les aliens, et puis quoi encore. Et bient√¥t nous irons coloniser d\'autres plan√®tes tant que vous y √™tes. M\'enfin.</p>', 0, NULL, 0, NULL),
(12, 'vincennes', 'Ê\0\0\0\0\0%[]N	jH@=Ó[≠w@', 0, 15, 'vincennes.png', 70, 50, 0, 0, '1', '<p>\r\nJe sais comment obtenir une monnaie d\'√©change contre le g√©ocube. R√©pondez √† cette √©nigme pour savoir o√π vous rendre : <br>\r\nQu‚Äôest-ce qui a des racines que personne ne voit, <br>\r\nQui est plus grand que les arbres, <br>\r\nQui monte, qui monte, <br>\r\nEt pourtant ne pousse jamais ? \r\n</p>\r\n\r\n<select id=\"respond\">\r\n<option value=\"\">-- S√©lectionner une r√©ponse --</option> \r\n<option value=\"ascenseur\">Un ascenseur</option> \r\n<option value=\"montagne\">Une montagne</option> \r\n<option value=\"tour\">La Tour Eiffel</option> \r\n<option value=\"haricot\">Le haricot magique</option>\r\n</select>\r\n<button onclick=\"Unlock(\'montagne\', document.getElementById(\'respond\').value, 12)\">Valider</button>', 0, '13,16', 0, 'Rendez-vous au point de nivellement le plus haut de Paris.'),
(13, 'montmartre', 'Ê\0\0\0\0\0à2Ø~qH@\nêW÷Ï∑@', 1, 16, 'montmartre.png', 80, 60, 0, 0, '10', '<div ondrop=\'drop(event)\' ondragover=\'allowDrop(event)\'>\r\n<img src=\"Images/serrure.jpg\" alt=\"serrure\" width=\"80px\" height=\"80px\" style=\"justify-content: center\">\r\n</div>\r\n<p>\r\nC\'est dans l\'impasse la plus sombre de Paris, o√π le diable r√¥de, que vous trouverez votre g√©ocube. </p>\r\n\r\n<p> Attention, il est bien gard√©. Ins√©rer la clef pour lib√©rer l\'√¢me contenue dans ce coffre, et pouvoir l\'√©changer contre le g√©ocube. </p>\r\n\r\n<p> Mais avant de vous y rendre, sachez que le g√©ocube n√©cessite un code pour acc√©der √† l\'√©tendue de ses pouvoirs : 666. </p>\r\n', 0, '14', 0, '<img src=\"Images/coffre_ouvert.png\" alt=\"coffre_ouvert\" width=\"80px\" height=\"80px\" style=\"justify-content: center\">'),
(14, 'diable', 'Ê\0\0\0\0\0øïëñmH@·\0D\Z4@', 0, 14, 'diable.png', 70, 50, 0, 0, '13', '<div ondrop=\'drop(event)\' ondragover=\'allowDrop(event)\'>\r\n<p> Jeune impudent. J\'esp√®re que tu connais les cons√©quences de ta venue ici et que tu ne viens pas les mains vides... Si tu me donnes une √¢me, tu obtiendras ce que tu cherches !</p>\r\n</div>\r\n<p> \"Donner l\'√¢me en √©change au diable\" </p>', 0, '15', 0, 'Je vois que tu connais mes go√ªts, celle-ci devrait me plaire. Voici comme convenu l\'objet de ta qu√™te.'),
(15, 'geocube', 'Ê\0\0\0\0\0\"«÷3ÑmH@…ëEö8@', 0, 14, 'geocube.png', 80, 80, 0, 0, '1', '<p> \"Veuillez entrer le mot de passe\" </p>\r\n<input type=\"text\" id=\"code\" >\r\n<button onclick=\"Unlock(\'666\', document.getElementById(\'code\').value, 15)\">Valider</button>', 0, NULL, 0, '\r\n<form action=\"#\">\r\n\r\n<p>Vous avez gagn√© !! Cliquez pour enregistrer votre temps</p>\r\n\r\n<input type=\"submit\" value=\"Finish\" onclick=\"Win()\"> \r\n  \r\n</form>'),
(16, 'singe', 'Ê\0\0\0\0\0õ„‹&‹mH@Bx¥qƒZ@', 0, 16, 'singe.png', 90, 90, 0, 0, '1', 'Gni gni gni', 0, NULL, 0, '');

--
-- Index pour les tables d√©charg√©es
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
-- AUTO_INCREMENT pour les tables d√©charg√©es
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
