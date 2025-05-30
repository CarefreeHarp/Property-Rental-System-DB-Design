CREATE OR REPLACE TRIGGER prevent_owner_deletion
BEFORE DELETE ON Owner
FOR EACH ROW
DECLARE
    v_not_deleted_props NUMBER;
    v_active_contracts  NUMBER;
BEGIN
    -- Verifica si el dueño tiene propiedades que no esten marcadas como eliminadas
    SELECT COUNT(*) INTO v_not_deleted_props
    FROM Property
    WHERE owner_id = :OLD.owner_id
      AND is_deleted = 'N';  -- << este es el nuevo campo que se requiere

    -- Verifica si sus propiedades tienen contratos vigentes
    SELECT COUNT(*) INTO v_active_contracts
    FROM Property p
    JOIN Contract c ON c.property_id = p.property_id
    WHERE p.owner_id = :OLD.owner_id;

    IF v_not_deleted_props > 0 OR v_active_contracts > 0 THEN
        RAISE_APPLICATION_ERROR(
          'Owner cannot be deleted: non-deleted properties or active contracts exist.');
    END IF;
END;


--se tuvo que agregar el atributo is_deleted a la tabla property
ALTER TABLE Property ADD is_deleted CHAR(1) DEFAULT 'N' CHECK (is_deleted IN ('Y', 'N'));
