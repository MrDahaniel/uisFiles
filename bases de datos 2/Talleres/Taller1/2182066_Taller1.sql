--Daniel David Delgado Cervantes 2182066--

--Creating scripts--

create database taller1;

use taller1;

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

insert into componentes(idComp,cNombre,color,peso,ciudad) values ('C1','X3A','ROJO',12,'SEVILLA'), ('C2','B85','VERDE',17,'MADRID'), ('C3','C4B','AZUL',17,'MALAGA'), ('C4','C4B','ROJO',14,'SEVILLA'), ('C5','VT8','AZUL',12,'MADRID'), ('C6','C30','ROJO',19,'SEVILLA');

insert into articulos(idArt,tNombre,ciudad) values ('T1','CLASIFICADORA','MADRID'), ('T2','PERFORADORA','MALAGA'), ('T3','LECTORA','CACERES'), ('T4','CONSOLA','CACERES'), ('T5','MEZCLADORA','SEVILLA'), ('T6','TERMINAL','BARCELONA'), ('T7','CINTA','SEVILLA');

insert into envios (idProv, idComp, idArt, cantidad) values ('P1','C1','T1','200'), ('P2','C3','T1','400'), ('P1','C1','T4','700'), ('P2','C3','T2','200'), ('P2','C3','T3','200'), ('P2','C3','T4','500'), ('P2','C3','T5','600'), ('P2','C3','T6','400'), ('P2','C3','T7','800'), ('P2','C5','T2','100'), ('P3','C3','T1','200'), ('P3','C4','T2','500'), ('P4','C6','T3','300'), ('P4','C6','T7','300'), ('P5','C2','T2','200'), ('P5','C2','T4','100'), ('P5','C5','T4','500'), ('P5','C5','T7','100'), ('P5','C6','T2','200'), ('P5','C1','T4','100'), ('P5','C3','T4','200'), ('P5','C4','T4','800'), ('P5','C5','T5','400'), ('P5','C6','T4','500');

--Ejercicio--

--1
alter table proveedores add PApellido char(10);

--2
alter table proveedores add PCedula int;

--3
alter table proveedores add telefono int;

--4
alter table envios add fecha_envio date;

--5
alter table articulos change tNombre nombre_articulo varchar(15);

--6
alter table componentes change cNombre nombre_componente varchar(5);

--7
alter table proveedores change pNombre nombre_proveedor varchar(15);

--8
alter table proveedores modify PApellido varchar(50);

--9
alter table proveedores modify PCedula int(11);

--10
alter table articulos modify ciudad varchar(20);

--11
alter table proveedores drop telefono;

--12
alter table envios drop fecha_envio;

--13
insert into proveedores(idProv,nombre_proveedor,categoria,ciudad,PApellido,PCedula) values ('P6','STOLAS',40,'BARRANCA','STONE',456872112), ('P7','BAT',50,'SOLEDAD','MAN',1234567885),('P8','MINECRAFT',30,'SAN GIL','STEVE',741589635);

--14
insert into envios(idProv,idComp,idArt,cantidad) values ('P6','C2','T2','400');
insert into envios(idProv,idComp,idArt,cantidad) values ('P7','C3','T3','700');
insert into envios(idProv,idComp,idArt,cantidad) values ('P7','C5','T1','800');

--15 
create table envios_pendientes (
    idProv varchar(5), foreign key (idProv) references proveedores(idProv) on delete cascade,
    idComp varchar(5), foreign key (idComp) references componentes(idComp) on delete cascade,
    idArt varchar(5), foreign key (idArt) references articulos(idArt) on delete cascade,
    cantidad_a_enviar int
);

insert into envios_pendientes (idProv,idComp,idArt,cantidad_a_enviar) values ('P1','C4','T1','200'),('P2','C5','T3','200'),('P5','C2','T4','300');
--Profe no entendí xddd


--16
update proveedores set PApellido='CUADRADO' where idProv='P1';
update proveedores set PApellido='ORTIZ' where idProv='P2';
update proveedores set PApellido='MORA' where idProv='P3';
update proveedores set PApellido='SILVA' where idProv='P4';
update proveedores set PApellido='SANCHEZ' where idProv='P5';
update proveedores set PCedula=floor(rand()*100000000) where PCedula is null;

--17
alter table proveedores add nombre_completo varchar(50);
update proveedores set nombre_completo=concat(nombre_proveedor, ' ', PApellido) where nombre_completo is null;

--18
update envios set cantidad=cantidad+50 where idArt='T7';

--19
delete from componentes where nombre_componente='C4B';