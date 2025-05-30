CREATE OR REPLACE FUNCTION active_client_request (
    p_client_id IN VARCHAR2
) RETURN NUMBER IS
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Rent_Solicitude
    WHERE client_id = p_client_id;

    IF v_count > 0 THEN
        RETURN 1; -- Tiene solicitud activa
    ELSE
        RETURN 0; -- No tiene solicitud activa
    END IF;
END;
/
