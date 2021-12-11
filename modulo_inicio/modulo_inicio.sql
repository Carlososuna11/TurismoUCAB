-- round(DBMS_RANDOM.VALUE (0, 1))
CREATE OR REPLACE PACKAGE MODULO_INICIO IS
    PROCEDURE INICIO;
    PROCEDURE ASIGNAR_PAISES;
    PROCEDURE GENERAR_ALIANZAS;
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
                IF aceptar_o_rechazar(0.5) THEN
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

    PROCEDURE GENERAR_ALIANZAS IS
        CURSOR c_prov IS
            SELECT * FROM PROVEEDOR
            ORDER BY DBMS_RANDOM.RANDOM ASC
            FETCH FIRST (round(DBMS_RANDOM.VALUE (7, 12))) ROWS ONLY;
        prov PROVEEDOR%ROWTYPE;
        fecha_inicio DATE;
    BEGIN
        OPEN c_prov;
        FETCH c_prov into prov;
        WHILE c_prov%FOUND
            LOOP
                fecha_inicio=RANDOM_DATE(ADD_MONTHS(SYSDATE,-3),SYSDATE );
                dbms_output.put_line('Estrella Caribeña Firmó una Alianza con '||prov.nombre||' el Dia '||fecha_inicio);
                INSERT INTO ALIANZA VALUES (id_alianza_s.nextVal,FECHA_RANGO(fecha_inicio,NULL),prov.id_proveedor);
                FETCH c_prov into prov;
            END LOOP;
        CLOSE c_prov;
    END;


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
        dbms_output.put_line('Generando Alianzas con los Proveedores');
        GENERAR_ALIANZAS;
    END;
END;