-- TODO: AGREGAR MAS MENSAJES DE MANTENIMIENTOS
CREATE OR REPLACE PACKAGE MODULO_MANTENIMIENTO IS
    PROCEDURE GENERAR_MANTENIMIENTO(cru_id NUMBER,fecha_inicio DATE,fecha_fin DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_MANTENIMIENTO AS
    PROCEDURE GENERAR_MANTENIMIENTO(cru_id NUMBER,fecha_inicio DATE, fecha_fin DATE) IS
        fec_prox DATE;
        descripcion_mant VARCHAR2(100);
    BEGIN
        FOR mant IN (SELECT * FROM MANTENIMIENTO man WHERE man.crucero_id= cru_id AND TO_DATE(man.fecha_prox,'dd/MM/YYYY') >= TO_DATE(fecha_inicio,'dd/MM/YYYY') AND TO_DATE(man.fecha_prox,'dd/MM/YYYY') <= TO_DATE(fecha_fin,'dd/MM/YYYY') FETCH FIRST 10 ROWS ONLY) LOOP
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            fec_prox := fecha_fin + ROUND(DBMS_RANDOM.VALUE (30,60));
            dbms_output.put_line('Procesando Mantenimiento Pautado para el crucero CRU-'||cru_id||' el Dia '|| mant.fecha_prox || ', Proxima fecha de Mantenimiento: ' || fec_prox);
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            CASE ROUND(DBMS_RANDOM.VALUE (1, 8))
                    WHEN 1 THEN
                        descripcion_mant := 'Mantenimiento de Motor';
                    WHEN 2 THEN
                        descripcion_mant := 'Reemplazo de piezas de sistema de anclaje';
                    WHEN 3 THEN
                        descripcion_mant := 'Mantenimiento Preventivo';
                    WHEN 4 THEN
                        descripcion_mant := 'Mantenimiento Correctivo';
                    WHEN 5 THEN
                        descripcion_mant := 'Mantenimiento de Equipo de Comunicaciones';
                    WHEN 6 THEN
                        descripcion_mant := 'Mantenimiento de la piscina';
                    WHEN 7 THEN
                        descripcion_mant := 'Mantenimiento de la Proa';
                    WHEN 8 THEN
                        descripcion_mant := 'Servicio de chequeo general';
                    ELSE
                        descripcion_mant := 'Mantenimiento de Equipo de Comunicaciones';
                    END CASE;
            INSERT INTO MANTENIMIENTO VALUES (
                id_mantenimiento_s.nextVal,
                FECHA_RANGO(fec_prox,fec_prox),
                descripcion_mant,
                fec_prox,
                DBMS_RANDOM.VALUE (40,80),
                cru_id
            );
        END LOOP;
    END;
END;