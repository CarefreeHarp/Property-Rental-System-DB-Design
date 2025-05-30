--se tuvo que agregar el atributo is_deleted a la tabla property
ALTER TABLE Property ADD is_deleted CHAR(1) DEFAULT 'N' CHECK (is_deleted IN ('Y', 'N'));

INSERT INTO Property (
    property_id,
    owner_id,
    num_rooms,
    location,
    description,
    available,
    type,
    address,
    base_rent,
    availability_date,
    is_deleted
) VALUES (
    'P123',
    'O123',
    3,
    'Bogotá',
    'Apartamento en zona norte con excelente vista y parqueadero',
    'Y',
    'Apartamento',
    'Cra 45 #123-45',
    850.00,
    SYSDATE,
    'N'
);
