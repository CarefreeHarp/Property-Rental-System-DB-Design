create or replace trigger Update_Rent_Availableness after
   insert or delete on contract
   for each row
begin
   if inserting then
      update property
         set
         available = 'N'
       where property_id = :new.property_id;
   elsif deleting then
      update property
         set
         available = 'Y'
       where property_id = :old.property_id;
   end if;
end;
/