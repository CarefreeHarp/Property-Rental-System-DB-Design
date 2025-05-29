--Trigger 4 auditoria Cliente
CREATE OR REPLACE TRIGGER trg_audit_client_
AFTER INSERT OR UPDATE OR DELETE ON Client
FOR EACH ROW
BEGIN
    -- INSERT
    IF INSERTING THEN
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value)
          VALUES ('Client', :NEW.client_id, 'INSERT', SYSDATE, 'username', NULL, :NEW.username);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value)
        VALUES ('Client', :NEW.client_id, 'INSERT', SYSDATE, 'id_type', NULL, :NEW.id_type);

    -- DELETE
    ELSIF DELETING THEN
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Client', :OLD.client_id, 'DELETE', SYSDATE, 'username', :OLD.username, NULL);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Client', :OLD.client_id, 'DELETE', SYSDATE, 'id_type', :OLD.id_type, NULL);

    -- UPDATE
    ELSIF UPDATING THEN
        IF :OLD.username != :NEW.username THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Client', :OLD.client_id, 'UPDATE', SYSDATE, 'username', :OLD.username, :NEW.username);
        END IF;

        IF :OLD.id_type != :NEW.id_type THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Client', :OLD.client_id, 'UPDATE', SYSDATE, 'id_type', :OLD.id_type, :NEW.id_type);
        END IF;
    END IF;
END;   
/

--Trigger 5 Auditoria Property 
CREATE OR REPLACE TRIGGER trg_audit_property_
AFTER INSERT OR UPDATE OR DELETE ON Property
FOR EACH ROW
BEGIN
    -- INSERT
    IF INSERTING THEN
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :NEW.property_id, 'INSERT', SYSDATE, 'num_rooms', NULL, TO_CHAR(:NEW.num_rooms));
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :NEW.property_id, 'INSERT', SYSDATE, 'description', NULL, :NEW.description);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :NEW.property_id, 'INSERT', SYSDATE, 'available', NULL, :NEW.available);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :NEW.property_id, 'INSERT', SYSDATE, 'base_rent', NULL, TO_CHAR(:NEW.base_rent));
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :NEW.property_id, 'INSERT', SYSDATE, 'availability_date', NULL, TO_CHAR(:NEW.availability_date, 'DD-MM-YYYY'));
    
    -- DELETE
    ELSIF DELETING THEN
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'DELETE', SYSDATE, 'num_rooms', TO_CHAR(:OLD.num_rooms), NULL);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'DELETE', SYSDATE, 'description', :OLD.description, NULL);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'DELETE', SYSDATE, 'available', :OLD.available, NULL);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'DELETE', SYSDATE, 'base_rent', TO_CHAR(:OLD.base_rent), NULL);
        INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'DELETE', SYSDATE, 'availability_date', TO_CHAR(:OLD.availability_date, 'DD-MM-YYYY'), NULL);

    -- UPDATE
    ELSIF UPDATING THEN
        IF :OLD.num_rooms != :NEW.num_rooms THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'UPDATE', SYSDATE, 'num_rooms', TO_CHAR(:OLD.num_rooms), TO_CHAR(:NEW.num_rooms));
        END IF;
        IF :OLD.description != :NEW.description THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'UPDATE', SYSDATE, 'description', :OLD.description, :NEW.description);
        END IF;
        IF :OLD.available != :NEW.available THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'UPDATE', SYSDATE, 'available', :OLD.available, :NEW.available);
        END IF;
        IF :OLD.base_rent != :NEW.base_rent THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'UPDATE', SYSDATE, 'base_rent', TO_CHAR(:OLD.base_rent), TO_CHAR(:NEW.base_rent));
        END IF;
        IF :OLD.availability_date != :NEW.availability_date THEN
            INSERT INTO Control_Changes ( table_name, record_id, action_type, change_date, column_name, old_value, new_value) VALUES ('Property', :OLD.property_id, 'UPDATE', SYSDATE, 'availability_date', TO_CHAR(:OLD.availability_date, 'DD-MM-YYYY'), TO_CHAR(:NEW.availability_date, 'DD-MM-YYYY'));
        END IF;
    END IF;
END;
/
