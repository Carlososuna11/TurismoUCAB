-- round(DBMS_RANDOM.VALUE (0, 1))
CREATE OR REPLACE PACKAGE MODULO_INICIO IS
    PROCEDURE INICIO;
    PROCEDURE ASIGNAR_PAISES;
    PROCEDURE GENERAR_ALIANZAS;
    PROCEDURE GENERAR_SERVICIOS(id_alianza_new NUMBER);
    PROCEDURE SELECCIONAR_TEMPORALIDAD(tiempo IN NUMBER, fecha_inicio IN OUT DATE, fecha_fin IN OUT DATE);
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
                    dbms_output.put_line('Estrella Caribe??a Firm?? una Alianza con '||prov.nombre||' el Dia '||fecha_inicio);
                    INSERT INTO ALIANZA VALUES (id_alianza_s.nextVal,FECHA_RANGO(fecha_inicio,NULL),prov.id_proveedor);
                    FETCH c_prov into prov;
                END LOOP;
        CLOSE c_prov;
    END;

    PROCEDURE GENERAR_SERVICIOS(id_alianza_new NUMBER) IS
        CURSOR c_ali IS
            SELECT * FROM ALIANZA al
            WHERE (al.id_alianza=id_alianza_new OR id_alianza_new IS NULL);
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
                                    dbms_output.put_line('la Alianza con Hesperia gener?? Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia gener?? Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia gener?? Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia gener?? Servicio de Conferencia Ecol??gica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Hesperia gener?? Servicio de Observaci??n de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observaci??n de Aves',
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
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                     dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Conferencia Ecol??gica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Observaci??n de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observaci??n de Aves',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Conferecia de Educaci??n Ambiental en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educaci??n Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Unik Hotel gener?? Servicio de Conferecia de Visitas dirigidas a Parques Nacionales en '||dest.nombre);
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
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites gener?? Servicio de Alojamiento en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de Alojamiento',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites gener?? Servicio de paseos por puertos, cayos y playas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Servicio de paseos por puertos, cayos y playas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites gener?? Servicio de Excursiones Locales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Excursiones Locales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites gener?? Servicio de Conferencia Ecol??gica en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Margarita Dynasty Hotel & Suites gener?? Servicio de Observaci??n de Aves en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observaci??n de Aves',
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
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Visitas dirigidas a Parques Nacionales en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Parques Nacionales',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Visitas a fincas y haciendas en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas a fincas y haciendas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Campismo en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Campismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Monta??ismo
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Monta??ismo en '||dest.nombre);
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    dbms_output.put_line('la Alianza con Proxima Ruta Venezuela gener?? Servicio de Excursiones Locales en '||dest.nombre);
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
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
                                    -- - Monta??ismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
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
                                    -- - Monta??ismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
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
                        -- Fundaci??n Azul Ambientalistas
                        WHEN 7 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educaci??n Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educaci??n Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observaci??n de Aves',
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Fundaci??n Tierra Viva
                        WHEN 8 THEN
                            FOR I IN 1..15
                                LOOP
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educaci??n Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educaci??n Ambiental',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Observaci??n de Aves',
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                END LOOP;
                        -- Recreaci??n Bululu
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
                                        'Conferencia Ecol??gica',
                                        0,
                                        NULL,
                                        I,
                                        ali.id_alianza,
                                        ali.proveedor_id
                                    );
                                    -- - Conferecia de Educaci??n Ambiental
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Conferecia de Educaci??n Ambiental',
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
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
                                    -- - Monta??ismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
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
                                    -- - Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Visitas dirigidas a Refugios de vidas silvestres y otros ??reas Protegidas',
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
                                    -- - Monta??ismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
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
                                    -- - Monta??ismo
                                    INSERT INTO SERVICIO VALUES(
                                        id_servicio_s.nextVal,
                                        'Monta??ismo',
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

    PROCEDURE SELECCIONAR_TEMPORALIDAD(tiempo IN NUMBER, fecha_inicio IN OUT DATE, fecha_fin IN OUT DATE) IS
        BEGIN
            dbms_output.put_line('******************************');
            dbms_output.put_line('* Seleccione la temporalidad *');
            dbms_output.put_line('******************************');
            dbms_output.put_line('1. 3 meses');
            dbms_output.put_line('2. 6 meses');
            dbms_output.put_line('3. 12 meses');
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            CASE tiempo
                WHEN 1 THEN
                    fecha_fin := ADD_MONTHS(fecha_inicio, 3);
                    dbms_output.put_line('> Se selecciono 3 meses');
                WHEN 2 THEN
                    dbms_output.put_line('> Se selecciono 6 meses');
                    fecha_fin := ADD_MONTHS(fecha_inicio, 6);
                WHEN 3 THEN
                    dbms_output.put_line('> Se selecciono 12 meses');
                    fecha_fin := ADD_MONTHS(fecha_inicio, 12);
            END CASE;
            dbms_output.put_line('******************************');
            dbms_output.put_line('    Fecha de Inicio: '|| TO_DATE(fecha_inicio,'dd/MM/YYYY') ||' ');
            dbms_output.put_line('    Fecha de Fin:    '|| TO_DATE(fecha_fin,'dd/MM/YYYY') ||' ');
            dbms_output.put_line('******************************');
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
    END;
END;