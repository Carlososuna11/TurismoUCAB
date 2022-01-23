CREATE OR REPLACE PACKAGE MODULO_COMPRA IS
    PROCEDURE INICIO_MODULO_COMPRA;
    FUNCTION  GENERAR_PCR(id_cliente_pcr NUMBER,fecha_pcr DATE) RETURN NUMBER;
    PROCEDURE COMPRAR_PAQUETE(id_cliente_paq NUMBER, fecha_compra DATE);
    PROCEDURE GENERAR_VENTAS_COMPETENCIA(mes DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY MODULO_COMPRA AS
    FUNCTION GENERAR_PCR(id_cliente_pcr NUMBER,fecha_pcr DATE) RETURN NUMBER
    IS
        cli CLIENTE%ROWTYPE;
        resultado_pcr NUMBER;
    BEGIN
        resultado_pcr := round(DBMS_RANDOM.VALUE (0, 1));
        INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
        VALUES (fecha_pcr,resultado_pcr,id_cliente_pcr);
        SELECT * INTO cli FROM CLIENTE WHERE CLIENTE.id_cliente = id_cliente_pcr;
        IF resultado_pcr = 1 THEN
            dbms_output.put_line('El cliente '||cli.datos.nombre||' '||cli.datos.apellido||' Dio positivo Para COVID, por ello no podrá comprar ningun paquete');
        ELSE
            dbms_output.put_line('El cliente '||cli.datos.nombre||' '||cli.datos.apellido||' Dio negativo Para COVID, por ello podrá comprar paquetes');
        END IF;
        RETURN resultado_pcr;
    END;

    PROCEDURE COMPRAR_PAQUETE(id_cliente_paq NUMBER, fecha_compra DATE) IS
        canal_pago_id NUMBER :=round(DBMS_RANDOM.VALUE (1, 5));
        TYPE paq_list is Varray(6) OF PAQUETE%ROWTYPE;
        paq_lista paq_list := paq_list();
        counter NUMBER := 0;
        califica NUMBER(1) := 1; 
        pcr_res NUMBER := GENERAR_PCR(id_cliente_paq,fecha_compra);
        maximo NUMBER := round(DBMS_RANDOM.VALUE (1, 4));
        cli_paq CLIENTE%ROWTYPE;
        id_fact_temp NUMBER;
        id_det_fact_temp NUMBER;
        dispositivo VARCHAR2(50);
        cant_met NUMBER;
        abono NUMBER := 0;
        counter_abono NUMBER := 0;
        a_pagar NUMBER := 0;
        canal_pago MEDIO%ROWTYPE;
        precio_total_factura NUMBER :=0;
    BEGIN
        IF (pcr_res = 1) THEN
            RETURN;
        END IF;
        FOR op_paquetes IN (SELECT paq.id_paquete,
            paq.fechaCreacion,
            paq.vacunado,
            paq.precio,
            paq.fechas,
            paq.destino_id
         FROM PAQUETE paq LEFT JOIN PROPIETARIO prop
         ON prop.paquete_id = paq.id_paquete
         WHERE prop.cliente_id IS NULL AND
         (paq.fechas.fechaInicio > fecha_compra) ORDER BY DBMS_RANDOM.RANDOM ASC) LOOP
            califica := 1;

            FOR prop_paquetes IN (SELECT * FROM PAQUETE paq INNER JOIN PROPIETARIO prop ON prop.paquete_id = paq.id_paquete WHERE prop.cliente_id = id_cliente_paq) LOOP
                IF ((prop_paquetes.fechas.fechaInicio <= op_paquetes.fechas.fechaInicio AND 
                    prop_paquetes.fechas.fechaFin >= op_paquetes.fechas.fechaInicio) OR 
                    ((prop_paquetes.fechas.fechaInicio <= op_paquetes.fechas.fechaFin AND 
                    prop_paquetes.fechas.fechaFin >= op_paquetes.fechas.fechaFin))) THEN
                    califica := 0;
                    EXIT;
                END IF;
            END LOOP;
            IF (califica = 1) THEN
                IF (counter = 0) THEN
                    counter := counter + 1;
                    paq_lista.extend;
                    paq_lista(counter) := op_paquetes;
                ELSE
                    FOR i IN 1..counter LOOP
                        IF ((paq_lista(i).fechas.fechaInicio <= op_paquetes.fechas.fechaInicio AND 
                            paq_lista(i).fechas.fechaFin >= op_paquetes.fechas.fechaInicio) OR 
                            ((paq_lista(i).fechas.fechaInicio <= op_paquetes.fechas.fechaFin AND 
                            paq_lista(i).fechas.fechaFin >= op_paquetes.fechas.fechaFin))) THEN
                                califica := 0;
                                EXIT;
                        END IF;
                    END LOOP;
                    IF (califica = 1) THEN
                        counter := counter + 1;
                        paq_lista.extend;
                        paq_lista(counter) := op_paquetes;
                    END IF;
                END IF;
                IF (counter = maximo) THEN
                    EXIT;
                END IF;
            END IF;
        END LOOP;
        IF (counter > 0 ) THEN
            -- crear factura
            SELECT * INTO cli_paq FROM CLIENTE WHERE CLIENTE.id_cliente = id_cliente_paq;
            IF (canal_pago_id > 1) THEN
                    CASE ROUND(DBMS_RANDOM.VALUE (1, 4))
                    WHEN 1 THEN
                        dispositivo := 'IOS';
                    WHEN 2 THEN
                        dispositivo := 'ANDROID';
                    WHEN 3 THEN
                        dispositivo := 'WINDOWS PC';
                    WHEN 4 THEN
                        dispositivo := 'MAC OS';
                    END CASE;
            ELSE
                dispositivo := NULL;
            END IF; 
            SELECT * INTO canal_pago FROM MEDIO WHERE MEDIO.id_medio = canal_pago_id;
            INSERT INTO FACTURA VALUES (
            id_factura_s.nextVal,
            fecha_compra,
            0,
            dispositivo,
            id_cliente_paq,
            canal_pago.id_medio) RETURNING id_factura INTO id_fact_temp;
            FOR i IN 1..counter LOOP
                IF (dispositivo IS NULL) THEN
                    dbms_output.put_line('                  El cliente '||cli_paq.datos.nombre||' ' || cli_paq.datos.apellido ||' compro el paquete '||paq_lista(i).id_paquete||' por un monto de '||paq_lista(i).precio);
                ELSE
                    dbms_output.put_line('                  El cliente '||cli_paq.datos.nombre||' ' || cli_paq.datos.apellido ||' compro el paquete '||paq_lista(i).id_paquete||' por un monto de '||paq_lista(i).precio||' con el dispositivo '||dispositivo);
                END IF;
                -- CREAR DETALLE DE FACTURA
                INSERT INTO DETFACTURA VALUES (
                    id_detfactura_s.nextVal,
                    paq_lista(i).precio,
                    id_fact_temp,
                    paq_lista(i).id_paquete
                ) RETURNING id_detFactura INTO id_det_fact_temp;
                cant_met := ROUND(DBMS_RANDOM.VALUE (1, 3));
                abono:= 0;
                counter_abono := 0;
                dbms_output.put_line('                      Metodos de Pago');
                FOR op_metodos IN (SELECT * FROM METODOS_PAGO ORDER BY DBMS_RANDOM.RANDOM ASC) LOOP
                    counter_abono := counter_abono + 1;
                    a_pagar := 0;
                    IF (counter_abono = cant_met) THEN
                        a_pagar := paq_lista(i).precio - abono;
                        abono := a_pagar + abono;
                        INSERT INTO MPAGO VALUES(
                            id_mpago_s.nextVal,
                            op_metodos.nombre,
                            a_pagar,
                            id_det_fact_temp,
                            id_fact_temp,
                            paq_lista(i).id_paquete
                        );
                        dbms_output.put_line('                      '||op_metodos.nombre||' Cantidad Abonada '||ROUND(a_pagar,2)|| ' Abono Total '||ROUND(abono,2));
                        EXIT;
                    ELSE
                        a_pagar := (paq_lista(i).precio - abono)/2;
                        a_pagar := DBMS_RANDOM.VALUE (1, a_pagar);
                        abono := a_pagar + abono;
                        INSERT INTO MPAGO VALUES(
                            id_mpago_s.nextVal,
                            op_metodos.nombre,
                            a_pagar,
                            id_det_fact_temp,
                            id_fact_temp,
                            paq_lista(i).id_paquete
                        );
                        dbms_output.put_line('                      '||op_metodos.nombre||' Cantidad Abonada '||ROUND(a_pagar,2)|| ' Abono Total '||ROUND(abono,2));
                    END IF;
                END LOOP;
                precio_total_factura := precio_total_factura + abono;
                FOR op_disp IN (SELECT 
                                disp.id_disponibilidad,
                                disp.fecha,
                                disp.balance,
                                disp.id_servicio,
                                disp.fecha_creacion
                                FROM DISPONIBILIDAD disp 
                                INNER JOIN SUBSCRIPCION subs 
                                ON subs.disponibilidad_id = disp.id_disponibilidad 
                                INNER JOIN PAQUETE paq ON paq.id_paquete = subs.paquete_id 
                                WHERE paq.id_paquete = paq_lista(i).id_paquete ) LOOP
                    UPDATE DISPONIBILIDAD disp SET disp.balance.numeroVentas = disp.balance.numeroVentas + 1 WHERE disp.id_disponibilidad = op_disp.id_disponibilidad;
                END LOOP;
                -- TODO: COMPRAR PAQUETE A OTRA PERSONA
                INSERT INTO PROPIETARIO VALUES (
                    NULL,
                    NULL,
                    id_cliente_paq,
                    paq_lista(i).id_paquete
                );
            END LOOP;
            precio_total_factura := precio_total_factura + canal_pago.comision;
            dbms_output.put_line('Total Factura '||ROUND(precio_total_factura,2));   
            UPDATE FACTURA fact SET fact.total = precio_total_factura WHERE fact.id_factura = id_fact_temp;     
        END IF;
    END;

    PROCEDURE GENERAR_VENTAS_COMPETENCIA(mes DATE) IS
    BEGIN
        FOR comp IN (SELECT * FROM COMPETENCIA) LOOP
            -- TODO: SABER CUANTOS PAQUETE HA VENDIDO ESTRELLA CARIBENA (PROMEDIO)
            unidades_vendidas := ROUND(DBMS_RANDOM.VALUE (100, 200));
            INSERT INTO VENTA VALUES (
                TO_DATE(mes, 'MM/YYYY'),
                0,
                unidades_vendidas,
                comp.id_competencia
            );
        END LOOP;
    END;

    PROCEDURE INICIO_MODULO_COMPRA IS
    BEGIN
        dbms_output.put_line('******************************');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('*   MODULO DE COMPRA         *');
        dbms_output.put_line('*                            *');
        dbms_output.put_line('******************************');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        dbms_output.put_line(' Generando compras aleatorias');
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        FOR cli_aleatorio IN (SELECT * FROM CLIENTE ORDER BY DBMS_RANDOM.RANDOM ASC FETCH FIRST 5 ROWS ONLY) LOOP
            COMPRAR_PAQUETE(cli_aleatorio.id_cliente,SYSDATE);
            dbms_output.put_line(' ');
        END LOOP;
    END;
END;