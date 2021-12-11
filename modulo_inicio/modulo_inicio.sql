-- round(DBMS_RANDOM.VALUE (0, 1))
CREATE OR REPLACE PACKAGE MODULO_INICIO IS
    PROCEDURE INICIO;
    PROCEDURE ASIGNAR_PAISES;
    PROCEDURE GENERAR_ALIANZAS;
    PROCEDURE GENERAR_SERVICIOS(id_alianza);
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
            FETCH FIRST 10 ROWS ONLY;
        prov PROVEEDOR%ROWTYPE;
        fecha_inicio DATE;
    BEGIN
        OPEN c_prov;
            FETCH c_prov into prov;
            WHILE c_prov%FOUND
                LOOP
                    fecha_inicio:=RANDOM_DATE(ADD_MONTHS(SYSDATE,-3),SYSDATE );
                    dbms_output.put_line('Estrella Caribeña Firmó una Alianza con '||prov.nombre||' el Dia '||fecha_inicio);
                    INSERT INTO ALIANZA VALUES (id_alianza_s.nextVal,FECHA_RANGO(fecha_inicio,NULL),prov.id_proveedor);
                    FETCH c_prov into prov;
                END LOOP;
        CLOSE c_prov;
    END;

    PROCEDURE GENERAR_SERVICIOS(id_alianza NUMBER) IS
        CURSOR c_ali IS
            SELECT * FROM ALIANZA;
            -- WHERE al.id_alianza=id_alianza OR id_alianza IS NULL;
        ali ALIANZA%ROWTYPE;
        dest DESTINO%ROWTYPE;
    BEGIN
        OPEN c_ali;
            FETCH c_ali into ali;
            WHILE c_ali%FOUND
                LOOP
                    CASE ali.proveedor_id
                        --Hesperia
                        WHEN 1 THEN
                            FOR I IN 1..4
                                LOOP
                                    SELECT * INTO dest FROM DESTINO
                                    WHERE id_destino=I;
                                    dbms_output.put_line('la Alianza con Hesperia generó Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia generó Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia generó Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia generó Servicio de Conferencia Ecológica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia generó Servicio de Observación de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observación de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                            
                        -- Unik Hotel
                        WHEN 2 THEN
                            FOR I IN 1..4
                                LOOP
                                    SELECT * INTO dest FROM DESTINO
                                    WHERE id_destino=I;
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                     dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Conferencia Ecológica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Observación de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observación de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Conferecia de Educación Ambiental en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educación Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel generó Servicio de Conferecia de Visitas dirigidas a Parques Nacionales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Margarita Dynasty Hotel & Suites
                        WHEN 3 THEN
                            FOR I IN 1..4
                                LOOP
                                    SELECT * INTO dest FROM DESTINO
                                    WHERE id_destino=I;
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites generó Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites generó Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites generó Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites generó Servicio de Conferencia Ecológica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites generó Servicio de Observación de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observación de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                            
                        -- Proxima Ruta Venezuela
                        WHEN 4 THEN
                            FOR I IN 1..15
                                LOOP
                                    SELECT * INTO dest FROM DESTINO
                                    WHERE id_destino=I;
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Visitas dirigidas a Parques Nacionales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Visitas a fincas y haciendas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Campismo en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Montañismo en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela generó Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Mochileros Venezuela
                        WHEN 5 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Ruta Extrema
                        WHEN 6 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Fundación Azul Ambientalistas
                        WHEN 7 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educación Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educación Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observación de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Fundación Tierra Viva
                        WHEN 8 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educación Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educación Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observación de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Recreación Bululu
                        WHEN 9 THEN
                            FOR I IN 5..10
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecológica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educación Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educación Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Sendero cojedes
                        WHEN 10 THEN
                            FOR I IN 7..10
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Rutas Mochileras
                        WHEN 11 THEN
                            FOR I IN 6..14
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros Áreas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Suites Cristina
                        WHEN 12 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Woi-Kaa
                        WHEN 13 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Servicio de paseos por puertos, cayos y playas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Montañismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Montañismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Marriot
                        WHEN 14 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Eurobuilding Express
                        WHEN 15 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                    END CASE;
                    FETCH c_ali into ali;
                END LOOP;
        CLOSE c_ali;
    END;

    PROCEDURE INICIO IS
    BEGIN
        dbms_output.put_line('******************************');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('*   MODULO DE INICIO         *');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('******************************');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        dbms_output.put_line('Asignandole los Paises a los Clientes');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        ASIGNAR_PAISES;
        dbms_output.put_line('Generando Alianzas con los Proveedores');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        GENERAR_ALIANZAS;
        dbms_output.put_line('Generando Servicios con las Alianzas');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        GENERAR_SERVICIOS(NULL);
    END;
END;