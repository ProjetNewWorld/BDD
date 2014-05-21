-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le : Mer 21 Mai 2014 à 14:51
-- Version du serveur: 5.5.20
-- Version de PHP: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `dblistecourses`
--

-- --------------------------------------------------------

--
-- Structure de la table `cheffamille`
--

CREATE TABLE IF NOT EXISTS `cheffamille` (
  `familleId` int(11) NOT NULL DEFAULT '0',
  `membreId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`familleId`,`membreId`),
  KEY `membreId` (`membreId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `cheffamille`
--

INSERT INTO `cheffamille` (`familleId`, `membreId`) VALUES
(2, 4);

-- --------------------------------------------------------

--
-- Structure de la table `contenuliste`
--

CREATE TABLE IF NOT EXISTS `contenuliste` (
  `listeId` int(11) NOT NULL DEFAULT '0',
  `produitId` int(11) NOT NULL DEFAULT '0',
  `listeQte` int(11) DEFAULT NULL,
  `dansCaddy` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`listeId`,`produitId`),
  KEY `fk_produitId` (`produitId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `contenuliste`
--

INSERT INTO `contenuliste` (`listeId`, `produitId`, `listeQte`, `dansCaddy`) VALUES
(0, 1, 12, 0),
(0, 2, 10, 0),
(0, 3, 6, 0),
(0, 4, 2, 0),
(0, 5, 2, 0),
(0, 6, 9, 0),
(0, 7, 3, 0),
(0, 8, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `demande`
--

CREATE TABLE IF NOT EXISTS `demande` (
  `familleId` int(11) NOT NULL DEFAULT '0',
  `membreId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`familleId`,`membreId`),
  KEY `membreId` (`membreId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

CREATE TABLE IF NOT EXISTS `famille` (
  `familleId` int(11) NOT NULL AUTO_INCREMENT,
  `familleLibelle` varchar(25) NOT NULL,
  `familleCode` int(11) NOT NULL,
  PRIMARY KEY (`familleId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `famille`
--

INSERT INTO `famille` (`familleId`, `familleLibelle`, `familleCode`) VALUES
(1, 'Dupont', 2546),
(2, 'deca', 0);

-- --------------------------------------------------------

--
-- Structure de la table `liste`
--

CREATE TABLE IF NOT EXISTS `liste` (
  `listeId` int(11) NOT NULL DEFAULT '0',
  `familleId` int(11) NOT NULL,
  `enCours` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`listeId`),
  KEY `produitId` (`familleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `liste`
--

INSERT INTO `liste` (`listeId`, `familleId`, `enCours`) VALUES
(0, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

CREATE TABLE IF NOT EXISTS `magasin` (
  `magasinId` int(11) NOT NULL,
  `magasinLib` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`magasinId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `magasin`
--

INSERT INTO `magasin` (`magasinId`, `magasinLib`) VALUES
(1, 'Leclerc'),
(2, 'Auchan'),
(3, 'Carrefour');

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE IF NOT EXISTS `membre` (
  `membreId` int(11) NOT NULL AUTO_INCREMENT,
  `membrePrenom` varchar(25) DEFAULT NULL,
  `membreLogin` varchar(15) DEFAULT NULL,
  `membreMdp` varchar(15) DEFAULT NULL,
  `membreEmail` varchar(75) DEFAULT NULL,
  `familleId` int(6) DEFAULT NULL,
  `dateCreation` date DEFAULT NULL,
  `membreNom` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`membreId`),
  KEY `familleId` (`familleId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `membre`
--

INSERT INTO `membre` (`membreId`, `membrePrenom`, `membreLogin`, `membreMdp`, `membreEmail`, `familleId`, `dateCreation`, `membreNom`) VALUES
(1, 'Jean', 'jean', 'ini01', 'jean@gmail.com', 1, '2014-04-20', 'Dupont'),
(4, 'papa', 'papa', 'passroot', 'root@gmail.com', 2, '2014-05-21', 'deca'),
(5, 'cyril', 'cysou', 'pass', '04arnaud@gmail.com', 2, '2014-05-21', 'deca'),
(6, 'nicolas', 'nico', 'passnico', 'nicolas.capiaumont@gmail.com', 2, '2014-05-21', 'deca');

-- --------------------------------------------------------

--
-- Structure de la table `organisation`
--

CREATE TABLE IF NOT EXISTS `organisation` (
  `magasinId` int(11) NOT NULL DEFAULT '0',
  `rayonId` int(11) NOT NULL DEFAULT '0',
  `organisationOrdre` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`magasinId`,`rayonId`,`organisationOrdre`),
  KEY `rayonId` (`rayonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `organisation`
--

INSERT INTO `organisation` (`magasinId`, `rayonId`, `organisationOrdre`) VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE IF NOT EXISTS `produit` (
  `produitId` int(11) NOT NULL,
  `produitLib` varchar(50) DEFAULT NULL,
  `rayonId` int(11) DEFAULT NULL,
  PRIMARY KEY (`produitId`),
  KEY `fk_rayon` (`rayonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `produit`
--

INSERT INTO `produit` (`produitId`, `produitLib`, `rayonId`) VALUES
(1, 'pilon de poulet', 1),
(2, 'cote de boeuf', 1),
(3, 'flanby', 2),
(4, 'yaourt nature', 2),
(5, 'feuille de chenes blonde', 3),
(6, 'carote', 3),
(7, 'Pelle', 7),
(8, 'Pot en terre', 7);

-- --------------------------------------------------------

--
-- Structure de la table `rayon`
--

CREATE TABLE IF NOT EXISTS `rayon` (
  `rayonId` int(11) NOT NULL,
  `rayonLib` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`rayonId`),
  UNIQUE KEY `rayonIdx` (`rayonLib`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rayon`
--

INSERT INTO `rayon` (`rayonId`, `rayonLib`) VALUES
(7, 'Jardinerie'),
(3, 'Legume'),
(1, 'viande'),
(2, 'yaourt');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `cheffamille`
--
ALTER TABLE `cheffamille`
  ADD CONSTRAINT `cheffamille_ibfk_6` FOREIGN KEY (`membreId`) REFERENCES `membre` (`membreId`),
  ADD CONSTRAINT `cheffamille_ibfk_1` FOREIGN KEY (`familleId`) REFERENCES `famille` (`familleId`),
  ADD CONSTRAINT `cheffamille_ibfk_2` FOREIGN KEY (`familleId`) REFERENCES `famille` (`familleId`),
  ADD CONSTRAINT `cheffamille_ibfk_3` FOREIGN KEY (`membreId`) REFERENCES `membre` (`membreId`),
  ADD CONSTRAINT `cheffamille_ibfk_4` FOREIGN KEY (`membreId`) REFERENCES `membre` (`membreId`),
  ADD CONSTRAINT `cheffamille_ibfk_5` FOREIGN KEY (`membreId`) REFERENCES `membre` (`membreId`);

--
-- Contraintes pour la table `contenuliste`
--
ALTER TABLE `contenuliste`
  ADD CONSTRAINT `fk_listeId` FOREIGN KEY (`listeId`) REFERENCES `liste` (`listeId`),
  ADD CONSTRAINT `fk_produitId` FOREIGN KEY (`produitId`) REFERENCES `produit` (`produitId`);

--
-- Contraintes pour la table `liste`
--
ALTER TABLE `liste`
  ADD CONSTRAINT `fk_famille` FOREIGN KEY (`familleId`) REFERENCES `famille` (`familleId`);

--
-- Contraintes pour la table `membre`
--
ALTER TABLE `membre`
  ADD CONSTRAINT `membre_ibfk_1` FOREIGN KEY (`familleId`) REFERENCES `famille` (`familleId`);

--
-- Contraintes pour la table `organisation`
--
ALTER TABLE `organisation`
  ADD CONSTRAINT `organisation_ibfk_1` FOREIGN KEY (`magasinId`) REFERENCES `magasin` (`magasinId`),
  ADD CONSTRAINT `organisation_ibfk_2` FOREIGN KEY (`rayonId`) REFERENCES `rayon` (`rayonId`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `fk_rayon` FOREIGN KEY (`rayonId`) REFERENCES `rayon` (`rayonId`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

grant all privileges on listedescourses.* to 'userLDC'@'127.0.0.1' identified by 'passLDC';
