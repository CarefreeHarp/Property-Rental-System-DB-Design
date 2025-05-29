CREATE OR REPLACE PROCEDURE update_global_rates (
    p_name         IN VARCHAR2,
    p_new_value    IN NUMBER,
    p_target_table IN VARCHAR2,  -- 'RATE' o 'SERVICE'
    p_unit         IN VARCHAR2 default null,
    p_description  IN VARCHAR2 default null
) AS
BEGIN
    IF p_target_table = 'RATE' THEN

        -- Actualizar Additional_Rates
        UPDATE Additional_Rates
        SET 
            rate_value = p_new_value,
            unit = p_unit,
            description = NVL(p_description, description)
        WHERE rate_name = p_name;

        DBMS_OUTPUT.PUT_LINE('Tarifa "' || p_name || '" actualizada correctamente.');

    ELSIF p_target_table = 'SERVICE' THEN
        -- Actualizar Service
        UPDATE Service
        SET person_value = p_new_value
        WHERE service_name = p_name;


        DBMS_OUTPUT.PUT_LINE('Servicio "' || p_name || '" actualizado correctamente.');

    ELSE
        RAISE_APPLICATION_ERROR(-20004, 'Tabla de destino no válida. Use "RATE" o "SERVICE".');
    END IF;
END;
/
