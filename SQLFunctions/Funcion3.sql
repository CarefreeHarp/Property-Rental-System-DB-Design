create or replace function visit_record (
    property_id VARCHAR2,
    start_date  DATE,
    end_date    DATE
) return number AS
v_cuantity_visits number;
begin 
    select count(property_id)
    into v_cuantity_visits
    from visit v
    where v.property_id = visit_record.property_id
    group by v.property_id;
    return v_cuantity_visits;
exception
    when no_data_found then
        return 0;
    when others then
        return -1; 
end;
/

