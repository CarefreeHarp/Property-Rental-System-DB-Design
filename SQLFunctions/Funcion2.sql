create or replace function verify_availability_property (
   property_id varchar2,
   start_date  date,
   end_date    date
) return varchar2 as
   v_start_date date;
   v_end_date   date;
begin
   if start_date > end_date then
      return 'Start date cannot be after end date';
   end if;
   select max(t.start_date)
     into v_start_date
     from tenant t
    where t.property_id = verify_availability_property.property_id;
   select max(tt.end_date)
     into v_end_date
     from tenant tt
    where tt.property_id = verify_availability_property.property_id;
   if
      start_date > v_start_date
      and end_date > v_end_date
      and start_date > v_end_date
   then
      return 'Property is available';
   else
      return 'Property is not available';
   end if;
exception
        when no_data_found then
            return 'Property not found';
        when others then
            return 'An error occurred: ' || sqlerrm;
end;
/


