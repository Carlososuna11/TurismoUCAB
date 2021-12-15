CREATE OR REPLACE PACKAGE MODULO_OBSERVACION IS
    PROCEDURE GENERAR_OBSERVACION(cli_id NUMBER,fecha_inicio DATE,fecha_fin DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_OBSERVACION AS
    PROCEDURE GENERAR_OBSERVACION(cli_id NUMBER,fecha_inicio DATE, fecha_fin DATE) IS
        utilizo_rand NUMBER := ROUND(DBMS_RANDOM.VALUE (0, 1));
        des_obs VARCHAR2(250);
        es_obs NUMBER;
    BEGIN
        FOR prop_paquetes IN (SELECT * FROM PAQUETE paq INNER JOIN PROPIETARIO prop ON prop.paquete_id = paq.id_paquete WHERE prop.cliente_id = cli_id AND TO_DATE(paq.fechas.fechaFin,'dd/MM/YYYY')<=TO_DATE(fecha_fin,'dd/MM/YYYY') ORDER BY DBMS_RANDOM.RANDOM ASC FETCH FIRST 2 ROWS ONLY) LOOP
            IF (prop_paquetes.utilizo IS NULL) THEN
                IF (utilizo_rand = 1) THEN
                    UPDATE PROPIETARIO prop SET prop.utilizo = 1 WHERE prop.cliente_id = cli_id AND prop.paquete_id = prop_paquetes.id_paquete;
                    FOR disp_paq IN (SELECT * FROM SUBSCRIPCION sub WHERE sub.paquete_id = prop_paquetes.id_paquete) LOOP
                        IF aceptar_o_rechazar(0.8) THEN
                            es_obs := ROUND(DBMS_RANDOM.VALUE (1, 5)) ;
                            CASE es_obs
                                WHEN 1 THEN
                                    des_obs:='El servicio es muy pésimo';
                                WHEN 2 THEN
                                    des_obs:='El servicio es pésimo';
                                WHEN 3 THEN
                                    des_obs:='El servicio es regular';
                                WHEN 4 THEN
                                    des_obs:='El servicio es muy bueno';
                                WHEN 5 THEN
                                    des_obs:='El servicio es excelente';
                            END CASE;
                            dbms_output.put_line(' ');
                            dbms_output.put_line(' ');
                            dbms_output.put_line('El cliente '||cli_id||' ha observado el servicio '||disp_paq.disponibilidad_id_servicio||' con una calificación de '||es_obs||' y una descripción de '||des_obs);
                            dbms_output.put_line(' ');
                            dbms_output.put_line(' ');
                            INSERT INTO OBSERVACION VALUES 
                            (
                                id_observacion_s.nextVal,
                                fecha_inicio,
                                es_obs,
                                des_obs,
                                disp_paq.disponibilidad_id_servicio,
                                cli_id
                            );
                        END IF;
                    END LOOP;
                ELSE
                    UPDATE PROPIETARIO prop SET prop.utilizo = 0 WHERE prop.cliente_id = cli_id AND prop.paquete_id = prop_paquetes.id_paquete;
                END IF;
            END IF;                
        END LOOP;
    END;
END;