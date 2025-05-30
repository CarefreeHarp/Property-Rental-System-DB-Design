CREATE OR REPLACE TRIGGER prevent_owner_deletion
BEFORE DELETE ON Owner
FOR EACH ROW
DECLARE
    v_prop_count   NUMBER;
    v_contract_count NUMBER;
BEGIN
    -- Verifica si el dueño tiene propiedades activas
    SELECT COUNT(*) INTO v_prop_count
    FROM Property
    WHERE owner_id = :OLD.owner_id
      AND available = 'Y';

    -- Verifica si sus propiedades tienen contratos
    SELECT COUNT(*) INTO v_contract_count
    FROM Contract c
    JOIN Property p ON c.property_id = p.property_id
    WHERE p.owner_id = :OLD.owner_id;

    IF v_prop_count > 0 OR v_contract_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002,
          'Owner cannot be deleted: active properties or contracts exist.');
    END IF;
END;
