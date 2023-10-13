--===============================================================================================
-- DBMS name:      ORACLE Version 11gR2                         
-- Created on:     24/01/2011 11:26:48                          
--===============================================================================================
SPOOL schema_stagiaire.TXT append
	
COLUMN START_TIME NEW_VAL START_TIME
COLUMN END_TIME   NEW_VAL END_TIME

SELECT USER, TO_CHAR(SYSTIMESTAMP,'DD/MM/YYYY HH24:MI:SSSSS') START_TIME FROM DUAL;

--===============================================================================================
--                  Table: CATEGORIES                                            
--===============================================================================================
CREATE TABLE CATEGORIES  (
   CODE_CATEGORIE       NUMBER(6)                       NOT NULL,
   NOM_CATEGORIE        VARCHAR2(25)                    NOT NULL,
   DESCRIPTION          VARCHAR2(100)                   NOT NULL,
   CONSTRAINT CATEGORIES_PK PRIMARY KEY (CODE_CATEGORIE)
         USING INDEX TABLESPACE ITB_TRAN
)TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Table: CLIENTS                                               
--===============================================================================================
CREATE TABLE CLIENTS  (
   CODE_CLIENT          CHAR(5)                         NOT NULL,
   SOCIETE              NVARCHAR2(40)                   NOT NULL,
   ADRESSE              NVARCHAR2(60)                   NOT NULL,
   VILLE                VARCHAR2(30)                    NOT NULL,
   CODE_POSTAL          VARCHAR2(10)                    NOT NULL,
   PAYS                 VARCHAR2(15)                    NOT NULL,
   TELEPHONE            VARCHAR2(24)                    NOT NULL,
   FAX                  VARCHAR2(24),
   CONSTRAINT CLIENTS_PK PRIMARY KEY (CODE_CLIENT)
         USING INDEX TABLESPACE ITB_TRAN
)TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Table: COMMANDES                                             
--===============================================================================================
CREATE TABLE COMMANDES  (
   NO_COMMANDE          NUMBER(6)                       NOT NULL,
   CODE_CLIENT          CHAR(5)                         NOT NULL,
   NO_EMPLOYE           NUMBER(6)                       NOT NULL,
   DATE_COMMANDE        DATE                            NOT NULL,
   DATE_ENVOI           DATE,
   PORT                 NUMBER(8,2),
   LIVREE               NUMBER(1)             DEFAULT 0 NOT NULL,
   ACQUITEE             NUMBER(1)             DEFAULT 0 NOT NULL,
   ANNULEE              NUMBER(1)             DEFAULT 0 NOT NULL,
   ANNEE                NUMBER(4) AS (EXTRACT(YEAR FROM DATE_COMMANDE)),
   TRIMESTRE            NUMBER(1) AS (TO_NUMBER(TO_CHAR(DATE_COMMANDE,'Q'))),
   MOIS                 NUMBER(2) AS (EXTRACT(MONTH FROM DATE_COMMANDE)),
   CONSTRAINT COMMANDES_PK PRIMARY KEY (NO_COMMANDE)
   USING INDEX STORAGE ( INITIAL 1M ) TABLESPACE ITB_TRAN
)TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Index: COMM_CLIE_FK                                          
--===============================================================================================
CREATE INDEX COMM_CLIE_FK ON COMMANDES (
   CODE_CLIENT ASC
)TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Index: COMM_EMPL_FK                                          
--===============================================================================================
CREATE INDEX COMM_EMPL_FK ON COMMANDES (
   NO_EMPLOYE ASC
)TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Table: DETAILS_COMMANDES                                     
--===============================================================================================
CREATE TABLE DETAILS_COMMANDES  (
   NO_COMMANDE          NUMBER(6)                       NOT NULL,
   REF_PRODUIT          NUMBER(6)                       NOT NULL,
   PRIX_UNITAIRE        NUMBER(8,2)                     NOT NULL,
   QUANTITE             NUMBER(5)                       NOT NULL,
   REMISE               NUMBER(8,2)                     NOT NULL,
   RETOURNE             NUMBER(1)             DEFAULT 0 NOT NULL,
   ECHANGE              NUMBER(1)             DEFAULT 0 NOT NULL,
   CONSTRAINT DETAILS_COMMANDES_PK 
       PRIMARY KEY (NO_COMMANDE, REF_PRODUIT) USING INDEX,
   CONSTRAINT DET_COMM_COMM_FK FOREIGN KEY (NO_COMMANDE)
      REFERENCES COMMANDES (NO_COMMANDE)
)TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Index: DET_COMM_COMM_FK                                      
--===============================================================================================
CREATE INDEX DET_COMM_COMM_FK ON DETAILS_COMMANDES (
   NO_COMMANDE ASC
)TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Index: DET_COMM_PROD_FK                                      
--===============================================================================================
CREATE INDEX DET_COMM_PROD_FK ON DETAILS_COMMANDES (
   REF_PRODUIT ASC
)TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Table: EMPLOYES                                              
--===============================================================================================
CREATE TABLE EMPLOYES  (
   NO_EMPLOYE           NUMBER(6)                       NOT NULL,
   REND_COMPTE          NUMBER(6),
   NOM                  NVARCHAR2(40)                   NOT NULL,
   PRENOM               NVARCHAR2(30)                   NOT NULL,
   FONCTION             VARCHAR2(30)                    NOT NULL,
   TITRE                VARCHAR2(5)                     NOT NULL,
   DATE_NAISSANCE       DATE                            NOT NULL,
   DATE_EMBAUCHE        DATE                           DEFAULT SYSDATE NOT NULL,
   SALAIRE              NUMBER(8,2)                     NOT NULL,
   COMMISSION           NUMBER(8,2),
   PAYS                 VARCHAR(20),
   REGION               VARCHAR(50),
   CONSTRAINT EMPLOYES_PK PRIMARY KEY (NO_EMPLOYE)
         USING INDEX TABLESPACE ITB_TRAN
)
TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Index: EMPL_EMPL_FK                                          
--===============================================================================================
CREATE INDEX EMPL_EMPL_FK ON EMPLOYES (
   REND_COMPTE ASC
)
TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Table: FOURNISSEURS                                          
--===============================================================================================
CREATE TABLE FOURNISSEURS  (
   NO_FOURNISSEUR       NUMBER(6)                       NOT NULL,
   SOCIETE              NVARCHAR2(40)                   NOT NULL,
   ADRESSE              NVARCHAR2(60)                   NOT NULL,
   VILLE                VARCHAR2(30)                    NOT NULL,
   CODE_POSTAL          VARCHAR2(10)                    NOT NULL,
   PAYS                 VARCHAR2(15)                    NOT NULL,
   TELEPHONE            VARCHAR2(24)                    NOT NULL,
   FAX                  VARCHAR2(24),
   CONSTRAINT FOURNISSEURS_PK PRIMARY KEY (NO_FOURNISSEUR)
         USING INDEX TABLESPACE ITB_TRAN
)
TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Table: PRODUITS                                              
--===============================================================================================
CREATE TABLE PRODUITS  (
   REF_PRODUIT          NUMBER(6)                       NOT NULL,
   NOM_PRODUIT          NVARCHAR2(50)                   NOT NULL,
   NO_FOURNISSEUR       NUMBER(6)                       NOT NULL,
   CODE_CATEGORIE       NUMBER(6)                       NOT NULL,
   QUANTITE             VARCHAR2(30),
   PRIX_UNITAIRE        NUMBER(8,2)                     NOT NULL,
   UNITES_STOCK         NUMBER(5),
   UNITES_COMMANDEES    NUMBER(5),
   INDISPONIBLE         NUMBER(1)                       NOT NULL,
   CONSTRAINT PRODUITS_PK PRIMARY KEY (REF_PRODUIT)
         USING INDEX TABLESPACE ITB_TRAN
)
TABLESPACE DTB_TRAN;

