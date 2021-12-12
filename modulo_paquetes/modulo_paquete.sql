CREATE OR REPLACE PACKAGE MODULO_PAQUETE IS
    PROCEDURE INICIO_MODULO_PAQUETE;
    PROCEDURE GENERAR_PAQUETES(dest_id NUMBER,fecha_creacion_paq DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_PAQUETE AS
    PROCEDURE GENERAR_PAQUETES(dest_id NUMBER,fecha_creacion_paq DATE) IS
    fecha_inicio_tentativo DATE;
    fecha_fin_tentativo DATE;
    precio_tentativo NUMBER;
    id_paquete_temp NUMBER;
    disp_alo DISPONIBILIDAD%ROWTYPE;
    disp_serv_aux DISPONIBILIDAD%ROWTYPE;
    BEGIN
        FOR r_alo IN (SELECT * FROM SERVICIO WHERE nombre LIKE '%Alojamiento%' AND destino_id=dest_id) LOOP
            dbms_output.put_line('Alojamiento: '||r_alo.nombre ||' '||r_alo.destino_id);
            --Agarrando el record del alojamiento
            -- SELECT * INTO disp_alo FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_alo.id_servicio AND disp.fecha.FechaInicio >= fecha_creacion_paq AND disp.balance.existencia > 0 FETCH FIRST 1 ROWS ONLY;
            -- precio_tentativo := disp_alo.balance.precio_unitario;
            -- IF (disp_alo.id_disponibilidad IS NOT NULL) THEN
            --     FOR I IN 1..disp_alo.balance.existencia LOOP
            --         INSERT INTO PAQUETE VALUES (
            --             id_paquete.nextVal,
            --             fecha_creacion_paq,
            --             0,
            --             precio_tentativo,
            --             FECHA_RANGO(disp_alo.fecha.fechaInicio, disp_alo.fecha.fechaFin),
            --             dest_id
            --         ) RETURNING id_paquete INTO id_paquete_temp;
            --          -- ACTUALIZAR DISPONIBILIDAD SERVICIO
            --         UPDATE DISPONIBILIDAD disp SET disp.balance.existencia = disp.balance.existencia - 1 WHERE disp.id_disponibilidad = disp_alo.id_disponibilidad;
            --         -- CREAR SUBSCRIPCION ALojamiento
            --         INSERT INTO SUBSCRIPCION VALUES (
            --             id_paquete_temp,
            --             disp_alo.id_disponibilidad,
            --             disp_alo.id_servicio
            --         );
            --         -- CREAR SUBSCRIPCIONES PAQUETE
            --         FOR r_serv IN (SELECT * FROM SERVICIO WHERE destino_id = dest_id AND nombre NOT LIKE '%Alojamiento%' FETCH FIRST 5 ROWS ONLY) LOOP
            --             SELECT * INTO disp_serv_aux FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_serv.id_servicio AND disp.fecha.fechaInicio >= fecha_creacion_paq AND disp.balance.existencia > 0 AND disp.fecha.fechaFin <= disp_alo.fecha.fechaFin FETCH FIRST 1 ROWS ONLY;
            --             IF (disp_serv_aux.id_disponibilidad IS NOT NULL) THEN
            --                 INSERT INTO SUBSCRIPCION VALUES (
            --                     id_paquete_temp,
            --                     disp_serv_aux.id_disponibilidad,
            --                     disp_serv_aux.id_servicio
            --                 );
            --                 precio_tentativo := precio_tentativo + disp_serv_aux.balance.precio_unitario;
            --                 -- ACTUALIZAR DISPONIBILIDAD SERVICIO
            --                 UPDATE DISPONIBILIDAD disp SET disp.balance.existencia = disp.balance.existencia - 1 WHERE disp.id_disponibilidad = disp_serv_aux.id_disponibilidad;
            --             END IF;
            --         END LOOP;
            --         UPDATE PAQUETE SET precio = precio_tentativo WHERE id_paquete = id_paquete_temp;
            --     END LOOP;
            -- END IF;
        END LOOP;
    END;
    PROCEDURE INICIO_MODULO_PAQUETE IS
    BEGIN
        dbms_output.put_line('******************************');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('*   MODULO DE PAQUETE         *');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('******************************');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        dbms_output.put_line('Generando los Paquetes de los destinos');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        FOR r_dest IN (SELECT * FROM DESTINO) LOOP
            dbms_output.put_line('Destino: ' || r_dest.nombre);
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            GENERAR_PAQUETES(r_dest.id_destino,SYSDATE-3);
        END LOOP;
    END;
END;