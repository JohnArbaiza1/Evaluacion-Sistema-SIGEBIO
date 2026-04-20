-- datos de prueba (5 por tabla)

-- rangos
INSERT INTO rangos (nombre_rango) VALUES
('Junior'),
('Senior'),
('Director');

-- investigadores
INSERT INTO investigadores (nombre, apellido, correo, id_rango) VALUES
('Carlos', 'Lopez', 'carlos.lopez@bio.com', 1),
('Maria', 'Gomez', 'maria.gomez@bio.com', 2),
('Luis', 'Martinez', 'luis.martinez@bio.com', 3),
('Ana', 'Hernandez', 'ana.hernandez@bio.com', 2),
('Jose', 'Ramirez', 'jose.ramirez@bio.com', 1);

-- laboratorios
INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES
('Lab A', 1, 10),
('Lab B', 2, 15),
('Lab C', 3, 20),
('Lab D', 4, 5),   -- Nivel 4 (solo Director)
('Lab E', 2, 12);

-- equipos
INSERT INTO equipos (nombre, id_laboratorio, estado, ultima_revision, responsable_mantenimiento) VALUES
('Microscopio 1', 1, 'Disponible', '2026-01-10', 'Tecnico A'),
('Centrifuga 1', 2, 'En uso', '2026-02-15', 'Tecnico B'),
('Freezer 1', 3, 'En mantenimiento', '2026-03-01', 'Tecnico C'),
('Secuenciador 1', 4, 'Disponible', '2026-01-20', 'Tecnico D'),
('Microscopio 2', 5, 'Fuera de servicio', '2025-12-30', 'Tecnico E');

-- reservas
INSERT INTO reservas (id_investigador, id_laboratorio, fecha_inicio, fecha_fin) VALUES
(1, 1, '2026-05-01 08:00', '2026-05-01 10:00'),
(2, 2, '2026-05-01 11:00', '2026-05-01 13:00'),
(3, 4, '2026-05-02 09:00', '2026-05-02 12:00'), -- Director en nivel 4
(4, 3, '2026-05-03 08:00', '2026-05-03 10:00'),
(5, 5, '2026-05-04 14:00', '2026-05-04 16:00');

-- reserva_equipos
INSERT INTO reserva_equipos (id_reserva, id_equipo) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 3),
(5, 5);