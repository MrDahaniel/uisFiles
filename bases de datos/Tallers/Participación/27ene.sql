delimiter $$
create procedure donadores (in peso float) begin 
if peso < 50 then
    insert into persona values (peso, "no admitido");
else
    insert into persona values (peso, "admitido");
end if;
end;
$$
delimiter ;

delimiter $$
create procedure insertar_cliente(in cedula bigint, in nombre varchar(30), in apellido varchar(30)) begin
    insert into cliente values (cedula, nombre, apellido);
end;
$$
delimiter ;

delimiter $$
create procedure actualizar_cliente(in cedula_cli bigint, in nombre_nuevo varchar(30),) begin
    update cliente
        set nombre = nombre_nuevo;
        where cedula = cedula_cli;
end;
$$
delimiter ;

delimiter $$
create procedure eliminar_cliente(in cedula_cli bigint) begin
    delete from cliente where cedula = cedula_cli;
end;
$$
delimiter ;

delimiter $$
create procedure ejemplo_out(out var bigint) begin
    set var = 25;
end;
$$
delimiter ;

delimiter $$
create procedure ejemplo_inout(inout var bigint) begin 
if var > 15 then
    set var = 25;
else
    set var = 100;
end if;
end;
$$
delimiter ;

delimiter $$
create function calcular_valor_venta(costo float, por_ganancia int) returns float deterministic begin
declare vventa float default 0;
    set vventa = costo + costo * por_ganancia / 100;
    return vventa;
end;
$$
delimiter ;

delimiter $$
create function calc_sub_transp(salario float) returns float deterministic begin
    return salario*0.07;
end
$$
delimiter ;

delimiter $$
create function calc_bono(salario float) returns float deterministic begin
    return salario*0.08;
end
$$
delimiter ;

delimiter $$
create function calc_salud(salario float) returns float deterministic begin
    return salario*0.04;
end
$$
delimiter ;

delimiter $$
create function calc_pension(salario float) returns float deterministic begin
    return salario*0.04;
end
$$
delimiter ;

delimiter $$
create function sal_int(salario float) returns float deterministic begin
    declare sal_i float default -1;
    sal_i = salario - calc_salud(salario) - calc_pension(salario) + calc_bono(salario) + calc_sub_transp(salario);
    return sal_i;
end
$$
delimiter ;