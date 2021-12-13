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
    contador_servicios_paquete NUMBER;
    BEGIN
        FOR r_alo IN (SELECT * FROM SERVICIO WHERE nombre LIKE '%Alojamiento%' AND destino_id=dest_id) LOOP
            -- Obteniendo los Alojamientos disponibles para el destino
            FOR disp_alo IN (
                SELECT * FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_alo.id_servicio AND disp.fecha.fechaInicio >= fecha_creacion_paq AND disp.balance.existencia > 0
            ) LOOP
                contador_servicios_paquete := 0;
                id_paquete_temp := NULL;
                precio_tentativo := disp_alo.balance.precio_unitario;
                
                FOR r_servicio IN (
                    SELECT 
                    DISTINCT serv.nombre,
                    serv.id_servicio
                    FROM SERVICIO serv WHERE serv.nombre NOT LIKE '%Alojamiento%' AND serv.destino_id=dest_id ORDER BY DBMS_RANDOM.RANDOM ASC
                )
                    LOOP
                        FOR disp_serv IN (
                            SELECT  * FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_servicio.id_servicio AND disp.fecha.fechaInicio >= disp_alo.fecha.fechaFin AND disp.fecha.fechaFin <= disp_alo.fecha.fechaFin AND disp.balance.existencia > 0 FETCH FIRST 1 ROWS ONLY
                        ) LOOP
                            IF aceptar_o_rechazar(0.7) THEN
                                precio_tentativo := precio_tentativo + disp_serv.balance.precio_unitario;
                                IF (id_paquete_temp IS NULL) THEN
                                dbms_output.put_line('Alojamiento: '||disp_alo.id_servicio || ' Fecha Inicio: ' || disp_alo.fecha.fechaInicio || ' Fecha Fin:' || disp_alo.fecha.fechaFin);
                                    INSERT INTO PAQUETE VALUES (
                                        id_paquete.nextval,
                                        fecha_creacion_paq,
                                        0,
                                        precio_tentativo,
                                        FECHA_RANGO(disp_alo.fecha.fechaInicio,disp_alo.fecha.fechaFin),
                                        dest_id
                                    ) RETURNING id_paquete INTO id_paquete_temp;
                                    INSERT INTO SUBSCRIPCION VALUES (
                                        id_paquete_temp,
                                        disp_alo.id_disponibilidad,
                                        disp_alo.id_servicio
                                    );
                                    UPDATE DISPONIBILIDAD disp SET disp.balance.existencia = disp.balance.existencia - 1 WHERE disp.id_disponibilidad = disp_alo.id_disponibilidad;
                                ELSE
                                    UPDATE PAQUETE paq SET paq.precio = precio_tentativo WHERE paq.id_paquete = id_paquete_temp;
                                END IF; 
                                dbms_output.put_line('          Servicio: '||r_servicio.nombre || ' Fecha Inicio: ' || disp_serv.fecha.fechaInicio || ' Fecha Fin:' || disp_serv.fecha.fechaFin);
                                INSERT INTO SUBSCRIPCION VALUES (
                                        id_paquete_temp,
                                        disp_serv.id_disponibilidad,
                                        disp_serv.id_servicio
                                );
                                UPDATE DISPONIBILIDAD disp SET disp.balance.existencia = disp.balance.existencia - 1 WHERE disp.id_disponibilidad = disp_serv.id_disponibilidad;
                                contador_servicios_paquete := contador_servicios_paquete + 1;
                            END IF;
                        END LOOP;
                        EXIT WHEN contador_servicios_paquete >= 5;
                    END LOOP;
            END LOOP;
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