--se tuvo que agregar el atributo is_deleted a la tabla property
ALTER TABLE Property ADD is_deleted CHAR(1) DEFAULT 'N' CHECK (is_deleted IN ('Y', 'N'));
