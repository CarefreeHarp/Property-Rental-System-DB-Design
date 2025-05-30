CREATE OR REPLACE PROCEDURE Recalculate_Update_contract_values (
    p_contract_id IN NUMBER
) AS
    v_property_id       VARCHAR2(10);
    v_client_id         VARCHAR2(10);
    v_base_rent         NUMBER := 0;
    v_total_commission  NUMBER := 0; --El total es en porcentaje
    v_total_tax         NUMBER := 0; --El total es en porcentaje
    v_service_value     NUMBER := 0; --Suma del valor de los servicios adicionales contratados por el cliente
    v_vtp               NUMBER := 0; --Nuevo valor contrato
BEGIN
    -- Obtener cliente y propiedad asociada al contrato
    SELECT client_id, property_id INTO v_client_id, v_property_id
    FROM Contract
    WHERE contract_id = p_contract_id;

    -- Obtener base_rent 
    SELECT base_rent INTO v_base_rent
    FROM Property
    WHERE property_id = v_property_id;

    -- Sumar todas las comisiones (%)
    SELECT NVL(SUM(rate_value), 0)
    INTO v_total_commission
    FROM Additional_Rates
    WHERE rate_type = 'COMMISSION';

    -- Sumar todos los impuestos (%)
    SELECT NVL(SUM(rate_value), 0)
    INTO v_total_tax
    FROM Additional_Rates
    WHERE rate_type = 'TAX';

    -- Calcular valor de servicios adicionales del cliente
    SELECT NVL(SUM(s.num_people * se.person_value), 0)
    INTO v_service_value
    FROM Additional_Service s
    JOIN Service se ON s.service_name = se.service_name
    WHERE s.client_id = v_client_id;

    -- Calcular VTP: base_rent + servicios + % de comisiones e impuestos
    v_vtp := (v_base_rent + v_service_value) * (1 + (v_total_commission + v_total_tax)/100);

    -- Actualizar el contrato con el nuevo valor
    UPDATE Contract
    SET TPV_per_Month = v_vtp
    WHERE contract_id = p_contract_id;

    -- Registrar en auditoría el cambio en TPV_per_Month
    INSERT INTO Control_Changes
    (table_name, record_id, action_type, change_date, column_name, old_value, new_value)
    SELECT 'Contract', contract_id, 'UPDATE', SYSDATE, 'TPV_per_Month',
           TO_CHAR(TPV_per_Month), TO_CHAR(v_vtp)
    FROM Contract
    WHERE contract_id = p_contract_id;

    DBMS_OUTPUT.PUT_LINE('Contrato actualizado. VTP: ' || TO_CHAR(v_vtp, '999,999,990.00'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Contrato, propiedad o cliente no encontrados.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error inesperado: ' || SQLERRM);
END;