--===============================================================================================
--                  Index: PROD_CATE_FK                                          
--===============================================================================================
CREATE INDEX PROD_CATE_FK ON PRODUITS (
   CODE_CATEGORIE ASC
)TABLESPACE ITB_TRAN;

--===============================================================================================
--                  Index: PROD_FOUR_FK                                          
--===============================================================================================
CREATE INDEX PROD_FOUR_FK ON PRODUITS (
   NO_FOURNISSEUR ASC
)TABLESPACE ITB_TRAN;

ALTER TABLE COMMANDES
	ADD CONSTRAINT COMMANDES_UK UNIQUE ( CODE_CLIENT, DATE_COMMANDE)
	  USING INDEX TABLESPACE ITB_TRAN;

ALTER TABLE COMMANDES
   ADD CONSTRAINT COMM_CLIE_FK FOREIGN KEY (CODE_CLIENT)
      REFERENCES CLIENTS (CODE_CLIENT)
      NOT DEFERRABLE;

ALTER TABLE COMMANDES
   ADD CONSTRAINT COMM_EMPL_FK FOREIGN KEY (NO_EMPLOYE)
      REFERENCES EMPLOYES (NO_EMPLOYE)
      NOT DEFERRABLE;

--ALTER TABLE DETAILS_COMMANDES
--   ADD CONSTRAINT DET_COMM_COMM_FK FOREIGN KEY (NO_COMMANDE)
--      REFERENCES COMMANDES (NO_COMMANDE)
--      NOT DEFERRABLE;

ALTER TABLE DETAILS_COMMANDES
   ADD CONSTRAINT DET_COMM_PROD_FK FOREIGN KEY (REF_PRODUIT)
      REFERENCES PRODUITS (REF_PRODUIT)
      NOT DEFERRABLE;

ALTER TABLE EMPLOYES
   ADD CONSTRAINT EMPL_EMPL_FK FOREIGN KEY (REND_COMPTE)
      REFERENCES EMPLOYES (NO_EMPLOYE)
      NOT DEFERRABLE;

ALTER TABLE PRODUITS
   ADD CONSTRAINT PROD_CATE_FK FOREIGN KEY (CODE_CATEGORIE)
      REFERENCES CATEGORIES (CODE_CATEGORIE)
      NOT DEFERRABLE;

ALTER TABLE PRODUITS
   ADD CONSTRAINT PROD_FOUR_FK FOREIGN KEY (NO_FOURNISSEUR)
      REFERENCES FOURNISSEURS (NO_FOURNISSEUR)
      NOT DEFERRABLE;


SELECT TO_CHAR(SYSTIMESTAMP,'DD/MM/YYYY HH24:MI:SSSSS') END_TIME FROM DUAL;

SELECT TO_TIMESTAMP('&END_TIME','DD/MM/YYYY HH24:MI:SSSSS')  
       - TO_TIMESTAMP('&START_TIME','DD/MM/YYYY HH24:MI:SSSSS') 
	   "Temps import des statistiques"
FROM DUAL;

SPOOL OFF

