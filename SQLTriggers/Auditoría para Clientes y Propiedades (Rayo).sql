--para cliente:
CREATE OR REPLACE TRIGGER trg_auditoria_cliente
AFTER INSERT OR UPDATE OR DELETE ON Cliente
FOR EACH ROW
DECLARE
    v_detalle CLOB;
BEGIN
    IF INSERTING THEN
        v_detalle := 'Nuevo cliente: ' || :NEW.nombre;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Cliente', :NEW.id_cliente, 'INSERT', USER, v_detalle);
    ELSIF UPDATING THEN
        v_detalle := 'Cliente actualizado. Antes: ' || :OLD.nombre || ', Después: ' || :NEW.nombre;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Cliente', :NEW.id_cliente, 'UPDATE', USER, v_detalle);
    ELSIF DELETING THEN
        v_detalle := 'Cliente eliminado: ' || :OLD.nombre;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Cliente', :OLD.id_cliente, 'DELETE', USER, v_detalle);
    END IF;
END;
/


--para propiedad:
CREATE OR REPLACE TRIGGER trg_auditoria_propiedad
AFTER INSERT OR UPDATE OR DELETE ON Propiedad
FOR EACH ROW
DECLARE
    v_detalle CLOB;
BEGIN
    IF INSERTING THEN
        v_detalle := 'Nueva propiedad: ' || :NEW.direccion;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Propiedad', :NEW.id_propiedad, 'INSERT', USER, v_detalle);
    ELSIF UPDATING THEN
        v_detalle := 'Propiedad actualizada. Antes: ' || :OLD.direccion || ', Después: ' || :NEW.direccion;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Propiedad', :NEW.id_propiedad, 'UPDATE', USER, v_detalle);
    ELSIF DELETING THEN
        v_detalle := 'Propiedad eliminada: ' || :OLD.direccion;
        INSERT INTO Control_Cambios (tabla_afectada, id_registro, accion, usuario, detalle_cambio)
        VALUES ('Propiedad', :OLD.id_propiedad, 'DELETE', USER, v_detalle);
    END IF;
END;
/


