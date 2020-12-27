--Daniel David Delgado Cervantes 2182066--

--Creating scripts--

create database taller2;

use taller2;

create table proveedores (
    idProv varchar(5) primary key,
    pNombre varchar(15),
    categoria int, 
    ciudad varchar(10)
);

create table componentes (
    idComp varchar(5) primary key,
    cNombre varchar(5),
    color varchar(10),
    peso int, 
    ciudad varchar(10)
);

create table articulos (
    idArt varchar(5) primary key,
    tNombre varchar(15),
    ciudad varchar(10)
);

create table envios (
    idProv varchar(5), foreign key(idProv) references proveedores(idProv) on delete cascade,
    idComp varchar(5), foreign key(idComp) references componentes(idComp) on delete cascade,
    idArt varchar(5), foreign key(idArt) references articulos(idArt) on delete cascade,
    cantidad int
);

--Filling tables--

insert into proveedores(idProv,pNombre,categoria,ciudad) values ('P1','CARLOS',20, 'SEVILLA'), ('P2','JUAN',10,'MADRID'), ('P3','JOSE',30,'SEVILLA'), ('P4','INMA',20,'SEVILLA'), ('P5','EVA',30,'CACERES');

insert into componentes(idComp,cNombre, color,peso,ciudad) values ('C1','X3A','ROJO',12,'SEVILLA'), ('C2','B85','VERDE',17,'MADRID'), ('C3','C4B','AZUL',17,'MALAGA'), ('C4','C4B','ROJO',14,'SEVILLA'), ('C5','VT8','AZUL',12,'MADRID'), ('C6','C30','ROJO',19,'SEVILLA');

insert into articulos(idArt,tNombre,ciudad) values ('T1','CLASIFICADORA','MADRID'), ('T2','PERFORADORA','MALAGA'), ('T3','LECTORA','CACERES'), ('T4','CONSOLA','CACERES'), ('T5','MEZCLADORA','SEVILLA'), ('T6','TERMINAL','BARCELONA'), ('T7','CINTA','SEVILLA');

insert into envios (idProv, idComp, idArt, cantidad) values ('P1','C1','T1','200'), ('P2','C3','T1','400'), ('P1','C1','T4','700'), ('P2','C3','T2','200'), ('P2','C3','T3','200'), ('P2','C3','T4','500'), ('P2','C3','T5','600'), ('P2','C3','T6','400'), ('P2','C3','T7','800'), ('P2','C5','T2','100'), ('P3','C3','T1','200'), ('P3','C4','T2','500'), ('P4','C6','T3','300'), ('P4','C6','T7','300'), ('P5','C2','T2','200'), ('P5','C2','T4','100'), ('P5','C5','T4','500'), ('P5','C5','T7','100'), ('P5','C6','T2','200'), ('P5','C1','T4','100'), ('P5','C3','T4','200'), ('P5','C4','T4','800'), ('P5','C5','T5','400'), ('P5','C6','T4','500');

--Ejercicio--

--1
select * from articulos where upper(ciudad) = "CACERES";

--2
select * from proveedores as p
inner join articulos as a on a.ciudad = p.ciudad
where a.idArt = 'T1';

--3
select distinct color, ciudad from componentes;

--4
select idArt, ciudad from articulos 
where upper(ciudad) like "%D" and upper(ciudad) like "%E%";

--5
select distinct idProv from envios
where idArt = "T1" and idComp = "C1";

--6
select a.tNombre from articulos as a 
inner join envios as e on e.idArt = a.idArt
where e.idProv = "P1"
order by asc;

--7
select distinct e.idComp from envios as e 
inner join articulos as a on e.idArt = a.idArt
where upper(a.ciudad) = "MADRID";

--8
-------------------------------SKIP-------------------------------

--9
select distinct idProv from envios 
where idArt = "T2" and idArt = "T1";

--10
select distinct e.idProv from envios as e
inner join articulos as a on a.idArt = e.idArt
inner join componentes as c on c.idComp = e.idComp
where (upper(a.ciudad) = "SEVILLA" or upper(a.ciudad) = "MADRID") and upper(c.color) = "ROJO";

--11
-------------------------------SKIP-------------------------------

--12
select distinct idArt from envios as e
where idProv = "P1";

--13
select distinct p.ciudad, e.idComp, a.ciudad from envios as e
inner join proveedores as p on p.idProv = e.idProv
inner join articulos as a on a.idArt = e.idArt
order by p.ciudad, e.idComp, a.ciudad asc;

--14
select distinct p.ciudad, e.idComp, a.ciudad from envios as e
inner join proveedores as p on p.idProv = e.idProv
inner join articulos as a on a.idArt = e.idArt
where p.ciudad != a.ciudad
order by p.ciudad, e.idComp, a.ciudad asc;

--15
-------------------------------SKIP-------------------------------

--16
select idComp, idArt, sum(cantidad) from envios
group by idComp, idArt
order by idComp, idArt;

--17
select distinct idArt from envios
where idArt not in(
    select e.idArt from envios as e
    inner join proveedores as p on p.idProv = e.idProv
    inner join articulos as a on a.idArt = e.idArt
    where p.ciudad = "MADRID" and p.ciudad = a.ciudad);

--18
select distinct e.idProv from envios as e 
inner join componentes as c on c.idComp = e.idComp
where c.color = "ROJO";

--19
select distinct idArt from envios
group by idArt, idComp
having sum(cantidad)/count(cantidad) > 320
order by idArt asc;

--20
select distinct idProv from envios
group by idComp
having sum(cantidad)/count(cantidad) < sum(cantidad)
order by idProv asc;

--21
select idComp from envios
where idProv = "P2" and idArt = "T2";

--22
