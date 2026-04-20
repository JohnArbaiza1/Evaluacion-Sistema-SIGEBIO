-- V2__Constraints_And_Indexes. archivo hecho por el Partner A en la rama requerida
-- con las  Restricciones de integridad referencial acciones en cascada o set null etc segun lo pedido

-- 1. FOREIGN KEYS con acciones en cascada / set null

-- investigadores -> rangos
ALTER TABLE investigadores
    ADD CONSTRAINT fk_investigadores_rango
    FOREIGN KEY (id_rango)
    REFERENCES rangos(id_rango)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- equipos -> laboratorios
ALTER TABLE equipos
    ADD CONSTRAINT fk_equipos_laboratorio
    FOREIGN KEY (id_laboratorio)
    REFERENCES laboratorios(id_laboratorio)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- reservas -> investigadores
ALTER TABLE reservas
    ADD CONSTRAINT fk_reservas_investigador
    FOREIGN KEY (id_investigador)
    REFERENCES investigadores(id_investigador)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- reservas -> laboratorios
ALTER TABLE reservas
    ADD CONSTRAINT fk_reservas_laboratorio
    FOREIGN KEY (id_laboratorio)
    REFERENCES laboratorios(id_laboratorio)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- reserva_equipos -> reservas
ALTER TABLE reserva_equipos
    ADD CONSTRAINT fk_reservaequipos_reserva
    FOREIGN KEY (id_reserva)
    REFERENCES reservas(id_reserva)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- reserva_equipos -> equipos 
ALTER TABLE reserva_equipos
    ADD CONSTRAINT fk_reservaequipos_equipo
    FOREIGN KEY (id_equipo)
    REFERENCES equipos(id_equipo)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- 2. RESTRICCIONES DE DOMINIO (CHECK)

-- nivel_bioseguridad
ALTER TABLE laboratorios
    ADD CONSTRAINT chk_bioseguridad
    CHECK (nivel_bioseguridad BETWEEN 1 AND 4);

ALTER TABLE laboratorios
    ADD CONSTRAINT chk_capacidad_positiva
    CHECK (capacidad > 0);

ALTER TABLE equipos
    ADD CONSTRAINT chk_estado_equipo
    CHECK (estado IN ('Disponible', 'En uso', 'En mantenimiento', 'Fuera de servicio'));

ALTER TABLE reservas
    ADD CONSTRAINT chk_fechas_reserva
    CHECK (fecha_fin > fecha_inicio);

ALTER TABLE investigadores
    ADD CONSTRAINT chk_correo_formato
    CHECK (correo LIKE '%@%.%');

ALTER TABLE auditoria
    ADD CONSTRAINT chk_tipo_operacion
    CHECK (tipo_operacion IN ('INSERT', 'UPDATE', 'DELETE', 'SELECT'));

-- 3. ÍNDICES para optimizar búsquedas

-- Búsquedas por fecha de inicio y fin de reservas
CREATE INDEX idx_reservas_fecha_inicio
    ON reservas(fecha_inicio);

CREATE INDEX idx_reservas_fecha_fin
    ON reservas(fecha_fin);

-- Índice compuesto para rangos de fecha
CREATE INDEX idx_reservas_rango_fechas
    ON reservas(fecha_inicio, fecha_fin);

-- Búsquedas de reservas por investigador
CREATE INDEX idx_reservas_investigador
    ON reservas(id_investigador);

-- Búsquedas de reservas por laboratorio
CREATE INDEX idx_reservas_laboratorio
    ON reservas(id_laboratorio);

-- Búsquedas de equipos por laboratorio y estado
CREATE INDEX idx_equipos_laboratorio
    ON equipos(id_laboratorio);

CREATE INDEX idx_equipos_estado
    ON equipos(estado);

-- Búsquedas en auditoría por fecha y tabla afectada
CREATE INDEX idx_auditoria_fecha_hora
    ON auditoria(fecha_hora);

CREATE INDEX idx_auditoria_tabla
    ON auditoria(tabla_afectada);