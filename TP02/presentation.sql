select count(*)
from clients join commandes using(code_client)
             join details_commandes using(no_commande)
             join produits using(ref_produit);


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


select cl.pays, 
       co.annee, 
       co.mois, 
       sum(dc.quantite),
       sum(dc.quantite*dc.prix_unitaire)
from clients cl join commandes co using(code_client)
             join details_commandes dc using(no_commande)
group by cl.pays, 
       co.annee, 
       co.mois;             
