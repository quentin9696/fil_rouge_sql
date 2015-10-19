-- Titre :             Création base cabinet recrutement version élèves.sql
-- Version :           2.0
-- Date création :     28 juin 2011
-- Date modification : 19 septembre 2015
-- Auteur :            Philippe Tanguy, Quentin Vallin, Olwen Henry
-- Description :       Script de création de la base de données pour le SI "gestion de cabinet de
--                     recrutement"
--                     Note : script pour PostgreSQL 8.4

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists secteur_activite_candidature;
drop table if exists offre_emploi_secteur_activite;
drop table if exists secteur_activite;
drop table if exists message_offre_demploi;
drop table if exists message_candidature;
drop table if exists candidature;
drop table if exists offre_emploi;
drop table if exists niveau_qualification;
drop table if exists entreprise;





-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table entreprise
(
  id              serial primary key,
  nom             varchar(50) not null,
  descriptif      text,
  adresse_postale text -- Pour simplifier, adresse_postale = ville.
);

create table niveau_qualification
(
  id              serial primary key,
  intitule varchar(50) not null
);

create table offre_emploi
(
  id              serial primary key,
  id_entreprise   integer references entreprise not null,
  id_niveau_qualification integer references niveau_qualification not null,
  titre           varchar(30) not null,
  descriptif_mission text,
  profil_recherche text,
  date_depot timestamp 
);

create table secteur_activite
(
  id              serial primary key,
  intitule varchar(50) not null
);

create table offre_emploi_secteur_activite
(
  id_offre_emploi             integer references offre_emploi not null,
  id_secteur_activite         integer references secteur_activite,
  primary key(id_offre_emploi, id_secteur_activite)
);


create table candidature
(
  id              serial primary key,
  id_niveau_qualification integer references niveau_qualification not null,
  nom             varchar(50) not null,
  prenom          varchar(50) not null,
  date_naissance   timestamp,
  adresse_postale   text,
  adresse_email     text,
  cv                text,
  date_depot        timestamp
);

create table secteur_activite_candidature
(
  id_secteur_activite integer references secteur_activite,
  id_candidature integer references candidature not null, 
  primary key(id_secteur_activite, id_candidature)
);

create table message_offre_demploi
(
  id_candidature integer references candidature not null,
  id_offre_emploi integer references offre_emploi not null,
  date_emploi timestamp,
  corps_message text,
  primary key(id_candidature, id_offre_emploi)  
);

create table message_candidature
(
  id_candidature integer references candidature not null,
  id_offre_emploi integer references offre_emploi not null,
  date_envoi timestamp,
  corps_message text,
  primary key(id_candidature, id_offre_emploi)
);
-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des secteurs d'activité

insert into entreprise values (nextval('entreprise_id_seq'),'Télécom Bretagne','Télécom Bretagne est une grande école pionnière en formation, en recherche et en entrepreneuriat.','Plouzané');
insert into entreprise values (nextval('entreprise_id_seq'),'ENIB','Une école d''ingénieur juste à côté...','Plouzané');

-- Insertion des niveaux de qualification

insert into niveau_qualification values (nextval('niveau_qualification_id_seq'), 'Bac +2');


-- Insertion Candidatures
insert into candidature values (nextval('candidature_id_seq'), 1, 'VALLIN' , 'Quentin', '05/11/1994', 'havre', 'toto@toto.fr', 'mon CV','06/10/2015');

-- Insertion Secteur activite
insert into secteur_activite values(nextval('secteur_activite_id_seq'), 'Telecom');

-- Insertion Offre emploi
insert into offre_emploi values(nextval('offre_emploi_id_seq'), 2, 1, 'titre', 'desc', 'profil comme ça', '19/10/2015');

-- Insertion Offre emploi secteur activite
insert into offre_emploi_secteur_activite values (1,1);

-- Insertion Secteur activite condidature
insert into secteur_activite_candidature values (1,1);