/*Insercion de additional service - Corregido para la estructura de tabla*/

-- Cliente CLI0000001
-- PROP000001: Servicio LIMPIEZA (150×3=450) para los pagos P0001–P0006
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000001', 'LIMPIEZA', 3, 450.00); 

-- Para PROP000005: Servicio LAVANDERÍA (100×5=500) para los pagos P0007–P0012
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000001', 'LAVANDERIA', 5, 500.00);

-- Cliente CLI0000002
-- PROP000002: Servicio LIMPIEZA (150×2=300)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000002', 'LIMPIEZA', 2, 300.00);

-- PROP000010: Servicio LAVANDERIA (100×2=200)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000002', 'LAVANDERIA', 2, 200.00);

-- Cliente CLI0000003
-- PROP000003: Servicio REPARACION (250×4=1000)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000003', 'REPARACION', 4, 1000.00);

-- PROP000001 (histórico): Servicio MANTENIMIENTO (300×3=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000003', 'MANTENIMIENTO', 3, 900.00);

-- Cliente CLI0000004
-- PROP000004: Servicio PLOMERIA (275×2=550)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000004', 'PLOMERIA', 2, 550.00);

-- PROP000006: Servicio LAVANDERIA (100×6=600)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000004', 'LAVANDERIA', 6, 600.00);

-- Cliente CLI0000005
-- PROP000005: Servicio SEGURIDAD (350×5=1750)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000005', 'SEGURIDAD', 5, 1750.00);

-- PROP000011: Servicio LAVANDERIA (100×6=600)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000005', 'LAVANDERIA', 6, 600.00);

-- Cliente CLI0000006
-- PROP000006: Servicio MANTENIMIENTO (300×3=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000006', 'MANTENIMIENTO', 3, 900.00);

-- PROP000014: Servicio JARDINERIA (200×2=400)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000006', 'JARDINERIA', 2, 400.00);

-- Cliente CLI0000007
-- PROP000007: Servicio PINTURA (220×2=440)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000007', 'PINTURA', 2, 440.00);

-- PROP000017: Servicio JARDINERIA (200×2=400)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000007', 'JARDINERIA', 2, 400.00);

-- Cliente CLI0000008
-- PROP000008: Servicio ELECTRICO (240×3=720)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000008', 'ELECTRICO', 3, 720.00);

-- PROP000019: Servicio SEGURIDAD (350×4=1400)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000008', 'SEGURIDAD', 4, 1400.00);

-- Cliente CLI0000009
-- PROP000009: Servicio PINTURA (220×5=1100)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000009', 'PINTURA', 5, 1100.00);

-- PROP000003: Servicio JARDINERIA (200×5=1000)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000009', 'JARDINERIA', 5, 1000.00);

-- Cliente CLI0000010
-- PROP000010: Servicio PINTURA (220×2=440)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000010', 'PINTURA', 2, 440.00);

-- PROP000008: Servicio MANTENIMIENTO (300×3=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000010', 'MANTENIMIENTO', 3, 900.00);

-- Cliente CLI0000011
-- PROP000011: Servicio PARQUE (180×6=1080)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000011', 'PARQUE', 6, 1080.00);

-- Cliente CLI0000012
-- PROP000012: Servicio REPARACION (250×3=750)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000012', 'REPARACION', 3, 750.00);

-- Cliente CLI0000013
-- PROP000013: Servicio JARDINERIA (200×5=1000)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000013', 'JARDINERIA', 5, 1000.00);

-- Cliente CLI0000014
-- PROP000014: Servicio PLOMERIA (275×2=550)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000014', 'PLOMERIA', 2, 550.00);

-- Cliente CLI0000015
-- PROP000015: Servicio MANTENIMIENTO (300×3=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000015', 'MANTENIMIENTO', 3, 900.00);

-- Cliente CLI0000016
-- PROP000016: Servicio PLOMERIA (275×4=1100)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000016', 'PLOMERIA', 4, 1100.00);

-- Cliente CLI0000017
-- PROP000017: Servicio JARDINERIA (200×2=400)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000017', 'JARDINERIA', 2, 400.00);

-- Cliente CLI0000018
-- PROP000018: Servicio SEGURIDAD (350×3=1050)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000018', 'SEGURIDAD', 3, 1050.00);

-- Cliente CLI0000019
-- PROP000019: Servicio PINTURA (220×4=880)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000019', 'PINTURA', 4, 880.00);

-- Cliente CLI0000020
-- PROP000020: Servicio MANTENIMIENTO (300×2=600)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000020', 'MANTENIMIENTO', 2, 600.00);

-- Cliente CLI0000021
-- PROP000001: Servicio SEGURIDAD (350×3=1050)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000021', 'SEGURIDAD', 3, 1050.00);

-- Cliente CLI0000022
-- PROP000002: Servicio LAVANDERIA (100×2=200)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000022', 'LAVANDERIA', 2, 200.00);

-- Cliente CLI0000023
-- PROP000003: Servicio ELECTRICO (240×4=960)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000023', 'ELECTRICO', 4, 960.00);

-- Cliente CLI0000024
-- PROP000004: Servicio PLOMERIA (275×2=550)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000024', 'PLOMERIA', 2, 550.00);

-- Cliente CLI0000025
-- PROP000005: Servicio PARQUE (180×5=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000025', 'PARQUE', 5, 900.00);

-- Cliente CLI0000026
-- PROP000006: Servicio LIMPIEZA (150×3=450)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000026', 'LIMPIEZA', 3, 450.00);

-- Cliente CLI0000027
-- PROP000007: Servicio PINTURA (220×2=440)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000027', 'PINTURA', 2, 440.00);

-- Cliente CLI0000028
-- PROP000008: Servicio ELECTRICO (240×3=720)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000028', 'ELECTRICO', 3, 720.00);

-- Cliente CLI0000029
-- PROP000009: Servicio PLOMERIA (275×4=1100)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000029', 'PLOMERIA', 4, 1100.00);

-- Cliente CLI0000030
-- PROP000010: Servicio MANTENIMIENTO (300×2=600)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000030', 'MANTENIMIENTO', 2, 600.00);

-- Cliente CLI0000031
-- PROP000011: Servicio SEGURIDAD (350×6=2100)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000031', 'SEGURIDAD', 6, 2100.00);

-- Cliente CLI0000032
-- PROP000012: Servicio MANTENIMIENTO (300×3=900)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000032', 'MANTENIMIENTO', 3, 900.00);

-- Cliente CLI0000033
-- PROP000013: Servicio JARDINERIA (200×5=1000)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000033', 'JARDINERIA', 5, 1000.00);

-- Cliente CLI0000034
-- PROP000014: Servicio LAVANDERIA (100×2=200)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000034', 'LAVANDERIA', 2, 200.00);

-- Cliente CLI0000035
-- PROP000015: Servicio REPARACION (250×3=750)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000035', 'REPARACION', 3, 750.00);

-- Cliente CLI0000036
-- PROP000016: Servicio MANTENIMIENTO (300×4=1200)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000036', 'MANTENIMIENTO', 4, 1200.00);

-- Cliente CLI0000037
-- PROP000017: Servicio LIMPIEZA (150×2=300)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000037', 'LIMPIEZA', 2, 300.00);

-- Cliente CLI0000038
-- PROP000018: Servicio SEGURIDAD (350×3=1050)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000038', 'SEGURIDAD', 3, 1050.00);

-- Cliente CLI0000039
-- PROP000019: Servicio PINTURA (220×4=880)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000039', 'PINTURA', 4, 880.00);

-- Cliente CLI0000040
-- PROP000020: Servicio MANTENIMIENTO (300×2=600)
INSERT INTO Additional_Service (client_id, service_name, num_people, value) VALUES ('CLI0000040', 'MANTENIMIENTO', 2, 600.00);
commit;