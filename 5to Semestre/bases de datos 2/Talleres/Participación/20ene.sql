create database placeholder;

use placeholder;

create table tableholder(
    coolvar char(10)
);

create table tableholder2(
    size integer,
    coolvar char(10)
);

DELIMITER $$
create procedure procedure1(in parameter1 integer)
    begin
        declare variable1 char(10);
        if parameter1 = 17 then
            set variable1 = 'grande';
        else
            set variable1 = 'pequeño';
        end if;
        insert into tableholder values (variable1);
    end
$$
DELIMITER ;

DELIMITER $$
create procedure procedure2(in parameter1 integer)
    begin
        declare variable1 char(10);
        if parameter1 > 10 then
            set class = 'grande';
        else
            if parameter1 > 5 then
                set class = 'mediano';
            else
                set class = 'pequeño';
            end if;
        end if;
        insert into tableholder2 values (parameter1, class);
    end
$$
DELIMITER ;