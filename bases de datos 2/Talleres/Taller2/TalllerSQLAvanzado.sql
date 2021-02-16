--Taller SQL Avanzado 
--Daniel David Delgado Cervantes 2182066

--Creación de tablas
create database SQLAvanzado;
use SQLAvanzado;

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
select * from empleados where length(nomEmp) = 11;

-- 2 --
select * from empleados where length(nomEmp) <= 11;

-- 3 --
select emp.* from empleados as emp, departamentos as dep
    where dep.codDepto = emp.codDepto and
        and ((emp.nomEmp like 'M%') or (emp.nomEmp like 'm%'))
        and ((emp.salEmp > 800000) or (not(emp.omisionE is null) or (emp.omisionE > 0)))
        and dep.nombreDpto = "VENTAS";

-- 4 --
select nomEmp, salEmp, comisionE from empleados where salEmp between comisionE/2 and comisionE;

-- 5 --
select * from empleados where max(salEmp);

-- 6 --
select comisionE as "comision", count(*) as "Numero empleados" where ("comision" > 0 or not "comision" is null) group by "comision";

-- 7 --
select nomEmp from empleados order by nomEmp desc limit 1;

-- 8 --
select max(salEmp), min(salEmp), max(salEmp)-min(salEmp) from empleados;

-- 9 --
select dep.nombreDpto as "Departamento", sexEmp, count(emp.sexEmp) from empleados as emp, departamentos as dep group by "Departamento", emp.sexEmp; 

-- 10 --
select dep.nombreDpto, avg(emp.salEmp) from empleados as emp, departamentos as dep 
    where dep.codDepto = emp.codDepto 
    group by dep.nombreDpto;

-- 11 --
select emp.* from empleados as emp, departamentos as dep 
    where dep.codDepto = emp.codDepto
        and emp.salEmp >= avg(emp.salEmp) 
    order by dep.nombreDpto;

-- 12 --
select dep.nombreDpto, count(emp.*) as "numeroEmpleados" from empleados as emp, departamentos as dep 
    where dep.codDepto = emp.codDepto 
    group by dep.nombreDpto
    having "numeroEmpleados" > 3;

-- 13 --
select a.nDIEmp, a.nomEmp, count(*) as "numeroEmpleados" from empleados as a, empleados as b
    where a.jefeID = b.nDIEmp
    group by a.nDIEmp
    having "numeroEmpleados" > 1;

-- 14 --
select dep.nombreDpto as "Departamento" from empleados as emp, departamentos as dep 
    where dep.codDepto = emp.codDepto 
    group by "Departamento"
    having "Departamento" = 0;

-- 15 --
select dep.nombreDpto as "Departamento", sum(emp.salEmp) as "Salario" from empleados as emp, departamentos as dep 
    where dep.codDepto = emp.codDepto 
    group by "Departamento"
    order by "Salario" desc limit 1;
