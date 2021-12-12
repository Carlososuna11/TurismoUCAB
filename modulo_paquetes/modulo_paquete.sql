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
    BEGIN
        FOR r_alo IN (SELECT * FROM SERVICIO WHERE nombre LIKE '%Alojamiento%' AND destino_id=dest_id) LOOP
            -- Obteniendo los Alojamientos disponibles para el destino
            FOR disp_alo IN (
                SELECT * FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_alo.id_servicio AND disp.fecha.fechaInicio >= fecha_creacion_paq AND disp.balance.existencia > 0
            ) LOOP
                dbms_output.put_line('Alojamiento: '||disp_alo.id_servicio || ' Fecha Inicio: ' || disp_alo.fecha.fechaInicio || ' Fecha Fin:' || disp_alo.fecha.fechaFin);
                FOR r_servicio IN (
                    SELECT * FROM SERVICIO serv WHERE nombre NOT LIKE '%Alojamiento%' AND destino_id=dest_id
                )
                    LOOP
                        FOR disp_serv IN (
                            SELECT  * FROM DISPONIBILIDAD disp WHERE disp.id_servicio = r_servicio.id_servicio AND disp.fecha.fechaInicio >= fecha_creacion_paq AND disp.fecha.fechaFin <= disp_alo.fecha.fechaFin AND disp.balance.existencia > 0 FETCH FIRST 1 ROWS ONLY
                        ) LOOP
                            dbms_output.put_line('          Servicio: '||r_servicio.nombre || ' Fecha Inicio: ' || disp_serv.fecha.fechaInicio || ' Fecha Fin:' || disp_serv.fecha.fechaFin);
                        END LOOP;
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