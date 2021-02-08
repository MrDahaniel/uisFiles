
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