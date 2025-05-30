create or replace function Calculate_TPV_per_Month
(
    idclient in varchar2,
    idproperty in varchar2

) return number as
    TPV_per_Month NUMBER(10,4);
    TAX_Cost NUMBER(10,4);
    Commissions_Cost NUMBER(10,4);
    sum_of_services number(10,4);
    sum_of_additional_rates number(10,4);
begin

    -- Saves the property's base rent in  TPV_per_Month
    select base_rent into TPV_per_Month from Property where property_id = idproperty;

    -- Adds the additional services that the client picked to TPV_per_Month
    select NVL(sum(value),0) into sum_of_services from ADDITIONAL_SERVICE where client_id = idclient;

    -- Saves the tax total cost that applies to the property
    select 1+NVL(SUM(rate_value/100) , 0) into TAX_cost from additional_rates where rate_type = 'TAX';
    TAX_cost := TPV_per_Month * TAX_cost - TPV_per_Month;
    DBMS_OUTPUT.PUT_LINE('The total taxes cost that applies to the property is: ' || TAX_cost);



    -- Saves the commissions total cost that applies to the property
    select 1+NVL(SUM(rate_value/100) , 0) into Commissions_Cost from additional_rates where rate_type = 'COMMISSION';
    Commissions_Cost := TPV_per_Month * Commissions_Cost - TPV_per_Month;
    DBMS_OUTPUT.PUT_LINE('The total commissions cost that applies to the property is: ' || Commissions_Cost);

    -- Adds the commissions, services and taxes cost to TPV_per_Month
    TPV_per_Month := TPV_per_Month + TAX_Cost + Commissions_Cost;
    TPV_per_Month := TPV_per_Month + sum_of_services;

    return TPV_per_Month;

exception
    when no_data_found then
        raise_application_error(-20004, 'No data found in tables'); --When no tuples are registered in the tables
    when others then
        raise_application_error(-20005, 'An unexpected error occurred:');
end;
/