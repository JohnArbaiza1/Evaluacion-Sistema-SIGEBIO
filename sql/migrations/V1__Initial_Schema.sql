-- Tabla de rangos
CREATE TABLE rangos (
    id_rango SERIAL PRIMARY KEY,
    nombre_rango VARCHAR(50) NOT NULL
);

-- Tabla de investigadores
CREATE TABLE investigadores (
    id_investigador SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    id_rango INT NOT NULL
);

-- Tabla de laboratorios
CREATE TABLE laboratorios (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla de equipos
CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_laboratorio INT NOT NULL,
    estado VARCHAR(50) NOT NULL,
    responsable_mantenimiento VARCHAR(100)
);

-- Tabla de reservas
CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

-- Tabla intermedia reserva_equipos
CREATE TABLE reserva_equipos (
    id_reserva INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_reserva, id_equipo)
);

-- Tabla de auditoría
CREATE TABLE auditoria (
    id_auditoria SERIAL PRIMARY KEY,
    tabla_afectada VARCHAR(100) NOT NULL,
    tipo_operacion VARCHAR(50) NOT NULL,
    usuario VARCHAR(100),
    fecha_hora TIMESTAMP NOT NULL,
    descripcion TEXT
);