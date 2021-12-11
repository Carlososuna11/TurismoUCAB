-- round(DBMS_RANDOM.VALUE (0, 1))
CREATE OR REPLACE PACKAGE MODULO_INICIO IS
    PROCEDURE INICIO;
    PROCEDURE ASIGNAR_PAISES;
    -- PROCEDURE GENERAR_ALIANZAS;
    -- PROCEDURE GENERAR_SERVICIOS;
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_INICIO AS
    PROCEDURE ASIGNAR_PAISES IS
        id_pais_random NUMBER;
        nombre_pais_random VARCHAR2;
    BEGIN
        FOR cli IN (
            SELECT * from CLIENTES
        )
        LOOP
            IF aceptar_o_rechazar(0.3) THEN
                dbms_output.put_line('Asignando pais Venezuela al Cliente '||cli.datos.nombre||' '||cli.datos.apellido);
                UPDATE CLIENTE 
                SET pais_id = 10 
                WHERE id_cliente=cli.id_cliente;
            ELSE
                SELECT id_pais,nombre 
                INTO id_pais_random,nombre_pais_random 
                FROM PAIS 
                WHERE id_pais != 10 
                ORDER BY DBMS_RANDOM.RANDOM ASC
                FETCH FIRST 1 ROWS ONLY;
                dbms_output.put_line('Asignando pais '|| nombre_pais_random ||' al Cliente '||cli.datos.nombre||' '||cli.datos.apellido);
                UPDATE CLIENTE 
                SET pais_id = id_pais_random
                WHERE id_cliente=cli.id_cliente;
            END IF; 
        END LOOP;
    END;

    -- PROCEDURE GENERAR_ALIANZAS IS
    --     fecha_inicio_random DATE;
    -- BEGIN
    --     FOR pro IN (
    --         SELECT * FROM PROVEEDOR
    --         ORDER BY DBMS_RANDOM.RANDOM ASC
    --         LIMIT 10;
    --     )
    --     LOOP
    --         dbms_output.put_line('Estrella Caribeña generó una Alianza con '||pro.nombre||'El dia'||fecha_inicio_random);
    --     END LOOP;
    -- END;


    PROCEDURE INICIO IS
    BEGIN
        dbms_output.put_line('******************************');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('*   MODULO DE INICIO         *');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('******************************');
        dbms_output.put_line('');
        dbms_output.put_line('');
        dbms_output.put_line('Asignandole los Paises a los Clientes');
        ASIGNAR_PAISES;
    END;
END;