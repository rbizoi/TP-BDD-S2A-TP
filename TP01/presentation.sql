col OBJECT_NAME format a20
col OWNER       format a20  
col OBJECT_TYPE format a20

SELECT OBJECT_NAME,OWNER, OBJECT_TYPE 
FROM ALL_OBJECTS 
WHERE OBJECT_NAME IN ('L2I_RESER','L2I_VILLE','L2I_CIRCUIT',
                      'L2I_CIRETAPE','L2I_CIRPROG','L2I_MONUMENT');


--------------------------------------------------------------------------------
col DATA_TYPE      format a10
col COLUMN_NAME    format a12
col TABLE_NAME     format a20
col DATA_LENGTH    format 99
col DATA_PRECISION format 9
col NULLABLE       format a10
--------------------------------------------------------------------------------
SELECT TABLE_NAME,
       COLUMN_NAME ,
       DATA_TYPE,
       DATA_LENGTH,
       DATA_PRECISION,       
       NULLABLE
FROM ALL_TAB_COLUMNS
WHERE (OWNER,TABLE_NAME) IN 
      (SELECT TABLE_OWNER,TABLE_NAME
       FROM ALL_SYNONYMS
       WHERE SYNONYM_NAME IN 
            ('L2I_RESER','L2I_VILLE','L2I_CIRCUIT',
             'L2I_CIRETAPE','L2I_CIRPROG','L2I_MONUMENT'))
ORDER BY TABLE_NAME,COLUMN_ID;
--------------------------------------------------------------------------------
!vi liste_source.sql
set echo off feedback off linesize 1500 pagesize 0
spool liste_tables.sql

SELECT 'SELECT '''||OBJECT_NAME||''', T.* FROM '||OBJECT_NAME||' T;'
FROM ALL_OBJECTS 
WHERE OBJECT_NAME IN ('L2I_RESER','L2I_VILLE','L2I_CIRCUIT',
                      'L2I_CIRETAPE','L2I_CIRPROG','L2I_MONUMENT');

spool off
spool liste_tables.txt
@liste_tables.sql
spool off
set echo on feedback on linesize 1500 pagesize 1500
!rm liste_tables.sql

@liste_source.sql
--------------------------------------------------------------------------------
select 10,12.1,12,1, -1E+123 from dual;
select 'Bonjour aujourd''hui c''est le :' as text, sysdate from dual;
--------------------------------------------------------------------------------
select to_char(sysdate,'d dd ddd day mm mon month yyyy hh24:mi:ss sssss'), 
       to_char(sysdate,'fmd dd ddd day mm mon month yyyy hh24:mi:ss sssss') from dual;
--------------------------------------------------------------------------------
SELECT NR NOMC,NC,TO_CHAR(DATEDEP,'DD/MM/YYYY'),NBRES FROM L2I_RESER
WHERE DATEDEP > '01/09/2017'
ORDER BY DATEDEP;
--------------------------------------------------------------------------------
ALTER SESSION SET NLS_LANGUAGE            = 'AMERICAN';
ALTER SESSION SET NLS_TERRITORY           = 'AMERICA';
--------------------------------------------------------------------------------
ALTER SESSION SET NLS_LANGUAGE            = 'FRENCH';
ALTER SESSION SET NLS_TERRITORY           = 'FRANCE';
--------------------------------------------------------------------------------
SELECT NR NOMC,NC,TO_CHAR(DATEDEP,'DD/MM/YYYY'),NBRES FROM L2I_RESER
WHERE DATEDEP > '01/09/2017'
ORDER BY DATEDEP;
--------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT         = 'MM/DD/YYYY HH24:MI:SS';
--------------------------------------------------------------------------------
SELECT NR NOMC,NC,TO_CHAR(DATEDEP,'DD/MM/YYYY'),NBRES FROM L2I_RESER
WHERE DATEDEP > '01/09/2017'
ORDER BY DATEDEP;
--------------------------------------------------------------------------------
@login
--------------------------------------------------------------------------------
SELECT NOMM,NOMV,PRIX 
FROM L2I_MONUMENT
WHERE NOMM = 'S%';
--------------------------------------------------------------------------------
SELECT NOMM,NOMV,PRIX 
FROM L2I_MONUMENT
WHERE NOMM like 'S%';
--------------------------------------------------------------------------------
SELECT NOMM,NOMV,PRIX 
FROM L2I_MONUMENT
WHERE NOMM like '%S%';
--------------------------------------------------------------------------------
SELECT NOMM,NOMV,PRIX 
FROM L2I_MONUMENT
WHERE NOMM like '_e%';
--------------------------------------------------------------------------------
SELECT NOMM,NOMV,PRIX 
FROM L2I_MONUMENT
WHERE NOMM LIKE '_e%' AND NOMV LIKE '%s%';
--------------------------------------------------------------------------------








