--Daniel David Delgado 2182066
--Participación 9 dec

-- Id y nombre de los clientes que hayan comprado todos los productos

select v.id_cliente, c.nombre
from ventas as v 
inner join cliente as c on c.id_cliente = v.id_cliente
group by v.id_cliente
having count(distinct v.id_producto) = (select count(id_producto) from producto)
 
 -- Id, nombre de cada cliente y la suma total (suma de cantidad) de los productos que ha comprado.

 select c.id_cliente, c.nombre, sum(v.cantidad) as "cantidad"
 from ventas as v
 inner join cliente as c on c.id_cliente = v.id_cliente
 group by v.id_cliente
 order by "cantidad";
 
 -- Id de los productos que no han sido comprados por clientes de Tunja.

select id_producto 
from producto
where not in (select *
    from ventas as v 
    inner join cliente as c on c.id_cliente = v.id_cliente
    where c.ciudad = "Tunja");

--Nombre de las ciudades en las que se han vendido todos los productos.

select c.ciudad
from ventas as v 
inner join cliente as c on c.id_cliente = v.id_cliente
group by c.ciudad
having count(distinct v.id_producto) = (select count(id_producto) from producto)