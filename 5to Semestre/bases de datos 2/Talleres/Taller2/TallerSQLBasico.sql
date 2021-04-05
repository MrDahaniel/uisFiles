--Taller SQL básico 
--Daniel David Delgado Cervantes 2182066

--Creación de tablas
create database SQLBasico;
use SQLBasico;

create table departamentos (
    codDepto varchar(4) primary key,
    nombreDpto varchar(20),
    ciudad varchar(15),
    codDirector varchar(12)
);

create table empleados (
    nDIEmp varchar(12) primary key,
    nomEmp varchar(30),
    sexEmp char(1),
    fecNac date,
    fecIncorporacion date,
    salEmp float,
    comisionE float, 
    cargoE varchar(15),
    jefeID varchar(12),
    codDepto varchar(4), foreign key(codDepto) references departamentos(codDepto) on delete cascade  
);

-- 1 --
select * from empleados order by nDIemp;

-- 2 --
select * from departamentos order by codDepto;

-- 3 --
select * from empleados where cargoE = "Secretaria" order by nDIEmp;

-- 4 --
select nomEmp as "Nombre", salEmp as "Salario" from empleados order by nDIEmp;

-- 5 --
select * from empleados order by nomEmp;

-- 6 --
select nombreDpto from departamentos;

-- 7 --
select nomEmp as "Nombre", cargoE as "Cargo" from empleados order by salEmp;

-- 8 -- 
select salEmp as "Salario", comisionE as "Comisión" from empleados where codDepto = "2000";

-- 9 --
select comisionE from empleados;

-- 10 --
select count(nDIEmp)*500000 as "Costo bonos" from empleados where codDepto = "3000";

-- 11 --
select nDIEmp as "ID", nomEmp as "Nombre Empleado" from empleados where salEmp < comisionE; 

-- 12 --
select nDIEmp as "ID", nomEmp as "Nombre Empleado" from empleados where salEmp*0.3 >= comisionE; 

-- 13 --
select  concat("Nombre: ", nomEmp) as "Nombre", concat("Cargo: ", cargoE) from empleados;

-- 14 --
select salEmp as "Salario", comisionE as "Comisión" from empleados where cast(nDIEmp as int) > 19709802;

-- 15 --
select * from empleados where nomEmp between 'J%' and 'Z%';

-- 16 --
select salEmp as "Salario", comisionE as "Comisión", salEmp+comisionE as "Salario total", nDIEmp as "Identifición " from empleados where "Comisión" > 1000000 order by "Identifición";

-- 17 --
select salEmp as "Salario", comisionE as "Comisión", salEmp+comisionE as "Salario total", nDIEmp as "Identifición " from empleados where ("Comisión" = 0 or "Comisión" is null) order by "Identifición";

-- 18 --
select * from empleados where nomEmp not like '%ma%';

-- 19 --
select nombreDpto from departamentos where not(nombreDpto = “Ventas” or nombreDpto = “Investigación” or nombreDpto = “MANTENIMIENTO”);

-- 20 --
select emp.nomEmp as Nombre, dep.nombreDpto as Departamento from empleados as emp, departamentos as dep where (not (Departamento = "PRODUCCION")) and (dep.salEmp > 1000000) order by fecIncorporacion;  
