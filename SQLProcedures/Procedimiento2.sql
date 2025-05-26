create or replace procedure Rent_Formalization
(
    idclient in varchar2
) as
    idcontract VARCHAR2(10);
    idproperty VARCHAR2(10);
    TPV_per_Month NUMBER(8,2);
    found_ids NUMBER;
    position NUMBER;
    sum_of_services number(8,2);
begin
    -- Validates if the client has a rent solicitude
    select count(*) into found_ids from rent_solicitude where client_id = idclient;
    select property_id into idproperty from rent_solicitude where client_id = idclient;
    if found_ids = 0 then
        raise_application_error(-20001, 'That client does not have a rent solicitude');
    end if;
    
    --Validates the existence of the client in the waiting list
    select count(*) into found_ids from WAITING_LIST_POSITION where clients_id = idclient;
    select property_order into position from WAITING_LIST_POSITION where clients_id = idclient;
    if found_ids = 0 then
        raise_application_error(-20002, 'That client achieved the first position in the waiting list but their time there has expired');
    elsif position > 1 then
        raise_application_error(-20003, 'That client is in the ' || position || '° position, they will have to wait more time in order to formalize the rent and sign the contract');
    end if;

    --Updates availableness of the property
    update property set available = 'N' where property_id = idproperty;

    --Calculates the contract's Total Payment Value including the additional services that the client picked
    TPV_per_Month := Calculate_TPV_per_Month(idclient, idproperty);

    --Creates the contract
    insert into contract (client_id, property_id, TPV_per_Month) values (idclient, idproperty, TPV_per_Month);

    EXCEPTION
    when no_data_found then
        raise_application_error(-20004, 'No data found in tables'); -- When no tuples are registered in the tables
    when others then
        raise_application_error(-20005, 'An unexpected error occurred:');
end;
/
