create or replace function Calculate_TPV_per_Month
(
    idclient in varchar2,
    idproperty in varchar2

) return number as
    TPV_per_Month NUMBER(8,2);
    sum_of_services number(8,2);
begin

    -- Saves the property's base rent in  TPV_per_Month
    select base_rent into TPV_per_Month from Property where property_id = idproperty;

    -- Adds the additional services that the client picked to TPV_per_Month
    select NVL(sum(value),0) into sum_of_services from ADDITIONAL_SERVICE where client_id = idclient;
    TPV_per_Month := TPV_per_Month + sum_of_services;


    return TPV_per_Month;

exception
    when no_data_found then
        raise_application_error(-20004, 'No data found in tables'); --When no tuples are registered in the tables
    when others then
        raise_application_error(-20005, 'An unexpected error occurred:');
end;
/