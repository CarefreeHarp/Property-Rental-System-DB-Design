CREATE TABLE Account_Information (
    Username VARCHAR2(20) PRIMARY KEY,
    max_rent NUMBER(7,2) DEFAULT 0 NOT NULL CHECK (max_rent >= 0),
    type VARCHAR2(6) DEFAULT '-' NOT NULL CHECK (type IN ('CLIENT','OWNER')),
    creation_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    name VARCHAR2(30) DEFAULT '-' NOT NULL,
    lastname VARCHAR2(30) DEFAULT '-' NOT NULL,
    in_deleting CHAR(1) DEFAULT 'N' NOT NULL CHECK (in_deleting IN ('Y', 'N'))
);

CREATE TABLE Account_Credential (
    Username VARCHAR2(20) PRIMARY KEY,
    email VARCHAR2(30) DEFAULT '-' NOT NULL,
    password VARCHAR2(30) DEFAULT '-' NOT NULL,
    CONSTRAINT unique_email UNIQUE (email)
);

CREATE TABLE Owner (
    owner_id VARCHAR2(10) PRIMARY KEY,
    username VARCHAR2(20) DEFAULT '-' NOT NULL,
    id_type VARCHAR2(2) DEFAULT 'CC' NOT NULL CHECK (id_type IN ('CC', 'TI', 'CE')),
    FOREIGN KEY (username) REFERENCES Account_Information(Username) ON DELETE CASCADE
);

CREATE TABLE Client (
    client_id VARCHAR2(10) PRIMARY KEY,
    username VARCHAR2(20) DEFAULT '-' NOT NULL,
    id_type VARCHAR2(2) DEFAULT 'CC' NOT NULL CHECK (id_type IN ('CC', 'TI', 'CE')),
    FOREIGN KEY (username) REFERENCES Account_Information(Username) ON DELETE CASCADE
);

CREATE TABLE Property (
    property_id VARCHAR2(10) PRIMARY KEY,
    owner_id VARCHAR2(10) DEFAULT '-' NOT NULL,
    num_rooms NUMBER(2) DEFAULT 1 NOT NULL CHECK (num_rooms > 1 and num_rooms < 99 ),
    location VARCHAR2(100) DEFAULT '-' NOT NULL,
    description VARCHAR2(500) DEFAULT '-' NOT NULL,
    available CHAR(1) DEFAULT 'N' NOT NULL CHECK (available IN ('Y', 'N')),
    type VARCHAR2(11) DEFAULT '-' NOT NULL CHECK (type IN ('Casa', 'Apartamento')),
    address VARCHAR2(30) DEFAULT '-' NOT NULL,
    base_rent NUMBER(7,2) DEFAULT 0 NOT NULL CHECK (base_rent >= 0),
    availability_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    discount NUMBER(10,5) DEFAULT 0 NOT NULL CHECK (discount >= 0),
    discount_type VARCHAR2(10) DEFAULT '-' NOT NULL CHECK (discount_type IN ('PERCENTAGE', 'VALUE')), 
    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id) ON DELETE CASCADE,
    CONSTRAINT unique_address UNIQUE (address)
);

CREATE TABLE Tenant (
    client_id VARCHAR2(10) NOT NULL,
    property_id VARCHAR2(10) NOT NULL,
    start_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    end_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    PRIMARY KEY (client_id, start_date),
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE
);

CREATE TABLE Visit (
    property_id VARCHAR2(10) NOT NULL,
    client_id VARCHAR2(10) NOT NULL,
    start_time DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    duration NUMBER(6,2) DEFAULT 0 NOT NULL CHECK (duration >= 0),
    end_time DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    PRIMARY KEY (property_id, client_id, start_time),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

CREATE TABLE Service (
    service_name VARCHAR2(50) PRIMARY KEY,
    person_value NUMBER(7,2) DEFAULT 0 NOT NULL CHECK (person_value >= 0)
);

CREATE TABLE Payment (
    payment_id VARCHAR2(10) PRIMARY KEY,
    client_id VARCHAR2(10) DEFAULT '-' NOT NULL,
    value NUMBER(8,2) DEFAULT 0 NOT NULL CHECK (value > 0),
    email VARCHAR2(30) DEFAULT '-' NOT NULL,
    cash_used CHAR(1) DEFAULT 'N' NOT NULL CHECK (cash_used IN ('Y', 'N')),
    cash_value NUMBER(8,2) DEFAULT NULL CHECK (cash_value >= 0),
    payment_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    contract_id VARCHAR2(10) DEFAULT '-' NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);


CREATE TABLE Card (
    payment_id VARCHAR2(10) PRIMARY KEY,
    card_number VARCHAR2(19) DEFAULT '0-0-0-0' NOT NULL,
    card_owner VARCHAR2(60) DEFAULT '-' NOT NULL,
    type VARCHAR2(10) DEFAULT '-' NOT NULL CHECK (type IN ('Visa', 'MasterCard')),
    expiration_year VARCHAR2(2) DEFAULT '0' NOT NULL,
    expiration_month VARCHAR2(2) DEFAULT '0' NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id) ON DELETE CASCADE
);

CREATE TABLE Coupon (
    coupon_number VARCHAR2(10) PRIMARY KEY,
    payment_id VARCHAR2(10) DEFAULT '-' NOT NULL,
    value NUMBER(8,2) DEFAULT 0 NOT NULL CHECK (value > 0),
    is_used CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_used IN ('Y', 'N')),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);

CREATE TABLE Waiting_List_Position (
    clients_id VARCHAR2(10) PRIMARY KEY,
    property_id VARCHAR2(10) NOT NULL,
    property_order NUMBER(4) DEFAULT 1 NOT NULL CHECK (property_order >= 1),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
);

CREATE TABLE Rent_solicitude (
    client_id VARCHAR2(10) PRIMARY KEY,
    property_id VARCHAR2(10) NOT NULL,
    start_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    end_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
    preliminary_cost NUMBER(8,2) DEFAULT 0 NOT NULL CHECK (preliminary_cost >= 0),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

CREATE TABLE Contract(
    contract_id NUMBER GENERATED ALWAYS AS IDENTITY,
    client_id VARCHAR2(10) NOT NULL,
    property_id VARCHAR2(10) NOT NULL,
    TPV_per_Month NUMBER(8,2) DEFAULT 0 NOT NULL CHECK (TPV_per_Month >= 0),
    PRIMARY KEY (contract_id,client_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
)


CREATE TABLE Additional_Service (
    client_id VARCHAR2(10) NOT NULL,
    service_name VARCHAR2(50) NOT NULL,
    num_people NUMBER(2) DEFAULT 1 NOT NULL CHECK (num_people > 1 and num_people < 99),
    value NUMBER(7,2) DEFAULT 0 NOT NULL CHECK (value >= 0),
    PRIMARY KEY (client_id, service_name),
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE,
    FOREIGN KEY (service_name) REFERENCES Service(service_name) ON DELETE CASCADE
);

CREATE TABLE Additional_Rates ( -- Tabla que incluye la informacion de tarifas adicionales como impuestos o cosas como la administración de las casas
    rate_name VARCHAR2(50) PRIMARY KEY,
    rate_value NUMBER(7,2) NOT NULL CHECK (rate_value >= 0),
    unit VARCHAR2(10) DEFAULT '%' NOT NULL CHECK (unit IN ('%')),
    rate_type VARCHAR2(20) DEFAULT '-' NOT NULL CHECK (rate_type IN ('TAX', 'COMMISSION')),
    description VARCHAR2(100) DEFAULT '-' NOT NULL
); 


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

