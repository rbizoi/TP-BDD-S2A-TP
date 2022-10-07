select count(*) 
from clients cl join fournisseurs fr 
      on cl.ville = fr.ville;

select cl.societe, fr.societe
from clients cl left outer join fournisseurs fr 
      on cl.ville = fr.ville;

select cl.societe, fr.societe
from clients cl right outer join fournisseurs fr 
      on cl.ville = fr.ville;

select cl.societe, fr.societe
from clients cl full outer join fournisseurs fr 
      on cl.ville = fr.ville
where cl.ville is null;

select * from employes 
where salaire between 1000 en 2000;

select * from produits
where code_categorie in (1,5,7);

select annee,trimestre, sum(port) 
from commandes
group by annee,trimestre ;
