CREATE OR REPLACE TRIGGER trg_prevenir_eliminacion_dueno
BEFORE DELETE ON Dueno
FOR EACH ROW
DECLARE
    v_propiedades_activas NUMBER;
    v_contratos_futuros NUMBER;
BEGIN
    -- Verificar propiedades activas
    SELECT COUNT(*)
    INTO v_propiedades_activas
    FROM Propiedad
    WHERE id_dueno = :OLD.id_dueno AND estado != 'Eliminada';

    -- Verificar contratos de alquiler futuros
    SELECT COUNT(*)
    INTO v_contratos_futuros
    FROM Contrato c
    JOIN Propiedad p ON c.id_propiedad = p.id_propiedad
    WHERE p.id_dueno = :OLD.id_dueno AND c.fecha_inicio > SYSDATE;

    IF v_propiedades_activas > 0 OR v_contratos_futuros > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar el dueño: posee propiedades activas o contratos futuros.');
    END IF;
END;
/
