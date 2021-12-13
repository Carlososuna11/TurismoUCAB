CREATE OR REPLACE PACKAGE MODULO_SERVICIO IS
    PROCEDURE INICIO_MODULO_SERVICIO;
    PROCEDURE GENERAR_DISPONIBILIDAD(fecha_inicio_tentativo DATE, fecha_creacion DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_SERVICIO AS
    PROCEDURE GENERAR_DISPONIBILIDAD(fecha_inicio_tentativo DATE, fecha_creacion DATE)
    IS
        CURSOR c_serv IS
            SELECT * FROM SERVICIO;
        serv SERVICIO%ROWTYPE;
        fecha_inicio_random DATE;
        fecha_fin_random DATE;
        cantidad_random NUMBER;
        egreso_random NUMBER;
    BEGIN
        -- TODO: LLAMAR MODULO DE ANÁLISIS PARA DECIDIR QUE HACER CON ESTA WEA
        -- TODO: VALIDAR QUE EL SERVICIO NO SEA DIA DE MANTENIMIENTO
        OPEN c_serv;
            FETCH c_serv INTO serv;
            WHILE c_serv%FOUND
                LOOP
                    cantidad_random := ROUND(DBMS_RANDOM.VALUE (1, 3));
                    egreso_random :=  DBMS_RANDOM.VALUE (50, 100) * cantidad_random;
                    fecha_inicio_random := fecha_inicio_tentativo+ROUND(DBMS_RANDOM.VALUE (1, 15));
                    fecha_inicio_random:= RANDOM_DATE(fecha_inicio_tentativo,fecha_inicio_random);
                    IF (serv.nombre LIKE '%Alojamiento%') THEN
                        fecha_fin_random:= fecha_inicio_random + ROUND(DBMS_RANDOM.VALUE (1, 5));
                    ELSE
                        fecha_fin_random:= fecha_inicio_random;
                    END IF;
                    dbms_output.put_line('Se ha invertido '||egreso_random|| ' para la disponibilidad de '|| serv.nombre ||' con las siguientes caracteristicas:');
                    dbms_output.put_line('| Fecha de Inicio: '|| fecha_inicio_random || ' | Fecha Fin: '|| fecha_fin_random || '| cantidad: '|| cantidad_random || 'disponibles |' );
                    INSERT INTO DISPONIBILIDAD VALUES
                    (id_disponibilidad_s.nextVal,
                    FECHA_RANGO(fecha_inicio_random,fecha_fin_random),
                    BALANCE(
                        egreso_random,
                        cantidad_random      
                    ),
                    serv.id_servicio,
                    fecha_creacion
                    );
                FETCH c_serv INTO serv;
                END LOOP;
        CLOSE c_serv;

    END;

    PROCEDURE INICIO_MODULO_SERVICIO IS
    BEGIN
        dbms_output.put_line('******************************');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('*   MODULO DE SERVICIO       *');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('******************************');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        dbms_output.put_line(' Generando disponibilidades aleatorias');
        GENERAR_DISPONIBILIDAD(SYSDATE+15,SYSDATE);
    END;
END;