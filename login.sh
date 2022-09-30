cat <<FIN_FICHIER > login.sql
SET LINESIZE 5000 PAGESIZE 5000 TRIMSPOOL ON ECHO OFF SERVEROUTPUT ON FEEDBACK OFF
--SET SQLPROMPT "_USER'@'_CONNECT_IDENTIFIER>"
DEFINE _EDITOR = "vi" (CHAR)

CLEAR SCREEN

SET PAUSE '[Entrée]... '
--SET PAUSE ON
SET FEEDBACK ON ECHO ON

ALTER SESSION SET NLS_LANGUAGE            = 'FRENCH';
ALTER SESSION SET NLS_TERRITORY           = 'FRANCE';
--ALTER SESSION SET NLS_CURRENCY            = '€';
ALTER SESSION SET NLS_ISO_CURRENCY        = 'FRANCE';
--ALTER SESSION SET NLS_DUAL_CURRENCY       = '€';
ALTER SESSION SET NLS_DATE_FORMAT         = 'DD/MM/YYYY HH24:MI:SS';
ALTER SESSION SET NLS_DATE_LANGUAGE       = 'FRENCH';
ALTER SESSION SET NLS_SORT                = 'FRENCH';
ALTER SESSION SET NLS_TIME_FORMAT         = 'HH24:MI:SSXFF';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT    = 'DD/MM/YYYY HH24:MI:SSXFF';
ALTER SESSION SET NLS_TIME_TZ_FORMAT      = 'HH24:MI:SSXFF TZR';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'DD/MM/YYYY HH24:MI:SSXFF TZR';
ALTER SESSION SET TIME_ZONE               = 'Europe/Paris';
FIN_FICHIER