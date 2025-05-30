CREATE OR REPLACE PROCEDURE Manage_Additional_Services (
    p_client_id     IN VARCHAR2,
    p_contract_id   IN NUMBER,
    p_service_name  IN VARCHAR2,
    p_num_people    IN NUMBER,
    p_action        IN VARCHAR2
) IS
    v_person_value Service.person_value%TYPE;
    v_value NUMBER;
    v_base_rent Property.base_rent%TYPE;
    v_total_services NUMBER := 0;
    v_property_id Property.property_id%TYPE;
BEGIN
    IF p_action = 'ADD' THEN
        SELECT person_value INTO v_person_value FROM Service WHERE service_name = p_service_name;
        v_value := v_person_value * p_num_people;
        INSERT INTO Additional_Service (client_id, service_name, num_people, value)
        VALUES (p_client_id, p_service_name, p_num_people, v_value);

    ELSIF p_action = 'UPDATE' THEN
        SELECT person_value INTO v_person_value FROM Service WHERE service_name = p_service_name;
        v_value := v_person_value * p_num_people;
        UPDATE Additional_Service 
        SET num_people = p_num_people, value = v_value
        WHERE client_id = p_client_id AND service_name = p_service_name;

    ELSIF p_action = 'DELETE' THEN
        DELETE FROM Additional_Service 
        WHERE client_id = p_client_id AND service_name = p_service_name;

    END IF;

    -- Obtener la propiedad desde el contrato
    SELECT property_id INTO v_property_id
    FROM Contract
    WHERE contract_id = p_contract_id;

    -- Actualizar contrato
    UPDATE Contract
    SET TPV_per_Month = Calculate_TPV(p_client_id, v_property_id)
    WHERE contract_id = p_contract_id;

    DBMS_OUTPUT.PUT_LINE('Contract updated successfully. New TPV: ' || (v_base_rent + v_total_services));
END;
/
