-- funcion: validar nivel de bioseguridad 4

CREATE OR REPLACE FUNCTION fn_validar_reserva_nivel4()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel INT;
    v_rango VARCHAR(50);
BEGIN
    -- obtener nivel del laboratorio
    SELECT nivel_bioseguridad
    INTO v_nivel
    FROM laboratorios
    WHERE id_laboratorio = NEW.id_laboratorio;

    -- obtener rango del investigador
    SELECT r.nombre_rango
    INTO v_rango
    FROM investigadores i
    INNER JOIN rangos r ON i.id_rango = r.id_rango
    WHERE i.id_investigador = NEW.id_investigador;

    -- validacion
    IF v_nivel = 4 AND v_rango <> 'Director' THEN
        RAISE EXCEPTION 
        'Acceso denegado: Solo investigadores con rango Director pueden reservar laboratorios de nivel 4';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger: validar antes de insertar reserva

CREATE TRIGGER trg_validar_reserva_nivel4
BEFORE INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION fn_validar_reserva_nivel4();

-- funcion: registrar auditoria de reservas

CREATE OR REPLACE FUNCTION fn_auditoria_reserva_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria (
        tabla_afectada,
        tipo_operacion,
        usuario,
        fecha_hora,
        descripcion
    )
    VALUES (
        'reservas',
        'INSERT',
        current_user,
        NOW(),
        'Se inserto una reserva con ID ' || NEW.id_reserva ||
        ', Investigador ID: ' || NEW.id_investigador ||
        ', Laboratorio ID: ' || NEW.id_laboratorio
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger: auditoria despues de insertar

CREATE TRIGGER trg_auditoria_reserva_insert
AFTER INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION fn_auditoria_reserva_insert();