
-- Daniel David Delgado Cervantes 2182066
-- Taller Resumen, procedimientos, funciones y triggers

-- Procedimientos 
-- 1

delimiter $$

create procedure getYear()
begin
    select year(curdate()) as "Year";
end $$

delimiter ;

-- 2

create table users (
    id serial primary key, 
    uName char(50),
    genVar int default 0
);

insert into users (uName) values ("Testy McTestFace");

delimiter $$

create procedure upGenVar(In userId int)
begin
    update users
    set genVar = genVar + 1
    where id = userId;

    select * from users where id = userId;
end $$

delimiter ;

-- 3 

delimiter $$

create procedure firstThree(in coolString char(255))
begin
    select upper(left(coolString, 3)) as "Out";
end $$

delimiter ;

-- 4

delimiter $$

create procedure fakeConcat(in leftString char(255), in rightString char(255))
begin 
    select upper(concat(leftString, rightString)) as "Out";
end $$

delimiter ;

-- 5

delimiter $$ 

create procedure palindromeChecker(in coolString char(255))
begin 
    select if(upper(coolString) = reverse(upper(coolString)), "is palindrome", "not a palindrome") as "is palindrome?";
end $$

delimiter ;

--Funciones
--1

delimiter $$

create function hipotenuseCalculator(a int, b float)
returns float deterministic
begin
    return (sqrt(power(a,2) + power(b,2)));
end $$

delimiter ;

--2

delimiter $$

create function divisible(numb int, divi int)
returns integer deterministic
begin
    declare val int;
    set val = numb % divi;
    if val = 0 then
        return (1);
    else 
        return (0);
    end if;
end $$

delimiter ;

--3

delimiter $$

create function daySelector(dayId int)
returns varchar(15) deterministic
begin
    return (case 
                when dayId = 1 then 'Domingo'
                when dayId = 2 then 'Lunes'
                when dayId = 3 then 'Martes'
                when dayId = 4 then 'Miercoles'
                when dayId = 5 then 'Jueves'
                when dayId = 6 then 'Viernes'
                when dayId = 7 then 'Sábado'
                else null
            end);
end $$

delimiter ;

--4

delimiter $$

create function tripleMax(a float, b float, c float)
returns float deterministic
begin
    return (greatest(a, greatest(b,c)));
end $$

delimiter ;

--Triggers


--1
--Tablas
create table cliente(idCliente serial primary key, 
                    nombre varchar(50), 
                    creationDate date, 
                    cuenta int, 
                    saldo float);

create table nrojos(cliente serial, foreign key(cliente) references cliente(idCliente) on delete cascade,
                    cuenta int, 
                    fecha date, 
                    saldo float);

delimiter $$

create trigger numerosRojos
after update on cliente for each row
begin 
    if cliente.saldo < 0 then 
    insert into nrojos values (cliente.idCliente, cliente.cuenta, curdate(), cliente.saldo);
    end if;
end $$

delimiter ;

--2
--Tablas

create table equipo(idEquipo serial primary key,
                    pg int,
                    pp int,
                    pe int);

create table partido(idPartido serial primary key, 
                    equipoCasa int not null references equipo(idEquipo),
                    equipoVist int not null references equipo(idEquipo),
                    golesCasa int,
                    golesVist int);

delimiter $$

create trigger updateEquipos 
after insert on partido for each row
begin
    if partido.golesCasa > partido.golesVist then
        update equipo set equipo.pg = equipo.pg + 1 where equipo.idEquipo = partido.equipoCasa;
        update equipo set equipo.pp = equipo.pp + 1 where equipo.idEquipo = partido.equipoVist;
    elseif partido.golesVist > partido.golesCasa then
        update equipo set equipo.pp = equipo.pp + 1 where equipo.idEquipo = partido.equipoCasa;
        update equipo set equipo.pg = equipo.pg + 1 where equipo.idEquipo = partido.equipoVist;
    else 
        update equipo set equipo.pe = equipo.pe + 1 where equipo.idEquipo = partido.equipoCasa;
        update equipo set equipo.pe = equipo.pe + 1 where equipo.idEquipo = partido.equipoVist;
    end if;
end $$

delimiter ;

--3
--Tablas

create table noticia(titulo varchar(100), usuario int);
create table logBorrados(tituloNoticia varchar(100), usuario int, fecha date, hora date);

delimiter $$

create trigger logTheNews
after delete on noticia for each row
begin
    insert into logBorrados values (noticia.titulo, noticia.usuario, curdate(), curtime());
end $$

delimiter ;

--4

delimiter $$

create trigger giveBonus
before update on cliente for each row
begin
    if new.saldo - old.saldo > 1000 and year(curdate()) - year(old.creationDate) > 3 then   
        update cliente set old.saldo = old.saldo + 100 where cliente.idCliente = old.idCliente;
    end if;
end $$

delimiter ;