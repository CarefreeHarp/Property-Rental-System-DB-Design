CREATE TABLE Control_Changes (
    change_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name    VARCHAR2(50),         -- Nombre de la tabla modificada (ej. 'Client', 'Property')
    record_id     VARCHAR2(10),         -- ID del registro afectado (ej. client_id, property_id)
    action_type   VARCHAR2(10),         -- 'UPDATE', 'INSERT', 'DELETE'
    change_date   DATE DEFAULT SYSDATE, -- Fecha del cambio
    column_name   VARCHAR2(50),         -- Nombre del atributo modificado
    old_value     VARCHAR2(500),        
    new_value     VARCHAR2(500)         
);
