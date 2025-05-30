create or replace trigger trigger_verificar_fecha
before insert or update on contract 
for each ROW
declare v_fecha_inicio date;
      v_fecha_fin date;
      v_fecha_tenant_start date;
      v_fecha_tenant_end date;
      v_availability_property date;
begin
v_fecha_inicio := :new.start_date;
v_fecha_fin := :new.end_date;

select p.availability_date, 
       t.start_date, 
       t.end_date
into v_availability_property,
       v_fecha_tenant_start,
       v_fecha_tenant_end
from property p join tenant t 
on p.property_id = t.property_id
where p.property_id = :new.property_id;

if v_fecha_inicio > v_fecha_fin then
    raise_application_error(-20001, 'La fecha de inicio no puede ser posterior a la fecha de fin.');
end if;
if v_availability_property <> v_fecha_fin then
    raise_application_error(-20002, 'La fecha de fin debe coincidir con la fecha de disponibilidad de la propiedad.');
end if;
if v_fecha_tenant_start <> v_fecha_inicio or v_fecha_tenant_end <> v_fecha_fin then
    raise_application_error(-20003, 'Las fechas de inicio y fin deben coincidir con las fechas del inquilino.');
end if;
end;
/