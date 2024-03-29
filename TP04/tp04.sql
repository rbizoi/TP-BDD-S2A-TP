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


select * from representants;

update representants set salaire = salaire * 1.1
where pays = 'France';

grant select,INSERT, UPDATE, DELETE on representants to stag02;
grant select on ventes_a to stag02;
revoke select on ventes_a from stag02; 


create or replace view ventes_a
as 
select annee, trimestre, mois, 
       sum(quantite) quantite,
       sum(quantite*prix_unitaire) ca
from commandes join details_commandes using(no_commande)
group by annee, trimestre, mois;

select * from ventes_a
order by 1,2,3;

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


update representants
set fonction = 'Assistante commerciale';


insert into representants
values (112, Null, 'Grangirard', 'Patricia', 'Assistante commerciale',
'Mme',to_date('04/04/1977','dd/mm/yyyy'), 
to_date('09/02/2000','dd/mm/yyyy'), 1700, Null, Null, Null);
