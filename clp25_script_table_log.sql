------------------------------------------------------------------------------------------------------------------------
-- création de la table log : journees_log
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE LP_2425.journees_log (
    log_id SERIAL PRIMARY KEY,
    operation_type   VARCHAR(10) NOT NULL,  -- INSERT, UPDATE, DELETE
    changed_by       VARCHAR(100) NOT NULL, -- Utilisateur ou système qui a fait la modification
    change_timestamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_journee       VARCHAR(50),           -- Données originales de la table journees
    old_id_poule     INT,
    new_id_poule     INT,
    old_journee      VARCHAR(50),
    new_journee      VARCHAR(50),
    old_phase        VARCHAR(50),
    new_phase        VARCHAR(50),
    old_date_debut   DATE,
    new_date_debut   DATE,
    old_date_fin     DATE,
    new_date_fin     DATE
);
--
-- Création d'un index pour améliorer les performances de requête
CREATE INDEX idx_journees_log_id_journee ON LP_2425.journees_log(id_journee);
CREATE INDEX idx_journees_log_timestamp ON LP_2425.journees_log(change_timestamp);
--
-- création de la fonction
CREATE OR REPLACE FUNCTION LP_2425.log_journees_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO LP_2425.journees_log (
            operation_type, changed_by,
            id_journee, old_id_poule, old_journee, old_phase, old_date_debut, old_date_fin
        ) VALUES (
            'DELETE', current_user,
            OLD.id_journee, OLD.id_poule, OLD.journee, OLD.phase, OLD.date_debut, OLD.date_fin
        );
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO LP_2425.journees_log (
            operation_type, changed_by,
            id_journee, 
            old_id_poule, 
            new_id_poule,
            old_journee, 
            new_journee,
            old_phase, 
            new_phase,
            old_date_debut, 
            new_date_debut,
            old_date_fin, 
            new_date_fin
        ) VALUES (
            'UPDATE', current_user,
            NEW.id_journee,
            OLD.id_poule, 
            NEW.id_poule,
            OLD.journee, 
            NEW.journee,
            OLD.phase, 
            NEW.phase,
            OLD.date_debut, 
            NEW.date_debut,
            OLD.date_fin, 
            NEW.date_fin
        );
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO LP_2425.journees_log (
            operation_type, changed_by,
            id_journee, new_id_poule, new_journee, new_phase, new_date_debut, new_date_fin
        ) VALUES (
            'INSERT', current_user,
            NEW.id_journee, NEW.id_poule, NEW.journee, NEW.phase, NEW.date_debut, NEW.date_fin
        );
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
--
-- Création du trigger
CREATE TRIGGER trg_journees_log
AFTER INSERT OR UPDATE OR DELETE ON LP_2425.journees
FOR EACH ROW EXECUTE FUNCTION LP_2425.log_journees_changes();
------------------------------------------------------------------------------------------------------------------------
-- création de la table log : matchs_log
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE LP_2425.matchs_log (
    log_id SERIAL PRIMARY KEY,
    operation_type         VARCHAR(10) NOT NULL,  -- INSERT, UPDATE, DELETE
    changed_by             VARCHAR(100) NOT NULL, -- Utilisateur ou système qui a fait la modification
    change_timestamp       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_match               INTEGER,               -- Données originales de la table matchs
    old_id_journee         VARCHAR(50),
    new_id_journee         VARCHAR(50),
    old_id_poule           INT,
    new_id_poule           INT,
    old_equipe_domicile    VARCHAR(100),
    new_equipe_domicile    VARCHAR(100),
    old_equipe_exterieur   VARCHAR(100),
    new_equipe_exterieur   VARCHAR(100),
    old_buts_domicile      INT,
    new_buts_domicile      INT,
    old_buts_exterieur     INT,
    new_buts_exterieur     INT,
    old_date_match         TIMESTAMP,
    new_date_match         TIMESTAMP,
    old_statut             VARCHAR(50),
    new_statut             VARCHAR(50)
);
--
-- Création des index pour améliorer les performances
CREATE INDEX idx_matchs_log_id_match ON LP_2425.matchs_log(id_match);
CREATE INDEX idx_matchs_log_timestamp ON LP_2425.matchs_log(change_timestamp);
CREATE INDEX idx_matchs_log_statut ON LP_2425.matchs_log(old_statut, new_statut);
--
-- création de la fonction
CREATE OR REPLACE FUNCTION LP_2425.log_matchs_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO LP_2425.matchs_log (
            operation_type,
            changed_by,
            id_match,
            old_id_journee,
            old_id_poule,
            old_equipe_domicile,
            old_equipe_exterieur,
            old_buts_domicile,
            old_buts_exterieur,
            old_date_match,
            old_statut
        ) VALUES (
            'DELETE', current_user,
            OLD.id_match,
            OLD.id_journee,
            OLD.id_poule,
            OLD.equipe_domicile,
            OLD.equipe_exterieur,
            OLD.buts_domicile,
            OLD.buts_exterieur,
            OLD.date_match,
            OLD.statut
        );
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO LP_2425.matchs_log (
            operation_type,
            changed_by,
            id_match,
            old_id_journee,
            new_id_journee,
            old_id_poule,
            new_id_poule,
            old_equipe_domicile,
            new_equipe_domicile,
            old_equipe_exterieur,
            new_equipe_exterieur,
            old_buts_domicile,
            new_buts_domicile,
            old_buts_exterieur,
            new_buts_exterieur,
            old_date_match,
            new_date_match,
            old_statut,
            new_statut
        ) VALUES (
            'UPDATE', current_user,
            NEW.id_match,
            OLD.id_journee,
            NEW.id_journee,
            OLD.id_poule,
            NEW.id_poule,
            OLD.equipe_domicile,
            NEW.equipe_domicile,
            OLD.equipe_exterieur,
            NEW.equipe_exterieur,
            OLD.buts_domicile,
            NEW.buts_domicile,
            OLD.buts_exterieur,
            NEW.buts_exterieur,
            OLD.date_match,
            NEW.date_match,
            OLD.statut,
            NEW.statut
        );
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO LP_2425.matchs_log (
            operation_type,
            changed_by,
            id_match,
            new_id_journee,
            new_id_poule,
            new_equipe_domicile,
            new_equipe_exterieur,
            new_buts_domicile,
            new_buts_exterieur,
            new_date_match,
            new_statut
        ) VALUES (
            'INSERT', current_user,
            NEW.id_match,
            NEW.id_journee,
            NEW.id_poule,
            NEW.equipe_domicile,
            NEW.equipe_exterieur,
            NEW.buts_domicile,
            NEW.buts_exterieur,
            NEW.date_match,
            NEW.statut
        );
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
--
-- Création du trigger
CREATE TRIGGER trg_matchs_log
AFTER INSERT OR UPDATE OR DELETE ON LP_2425.matchs
FOR EACH ROW EXECUTE FUNCTION LP_2425.log_matchs_changes();