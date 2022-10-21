create or replace view representants 
as 
SELECT
    no_employe,
    rend_compte,
    nom,
    prenom,
    fonction,
    titre,
    date_naissance,
    date_embauche,
    salaire,
    commission,
    pays,
    region
FROM
    employes
where fonction like 'Rep%';

update representants set salaire = salaire * 1.1
where pays = 'France';



grant select on representants to stag02;
grant select on ventes_a to stag02;

select * from ventes_a
order by 1,2,3

grant select on ventes_a to stag02;


create or replace view representants 
as 
SELECT
    no_employe,
    rend_compte,
    nom,
    prenom,
    fonction,
    titre,
    date_naissance,
    date_embauche,
    salaire,
    commission,
    pays,
    region
FROM
    employes
where fonction like 'Rep%'
with check option;
