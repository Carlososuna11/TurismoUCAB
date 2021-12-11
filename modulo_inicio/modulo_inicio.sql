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
        CURSOR cli IS 
            SELECT * FROM CLIENTE;
        cli_aux CLIENTE%ROWTYPE;
        id_pais_random NUMBER;
        nombre_pais_random VARCHAR2(100);
    BEGIN
        OPEN cli;
        FETCH cli into cli_aux;
        WHILE cli%FOUND
            LOOP
                IF aceptar_o_rechazar(0.3) THEN
                    dbms_output.put_line('Asignando pais Venezuela al Cliente '||cli_aux.datos.nombre||' '||cli_aux.datos.apellido);
                    UPDATE CLIENTE 
                    SET pais_id = 10 
                    WHERE id_cliente=cli_aux.id_cliente;
                ELSE
                    SELECT id_pais,nombre 
                    INTO id_pais_random,nombre_pais_random 
                    FROM PAIS 
                    WHERE id_pais != 10 
                    ORDER BY DBMS_RANDOM.RANDOM ASC
                    FETCH FIRST 1 ROWS ONLY;
                    dbms_output.put_line('Asignando pais '|| nombre_pais_random ||' al Cliente '||cli_aux.datos.nombre||' '||cli_aux.datos.apellido);
                    UPDATE CLIENTE 
                    SET pais_id = id_pais_random
                    WHERE id_cliente=cli_aux.id_cliente;
                END IF; 
                FETCH cli into cli_aux;
            END LOOP;
        CLOSE cli;
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