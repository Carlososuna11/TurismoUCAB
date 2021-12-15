CREATE OR REPLACE PACKAGE MODULO_MANTENIMIENTO IS
    PROCEDURE GENERAR_MANTENIMIENTO(cru_id NUMBER,fecha_inicio DATE,fecha_fin DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_MANTENIMIENTO AS
    PROCEDURE GENERAR_MANTENIMIENTO(cru_id NUMBER,fecha_inicio DATE, fecha_fin DATE) IS
        fec_prox DATE;
    BEGIN
        FOR mant IN (SELECT * FROM MANTENIMIENTO man WHERE man.crucero_id= cru_id AND TO_DATE(man.fecha_prox,'dd/MM/YYYY') >= TO_DATE(fecha_inicio,'dd/MM/YYYY') AND TO_DATE(man.fecha_prox,'dd/MM/YYYY') <= TO_DATE(fecha_fin,'dd/MM/YYYY') FETCH FIRST 10 ROWS ONLY) LOOP
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            fec_prox := fecha_fin + ROUND(DBMS_RANDOM.VALUE (30,60));
            dbms_output.put_line('Procesando Mantenimiento Pautado para el crucero CRU-'||cru_id||' el Dia '|| mant.fecha_prox || ', Proxima fecha de Mantenimiento: ' || fec_prox);
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            INSERT INTO MANTENIMIENTO VALUES (
                id_mantenimiento_s.nextVal,
                FECHA_RANGO(fec_prox,fec_prox),
                'Mantenimiento preventivo',
                fec_prox,
                DBMS_RANDOM.VALUE (40,80),
                cru_id
            );
        END LOOP;
    END;
END;