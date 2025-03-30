-- bd postgre sql
------------------------------------------------------------------------------------------------------------------------
-- create database, schema
------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE ligue_foot_bj;
-- DROP DATABASE super_ligue_bj;

CREATE SCHEMA LP_2425;
-- DROP SCHEMA SLB_2425 CASCADE;
--
------------------------------------------------------------------------------------------------------------------------
-- table saisons
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "LP_2425".saisons (
    id_saison  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_saison VARCHAR(100) NOT NULL,
    date_debut DATE         NOT NULL,
    date_fin   DATE         NOT NULL
);
--
insert into "LP_2425".saisons (nom_saison, date_debut, date_fin) values ('Celtiis Ligue Pro - Saison 2024-2025', '2024-09-21', '2025-09-20');
--
select * from saisons
------------------------------------------------------------------------------------------------------------------------
-- table poules/groupes
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "LP_2425".poules (
    id_poule  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_poule VARCHAR(50) NOT NULL,
    id_saison INT         NOT NULL,
    FOREIGN KEY (id_saison) REFERENCES "LP_2425".saisons(id_saison)
);
--
insert into "LP_2425".poules (nom_poule, id_saison) values ('Poule A', 1);
insert into "LP_2425".poules (nom_poule, id_saison) values ('Poule B', 1);
--
select * from poules
------------------------------------------------------------------------------------------------------------------------
-- table équipes
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "LP_2425".equipes (
    id_equipe    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_poule     INT          NOT NULL,
    nom_equipe   VARCHAR(100) NOT NULL,
    abreviation  VARCHAR(100) NOT NULL,
    logo_url     VARCHAR(255) DEFAULT 'not applicable',
    ville        VARCHAR(100),
    region       VARCHAR(100),
    FOREIGN KEY (id_poule) REFERENCES "LP_2425".poules(id_poule),
    UNIQUE (abreviation)
);
-- update equipes 
--     set abreviation = 'D.Abomey' where nom_equipe = 'Dynamo d''Abomey';
--
-- Insertions pour Poule A (id_poule = 1)
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Panthères de Djougou', 'Panthères', 'Djougou', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Buffles du Borgou', 'Buffles', 'Parakou', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Loto Popo FC', 'LotoPopo', 'Grand-Popo', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Hodio FC', 'Hodio', 'Come', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Béké FC', 'Béké', 'Bembereke', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Abeilles FC', 'Abeilles', 'Tchaourou', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Dynamo d''Abomey', 'D.Abomey', 'Abomey', 'Centre');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Dynamique FC', 'Dynamique', 'Djougou', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'AS Takunnin', 'Takunnin', 'Kandi', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Boa Sinendé FC', 'Boa', 'Sinendé', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Dadjè FC', 'Dadjè', 'Aplahoué', 'Centre');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'AS Tonnerre de Bohicon', 'Tonnerre', 'Bohicon', 'Centre');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Bani Gansè FC', 'BaniGansè', 'Banikoara', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'US Cavaliers de Nikki', 'USCN', 'Nikki', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Damissa FC', 'Damissa', 'N''Dali', 'Nord');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Réal Sport', 'RéalSport', 'Ouesse', 'Centre');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Espoir FC', 'Espoir', 'Savalou', 'Centre');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (1, 'Dynamo Parakou', 'D.Parakou', 'Parakou', 'Nord');
--
-- Insertions pour Poule B (id_poule = 2)
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'AS Cotonou', 'ASC', 'Cotonou', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Sitatunga FC', 'Sitatunga', 'Akassato', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'AS Port Autonome Cotonou', 'ASPAC', 'Toffo', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'AS Sobemap', 'Sobemap', 'Avrankou', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Dragons de l''Ouémé FC', 'Dragons', 'Porto-Novo', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'US Semè-Kraké', 'USSK', 'Semè', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'JSPobè', 'JSP', 'Pobè', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'AS Police', 'Police', 'Cotonou', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Requins de l''Atlantique FC', 'Requins', 'Calavi', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Aziza FC', 'Aziza', 'Cotonou', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'AS Vallée de l''Ouémé', 'ASVO', 'Adjohoun', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Adjidja FC', 'Adjidja', 'Toffo', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Ayema FC', 'Ayema', 'Pobè', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'JS Ouidah', 'JSO', 'Ouidah', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Coton FC', 'Coton', 'Ouidah', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'JA Kétou', 'JAK', 'Kétou', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Etoiles Filantes FC', 'Etoiles', 'Godomey', 'Sud');
INSERT INTO "LP_2425".equipes (id_poule, nom_equipe, abreviation, ville, region) VALUES (2, 'Avrankou Omnisport', 'AO', 'Avrankou', 'Sud');
--
select * from poules
------------------------------------------------------------------------------------------------------------------------
-- table journees
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "LP_2425".journees (
    id_journee  VARCHAR(50) PRIMARY KEY, -- J1, J2, etc...
    id_poule    INT NOT NULL,
    journee     VARCHAR(50),
    phase       VARCHAR(50), -- Aller, Retour
    date_debut  DATE,
    date_fin    DATE,
    FOREIGN KEY (id_poule) REFERENCES "LP_2425".poules(id_poule)
);
-- ALTER TABLE journees
-- ADD COLUMN journee VARCHAR(50);
------------------------------------------------------------------------------------------------------------------------
-- table matchs
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "LP_2425".matchs (
    id_match         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_journee       VARCHAR(50) NOT NULL,
    id_poule         INT NOT NULL,
    equipe_domicile  VARCHAR(100) NOT NULL,
    equipe_exterieur VARCHAR(100) NOT NULL,
    buts_domicile    INT,
    buts_exterieur   INT,
    date_match       TIMESTAMP,
    statut           VARCHAR(50) NOT NULL DEFAULT 'Programmé', -- Programmé, En cours, Terminé, Reporté, Annulé
    FOREIGN KEY (id_journee) REFERENCES "LP_2425".journees(id_journee),
    FOREIGN KEY (id_poule) REFERENCES "LP_2425".poules(id_poule),
    FOREIGN KEY (equipe_domicile) REFERENCES "LP_2425".equipes(abreviation),
    FOREIGN KEY (equipe_exterieur) REFERENCES "LP_2425".equipes(abreviation)
);

------------------------------------------------------------------------------------------------------------------------
-- table matchs
------------------------------------------------------------------------------------------------------------------------
/*
-- Table des stades
CREATE TABLE stades (
    id_stade INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_stade VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    capacite INT
);

