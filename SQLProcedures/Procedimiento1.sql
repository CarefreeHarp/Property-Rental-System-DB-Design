create or replace procedure Register_Rent_Solicitude
(
    idclient in varchar2,
    idproperty in varchar2,
    start_date in date,
    end_date in date 
) as 
    found_ids number;
    todays_date date := sysdate;
    available_property char;
    user_max_rent number;
    preliminary_cost number;
begin
    -- Validate idclient, idproperty, start_date and end_date
    select count(*) into found_ids from client where client_id = idclient;
    if found_ids = 0 then
        raise_application_error(-20001, 'Client does not exist');
    end if;
    select count(*) into found_ids from property where property_id = idproperty;
    if found_ids = 0 then
        raise_application_error(-20002, 'Property does not exist');
    end if;
    if start_date < todays_date then
        raise_application_error(-20003, 'Todays date is after the start date');
    end if;
    if end_date <= start_date then
        raise_application_error(-20003, 'You have to rent a property for at least one day');
    end if;

    -- Validates if a client already has a solicitude
    select count(*) into found_ids from Rent_Solicitude where client_id = idclient;
    if found_ids = 1 then
        raise_application_error(-20001, 'That client already has a rent solicitude');
    end if;

    --Validates if the client's maximum rent is congruent with the property base rent
    select base_rent into preliminary_cost from Property where property_id = idproperty;
    select max_rent into user_max_rent from account_information where
    username = (select username from client where client_id = idclient);
    if user_max_rent < preliminary_cost THEN
        raise_application_error(-20004, 'Client cannot afford this property according to their established maximum rent in their profile');
    end if;

    --Inserts the solicitude into the table
    insert into Rent_Solicitude 
        (client_id, property_id, start_date, end_date, preliminary_cost) 
        values 
        (idclient, idproperty, start_date, end_date, preliminary_cost);

    --Checks is the property is available at the moment and if not, adds the client to the waiting list.
    select available into available_property from Property where property_id = idproperty;
    if available_property = 'N' then
        insert into Waiting_List_Position
            (clients_id, property_id, property_order)
            values
            (idclient, idproperty, NVL((select max(property_order) from Waiting_List_Position where property_id = idproperty),0) + 1);
        DBMS_OUTPUT.PUT_LINE('Property is not available right now, your solicitude was added to the waiting list :D');
    else
        DBMS_OUTPUT.PUT_LINE('Your solicitude was registered successfully, you can now proceed with formalization');
    end if;
    commit;
    
    EXCEPTION
    when no_data_found then
        raise_application_error(-20004, 'No data found in tables'); --When no tuples are registered in the tables
    when others then
        raise_application_error(-20005, 'An unexpected error occurred:');
end;
/