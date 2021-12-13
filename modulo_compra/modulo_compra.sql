CREATE OR REPLACE PACKAGE MODULO_COMPRA IS
    PROCEDURE INICIO_MODULO_COMPRA;
    FUNCTION  GENERAR_PCR(id_cliente_pcr NUMBER,fecha_pcr DATE) RETURN NUMBER;
    PROCEDURE COMPRAR_PAQUETE(id_cliente_paq NUMBER, fecha_compra DATE);
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
        dispositivo VARCHAR2(50);
        cant_met NUMBER;
        abono NUMBER := 0;
        counter_abono NUMBER := 0;
        a_pagar NUMBER := 0;
    BEGIN
        IF (pcr_res = 1) THEN
            RETURN;
        END IF;
        FOR op_paquetes IN (SELECT * FROM PAQUETE paq WHERE paq.fechas.fechaInicio > fecha_compra ORDER BY DBMS_RANDOM.RANDOM ASC) LOOP
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
            
            FOR i IN 1..counter LOOP
                cant_met := ROUND(DBMS_RANDOM.VALUE (1, 3));
                --TODO: PROCESO DE COMPRA DE PAQUETES
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
                    dbms_output.put_line('El cliente '||cli_paq.datos.nombre||' ' || cli_paq.datos.apellido ||' compro el paquete '||paq_lista(i).id_paquete||' por un monto de '||paq_lista(i).precio||' con el dispositivo '||dispositivo);
                ELSE
                     dbms_output.put_line('El cliente '||cli_paq.datos.nombre||' ' || cli_paq.datos.apellido ||' compro el paquete '||paq_lista(i).id_paquete||' por un monto de '||paq_lista(i).precio);
                END IF; 
                abono:= 0;
                counter_abono := 0;
                dbms_output.put_line('                      Metodos de Pago');
                FOR op_metodos IN (SELECT * FROM METODOS_PAGO ORDER BY DBMS_RANDOM.RANDOM ASC) LOOP
                    counter_abono := counter_abono + 1;
                    a_pagar := 0;
                    IF (counter_abono = cant_met) THEN
                        a_pagar := paq_lista(i).precio - abono;
                        abono := a_pagar + abono;
                        dbms_output.put_line('                      '||op_metodos.nombre||' Cantidad Abonada '||ROUND(a_pagar,2)|| ' Abono Total '||ROUND(abono,2));
                        EXIT;
                    ELSE
                        a_pagar := (paq_lista(i).precio - abono)/2;
                        a_pagar := DBMS_RANDOM.VALUE (1, a_pagar);
                        abono := a_pagar + abono;
                        dbms_output.put_line('                      '||op_metodos.nombre||' Cantidad Abonada '||ROUND(a_pagar,2)|| ' Abono Total '||ROUND(abono,2));
                    END IF;
                END LOOP;
            END LOOP;        
        END IF;
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
        END LOOP;
    END;
END;