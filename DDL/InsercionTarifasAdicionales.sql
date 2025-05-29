--Inserción datos 

-- Comisiones
INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('Gestión', 1.00, '%', 'COMMISSION', 'Comisión por gestión de la propiedad');

INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('Administración', 0.50, '%', 'COMMISSION', 'Comisión administrativa mensual');

INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('Mantenimiento', 0.30, '%', 'COMMISSION', 'Costo estándar de mantenimiento');

-- Impuestos
INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('IVA', 16.00, '%', 'TAX', 'Impuesto al valor agregado aplicable');

INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('ReteFuente', 7.00, '%', 'TAX', 'Retención en la fuente');

INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('ICA', 6.00, '%', 'TAX', 'Impuesto de industria y comercio');

INSERT INTO Additional_Rates_And_Taxes (rate_name, rate_value, unit, rate_type, description)
VALUES ('RetenciónIVA', 15.00, '%', 'TAX', 'Retención del IVA por parte del agente retenedor');


COMMIT;

 
