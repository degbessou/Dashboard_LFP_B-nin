-- insertions tables journees et matchs

/* Prompt Claude / CGP
en te basant sur ces 2 images, les tables et exemples d" insertions ci-dessous et les noms d'equipes et abreviattions : 
génère moi les insertions postgre sql pour les tables. 
(id_poule = 1, pour poule A et 2 pour poule B) 
génère le tout dans un seul fichier, épargne toi des commentaires et des heures 00:00:00
-- Table des journées de championnat
CREATE TABLE journees (
    id_journee  VARCHAR(50) PRIMARY KEY, -- J1, J2, etc...
    id_poule    INT NOT NULL,
    journee     VARCHAR(50),
    phase       VARCHAR(50), -- Aller, Retour
    date_debut  DATE,
    date_fin    DATE,
    FOREIGN KEY (id_poule) REFERENCES "LP_2425".poules(id_poule)
);
INSERT INTO "LP_2425".journees (id_journee, journee, id_poule, phase, date_debut, date_fin) VALUES 
('J1A', 'J1', 1, 'Aller', '2024-09-21', '2024-09-29');
-- Table des matchs
CREATE TABLE matchs (
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
INSERT INTO "LP_2425".matchs (id_journee, id_poule, equipe_domicile, equipe_exterieur, buts_domicile, buts_exterieur, date_match, statut) VALUES 
('J1A', 1, 'Panthères', 'Buffles', 0, 0, '2024-09-21', 'Terminé'),
('J1A', 1, 'LotoPopo', 'Hodio', NULL, NULL, '2024-09-28', 'Reporté');
-- les noms d'equipes et abreviattions
"nom_equipe"    "abreviation"
"Panthères de Djougou"  "Panthères"
"Buffles du Borgou" "Buffles"
"Loto Popo FC"  "LotoPopo"
"Hodio FC"  "Hodio"
"Béké FC"   "Béké"
"Abeilles FC"   "Abeilles"
"Dynamo d'Abomey"   "D.Abomey"
"Dynamique FC"  "Dynamique"
"AS Takunnin"   "Takunnin"
"Boa Sinendé FC"    "Boa"
"Dadjè FC"  "Dadjè"
"AS Tonnerre de Bohicon"    "Tonnerre"
"Bani Gansè FC" "BaniGansè"
"US Cavaliers de Nikki" "USCN"
"Damissa FC"    "Damissa"
"Réal Sport"    "RéalSport"
"Espoir FC" "Espoir"
"Dynamo Parakou"    "D.Parakou"
"AS Cotonou"    "ASC"
"Sitatunga FC"  "Sitatunga"
"AS Port Autonome Cotonou"  "ASPAC"
"AS Sobemap"    "Sobemap"
"Dragons de l'Ouémé FC" "Dragons"
"US Semè-Kraké" "USSK"
"JSPobè"    "JSP"
"AS Police" "Police"
"Requins de l'Atlantique FC"    "Requins"
"Aziza FC"  "Aziza"
"AS Vallée de l'Ouémé"  "ASVO"
"Adjidja FC"    "Adjidja"
"Ayema FC"  "Ayema"
"JS Ouidah" "JSO"
"Coton FC"  "Coton"
"JA Kétou"  "JAK"
"Etoiles Filantes FC"   "Etoiles"
"Avrankou Omnisport"    "AO"
/*