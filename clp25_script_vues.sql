-- VIEWS
------------------------------------------------------------------------------------------------------------------------
-- vues pour les equipes par poules et par saisons
------------------------------------------------------------------------------------------------------------------------
CREATE VIEW LP_2425.equipe_poule AS
WITH t_all AS (
    SELECT 
        s.id_saison,
        s.nom_saison,
        p.id_saison,
        p.nom_poule,
        p.id_poule,
        e.id_poule,
        e.id_equipe,
        e.nom_equipe,
        e.abreviation
    FROM LP_2425.equipes e
    LEFT JOIN LP_2425.poules p ON e.id_poule = p.id_poule
    LEFT JOIN LP_2425.saisons s ON p.id_saison = s.id_saison
)
SELECT nom_saison, nom_equipe, nom_poule, abreviation FROM t_all;
------------------------------------------------------------------------------------------------------------------------
-- vues pour avoir le nombre de victoires, nuls et défaites
------------------------------------------------------------------------------------------------------------------------
CREATE VIEW LP_2425.equipe_resultats AS
WITH vdn_dom_ext AS (
    SELECT 
        e.nom_equipe,
        e.abreviation,
        p.nom_poule,
        -- vdn domicile
        COUNT(CASE WHEN m.buts_domicile > m.buts_exterieur AND m.equipe_domicile = e.abreviation THEN 1 END) AS victoires_domicile,
        COUNT(CASE WHEN m.buts_domicile < m.buts_exterieur AND m.equipe_domicile = e.abreviation THEN 1 END) AS defaites_domicile,
        COUNT(CASE WHEN m.buts_domicile = m.buts_exterieur AND m.equipe_domicile = e.abreviation THEN 1 END) AS nuls_domicile,
        -- vdn extérieure
        COUNT(CASE WHEN m.buts_exterieur > m.buts_domicile AND m.equipe_exterieur = e.abreviation THEN 1 END) AS victoires_exterieur,
        COUNT(CASE WHEN m.buts_exterieur < m.buts_domicile AND m.equipe_exterieur = e.abreviation THEN 1 END) AS defaites_exterieur,
        COUNT(CASE WHEN m.buts_exterieur = m.buts_domicile AND m.equipe_exterieur = e.abreviation THEN 1 END) AS nuls_exterieur
    FROM LP_2425.equipes e
    LEFT JOIN LP_2425.matchs m ON e.abreviation = m.equipe_domicile OR e.abreviation = m.equipe_exterieur
    LEFT JOIN LP_2425.poules p ON e.id_poule = p.id_poule 
    WHERE m.statut = 'Terminé'
    GROUP BY e.nom_equipe, e.abreviation, p.nom_poule
)
SELECT 
    nom_poule,
    nom_equipe,
    abreviation,
    victoires_domicile,
    defaites_domicile,
    nuls_domicile,
    victoires_exterieur,
    defaites_exterieur,
    nuls_exterieur,
    -- totaux
    (victoires_domicile + victoires_exterieur) AS total_victoires,
    (defaites_domicile + defaites_exterieur) AS total_defaites,
    (nuls_domicile + nuls_exterieur) AS total_nuls
FROM vdn_dom_ext;
------------------------------------------------------------------------------------------------------------------------
-- vues pour avoir le nombre de buts marqués et encaissés
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW LP_2425.equipe_buts AS
WITH buts_dom_ext AS (
    SELECT 
        e.nom_equipe,
        e.abreviation,
        p.nom_poule,
        -- Buts marqués et encaissés à domicile
        SUM(CASE WHEN m.equipe_domicile = e.abreviation THEN m.buts_domicile ELSE 0 END) AS buts_marques_domicile,
        SUM(CASE WHEN m.equipe_domicile = e.abreviation THEN m.buts_exterieur ELSE 0 END) AS buts_encaisses_domicile,
        -- Buts marqués et encaissés à l'extérieur
        SUM(CASE WHEN m.equipe_exterieur = e.abreviation THEN m.buts_exterieur ELSE 0 END) AS buts_marques_exterieur,
        SUM(CASE WHEN m.equipe_exterieur = e.abreviation THEN m.buts_domicile ELSE 0 END) AS buts_encaisses_exterieur
    FROM LP_2425.equipes e
    LEFT JOIN LP_2425.matchs m ON e.abreviation = m.equipe_domicile OR e.abreviation = m.equipe_exterieur
    LEFT JOIN LP_2425.poules p ON e.id_poule = p.id_poule
    WHERE m.statut = 'Terminé'
    GROUP BY 
        e.nom_equipe, e.abreviation, p.nom_poule
)
SELECT 
    nom_equipe,
    abreviation,
    nom_poule,
    buts_marques_domicile,
    buts_encaisses_domicile,
    buts_marques_exterieur,
    buts_encaisses_exterieur,
    -- Totaux globaux
    (buts_marques_domicile + buts_marques_exterieur) AS total_buts_marques,
    (buts_encaisses_domicile + buts_encaisses_exterieur) AS total_buts_encaisses
FROM 
    buts_dom_ext;
------------------------------------------------------------------------------------------------------------------------
-- vues du classement
------------------------------------------------------------------------------------------------------------------------
CREATE VIEW LP_2425.classement AS
SELECT 
    e.id_poule,
    e.nom_equipe,
    e.abreviation,
    er.nom_poule,
    er.total_victoires + er.total_nuls + er.total_defaites AS matchs_joues,
    (er.total_victoires * 3) + er.total_nuls AS points,
    eb.total_buts_marques,
    eb.total_buts_encaisses,
    eb.total_buts_marques - eb.total_buts_encaisses AS difference_buts,
    er.total_victoires,
    er.total_nuls,
    er.total_defaites
FROM LP_2425.equipes e
JOIN LP_2425.equipe_resultats er ON e.abreviation = er.abreviation
JOIN LP_2425.equipe_buts eb ON e.abreviation = eb.abreviation
ORDER BY 
    e.id_poule,
    points DESC,
    difference_buts DESC,
    total_buts_marques DESC;