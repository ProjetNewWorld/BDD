-- -----------------------------------------------------
-- Base de données listedescourses
-- Pour le contexte NewWorld
-- Utilisation de la base pour les applications :
--   AppliWeb
--   AppliAndroid
--   BackOffice
-- Création collaborative :
--   Arnaud Eloi
--   Nicolas Capiaumont
--   Cyril Arnaud
--   Kevin Da Rocha
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Création de la base de données
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS listedescourses DEFAULT CHARACTER SET utf8 ;
USE listedescourses ;

-- -----------------------------------------------------
-- Création des tables de la base de données
-- -----------------------------------------------------

-- -----------------------------------------------------
-- famille
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS famille (
  familleId INT(11) AUTO_INCREMENT PRIMARY KEY,
  familleLibelle VARCHAR(25) NOT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- membre
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS membre (
  membreId INT(11) AUTO_INCREMENT PRIMARY KEY,
  membrePrenom VARCHAR(25) NULL DEFAULT NULL ,
  membreLogin VARCHAR(15) NULL DEFAULT NULL ,
  membreMdp VARCHAR(15) NULL DEFAULT NULL ,
  membreEmail VARCHAR(75) NULL DEFAULT NULL ,
  familleId INT(6) NULL DEFAULT NULL ,
  dateCreation DATE NULL DEFAULT NULL ,
  membreNom VARCHAR(25) NULL DEFAULT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- cheffamille
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS cheffamille (
  familleId INT(11) DEFAULT 0 ,
  membreId INT(11) DEFAULT 0 ,
  PRIMARY KEY (familleId, membreId) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- liste
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS liste (
  listeId INT(11) AUTO_INCREMENT PRIMARY KEY,
  familleId INT(11) NOT NULL ,
  enCours TINYINT(1) NULL DEFAULT '1',
  next TINYINT(1) NULL DEFAULT '0')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- rayon
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS rayon (
  rayonId INT(11) AUTO_INCREMENT PRIMARY KEY ,
  rayonLib VARCHAR(30) NULL DEFAULT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- produit
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS produit (
  produitId INT(11) AUTO_INCREMENT PRIMARY KEY ,
  produitLib VARCHAR(50) NULL DEFAULT NULL ,
  rayonId INT(11) NULL DEFAULT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- contenuliste
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS contenuliste (
  listeId INT(11) DEFAULT 0 ,
  produitId INT(11) DEFAULT 0 ,
  listeQte INT(11) NULL DEFAULT NULL ,
  dansCaddy TINYINT(1) NULL DEFAULT 0 ,
  PRIMARY KEY (listeId, produitId) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- demande
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS listedescourses.demande (
  familleId INT(11) DEFAULT 0 ,
  membreId INT(11) DEFAULT 0 ,
  PRIMARY KEY (familleId, membreId) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Mise en place des contraintes d'intégrité référentiel
-- -----------------------------------------------------
-- Table cheffamille
ALTER TABLE cheffamille
ADD FOREIGN KEY (familleId) REFERENCES famille (familleId),
ADD FOREIGN KEY (membreId) REFERENCES membre (membreId);

-- Table demande
ALTER TABLE demande
ADD FOREIGN KEY (familleId) REFERENCES famille (familleId),
ADD FOREIGN KEY (membreId) REFERENCES membre (membreId);

-- Table membre
ALTER TABLE membre
ADD FOREIGN KEY (familleId) REFERENCES famille (familleId);

-- Table liste
ALTER TABLE liste
ADD FOREIGN KEY (familleId) REFERENCES famille (familleId);

-- Table contenuliste
ALTER TABLE contenuliste
ADD FOREIGN KEY (produitId) REFERENCES produit (produitId),
ADD FOREIGN KEY (listeId) REFERENCES liste (listeId);

-- Table produit
ALTER TABLE produit
ADD FOREIGN KEY (rayonId) REFERENCES rayon (rayonId);


-- -----------------------------------------------------
-- Mise en place d'un jeu d'essai
-- -----------------------------------------------------
-- Ajout de familles
INSERT INTO famille (familleId, familleLibelle) VALUES
(1, 'Dupont'),
(2, 'deca'),
(3, 'admin');

-- Ajout de membres
INSERT INTO membre (membreId, membrePrenom, membreLogin, membreMdp, membreEmail, familleId, dateCreation, membreNom) VALUES
(1, 'Jean', 'jean', 'ini01', 'jean@gmail.com', 1, '2014-04-20', 'Dupont'),
(4, 'papa', 'papa', 'passroot', 'root@gmail.com', 2, '2014-05-21', 'deca'),
(5, 'cyril', 'cysou', 'pass', '04arnaud@gmail.com', 2, '2014-05-21', 'deca'),
(6, 'nicolas', 'nico', 'passnico', 'nicolas.capiaumont@gmail.com', 2, '2014-05-21', 'deca'),
(7, 'admin', 'admin', 'admin', 'admin@admin.fr', 3, '2014-05-23', 'admin');

-- Ajout de chefs de famille
INSERT INTO cheffamille (familleId, membreId) VALUES
(2, 4),
(3, 7);

-- Création de listes
INSERT INTO liste (listeId, familleId, enCours) VALUES
(4, 2, 1),
(5, 3, 1);

-- Ajout de rayons
INSERT INTO rayon (rayonId, rayonLib) VALUES
(8, 'Boucherie'),
(7, 'Jardinerie'),
(3, 'Legume'),
(1, 'Viande'),
(2, 'Yaourt');

-- Ajout de produits
INSERT INTO produit (produitId, produitLib, rayonId) VALUES
(1, 'Pilon de poulet', 1),
(2, 'Côte de boeuf', 1),
(3, 'Flanby', 2),
(4, 'Yaourt nature', 2),
(5, 'Feuille de chenes blonde', 3),
(6, 'Carotte', 3),
(7, 'Pelle', 7),
(8, 'Pot en terre', 7),
(9, 'Entrecote', 8);

-- Ajout de produit dans des listes
INSERT INTO contenuliste (listeId, produitId, listeQte, dansCaddy) VALUES
(4, 5, 1, 0),
(4, 6, 5, 0),
(4, 7, 3, 0),
(4, 8, 2, 0),
(4, 9, 1, 0);

-- -----------------------------------------------------
-- Création de l'utilisateur avec les droits sur la table
-- -----------------------------------------------------
-- Base de donnée : listedescourses
-- Utilisateur : userLDC
-- Mot de passe : passLDC
-- Hôte : 127.0.0.1
GRANT ALL PRIVILEGES ON listedescourses.* TO 'userLDC'@'127.0.0.1' IDENTIFIED BY 'passLDC';
