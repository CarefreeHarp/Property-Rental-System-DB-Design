create or replace trigger tgr_max_rent before
   insert on visit
   for each row
declare
   v_max_rent number;
   v_rent     number;
begin
   select a.max_rent
     into v_max_rent
     from account_information a
     join client c
   on a.username = c.username
    where c.client_id = :new.client_id;

   select p.base_rent
     into v_rent
     from property p
    where p.property_id = :new.property_id;

   if v_rent > v_max_rent then
      raise_application_error(
         -20001,
         'Rent exceeds maximum allowed rent for this client.'
      );
   end if;
end;
/

