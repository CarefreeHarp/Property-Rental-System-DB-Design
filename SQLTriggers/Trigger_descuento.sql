create or replace trigger discount before
   update or insert on contract
   for each row
declare
   v_discount_value number;
   v_discount_type varchar;
begin

    select discount
      into v_discount_value
      from property p 
     where p.property_id = :new.property_id;

     select discount
      into v_discount_type
      from property p 
     where p.property_id = :new.property_id;
    if v_discount_value > 0 AND v_discount_type = 'PERCENTAGE'
    then :new.TPV_PER_MONTH := :new.TPV_PER_MONTH - (:new.TPV_PER_MONTH * v_discount_value);
    elsif v_discount_value > 0 AND v_discount_type = 'VALUE'
    then :new.TPV_PER_MONTH := :new.TPV_PER_MONTH - v_discount_value;
    end if;
    end;
/
