CREATE OR REPLACE PROCEDURE SIMULACION(tiempo NUMBER)
IS
    fecha_inicio_sim DATE := SYSDATE;
    fecha_fin_sim DATE;
    contador_meses NUMBER := 0;
BEGIN
    dbms_output.put_line('************************************');
    dbms_output.put_line('*                                  *');
    dbms_output.put_line('*   SIMULACION ESTRELLA CARIBEÑA   *');
    dbms_output.put_line('*                                  *');
    dbms_output.put_line('************************************');
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    MODULO_INICIO.INICIO;
    MODULO_INICIO.SELECCIONAR_TEMPORALIDAD(tiempo,fecha_inicio_sim,fecha_fin_sim);
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Asignandole los Paises a los Clientes');
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    MODULO_INICIO.ASIGNAR_PAISES;
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Generando Alianzas con los Proveedores');
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    MODULO_INICIO.GENERAR_ALIANZAS;
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Generando Servicios');
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    MODULO_INICIO.GENERAR_SERVICIOS(NULL);
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
    dbms_output.put_line('Inicio de la Simulacion!');
    WHILE fecha_inicio_sim <= fecha_fin_sim LOOP
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');
        dbms_output.put_line('Fecha de Simulacion: '||fecha_inicio_sim);
        dbms_output.put_line(' ');
        dbms_output.put_line(' ');

        -- GENERANDO Disponibilidades de Servicios y Paquetes
        -- TODO: contador_meses debe ser cero para que se genere la disponibilidad de los servicios al inicio de la simulación
        IF (contador_meses=3) THEN
            dbms_output.put_line('Generando Disponibilidades de Servicios');
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            MODULO_SERVICIO.GENERAR_DISPONIBILIDAD(fecha_inicio_sim+15,fecha_inicio_sim,1);
            MODULO_SERVICIO.GENERAR_DISPONIBILIDAD(fecha_inicio_sim+15,fecha_inicio_sim,NULL);
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            dbms_output.put_line('Generando Paquetes de Servicios');
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            FOR r_dest IN (SELECT * FROM DESTINO) LOOP
                dbms_output.put_line('Destino: ' || r_dest.nombre);
                dbms_output.put_line(' ');
                dbms_output.put_line(' ');
                MODULO_PAQUETE.GENERAR_PAQUETES(r_dest.id_destino,fecha_inicio_sim);
                IF aceptar_o_rechazar(0.2) THEN
                    MODULO_PAQUETE.GENERAR_PAQUETES(r_dest.id_destino,fecha_inicio_sim);
                END IF;
            END LOOP;
            contador_meses := 0;
        END IF; 
        -- Comprando Paquetes
        FOR cli_aleatorio IN (SELECT * FROM CLIENTE ORDER BY DBMS_RANDOM.RANDOM ASC FETCH FIRST 5 ROWS ONLY) LOOP
            dbms_output.put_line(' ');
            dbms_output.put_line(' ');
            MODULO_COMPRA.COMPRAR_PAQUETE(cli_aleatorio.id_cliente,fecha_inicio_sim);
        END LOOP;
        fecha_inicio_sim := fecha_inicio_sim + 7;
        contador_meses := contador_meses + 1;
    END LOOP;
END;
