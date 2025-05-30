create or replace trigger TGR_DISCOUNT before
   update or insert on contract
   for each row
declare
   v_discount_value number;
   v_discount_type  varchar2(20);
begin
   if inserting then
      select discount,
             discount_type
        into
         v_discount_value,
         v_discount_type
        from property
       where property_id = :new.property_id;

      if
         v_discount_value > 0
         and v_discount_type = 'PERCENTAGE'
      then
         :new.tpv_per_month := :new.tpv_per_month - ( :new.tpv_per_month * v_discount_value );
      elsif
         v_discount_value > 0
         and v_discount_type = 'VALUE'
      then
         :new.tpv_per_month := :new.tpv_per_month - v_discount_value;
      end if;
   end if;
   if updating('PROPERTY_ID') or UPDATING('TPV_PER_MONTH') then
      select discount,
             discount_type
        into
         v_discount_value,
         v_discount_type
        from property
       where property_id = :new.property_id;
      if
         v_discount_value > 0
         and v_discount_type = 'PERCENTAGE'
      then
         :new.tpv_per_month := calculate_tpv_per_month(
            :new.client_id,
            :new.property_id
         ) - ( calculate_tpv_per_month(
            :new.client_id,
            :new.property_id
         ) * v_discount_value );
      elsif
         v_discount_value > 0
         and v_discount_type = 'VALUE'
      then
         :new.tpv_per_month := calculate_tpv_per_month(
            :new.client_id,
            :new.property_id
         ) - v_discount_value;
      end if;
   end if;
end;
/