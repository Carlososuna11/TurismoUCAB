CREATE OR REPLACE PROCEDURE REPORTE_1 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE, destino_nombre VARCHAR2, destinoID NUMBER)
AS
BEGIN
    OPEN cursorMemoria FOR 
    SELECT MIN(disp.fecha_creacion) "Fecha de Creacion",
    MIN(disp.fecha.fechaInicio) "Fecha desde",
    MAX(disp.fecha.fechaFin) "Fecha hasta",
    LISTAGG(DISTINCT dest.nombre,'') "Destino",
    LISTAGG(DISTINCT '- '|| serv.nombre ,chr(13) || chr(10) )  WITHIN GROUP (ORDER BY serv.nombre) "Servicios Ofrecidos"
    FROM SERVICIO serv
    INNER JOIN DISPONIBILIDAD disp
    ON disp.id_servicio = serv.id_servicio
    INNER JOIN DESTINO dest
    ON dest.id_destino = serv.destino_id
    WHERE (TO_DATE(disp.fecha.fechaInicio,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
    ( TO_DATE(disp.fecha.fechaFin,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL) AND
    ( dest.nombre = destino_nombre OR destino_nombre IS NULL) AND
    (serv.destino_id = destinoID OR destinoID IS NULL)
    GROUP BY serv.destino_id;
END;

CREATE OR REPLACE PROCEDURE REPORTE_2 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE)
AS
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    dest.nombre "Destino Turistico",
    aux.fechaDesde "Fecha Desde",
    aux.fechaHasta "Fecha Hasta",
    dest.foto "Foto",
    dest.video "Video",
    dest.descripcion "Descripción"
    FROM DESTINO dest
    INNER JOIN (
        SELECT dest.id_destino, 
        MIN(disp.fecha.fechaInicio) as fechaDesde,
        MAX(disp.fecha.fechaFin) as fechaHasta
        FROM DESTINO dest
        INNER JOIN SERVICIO serv
        ON serv.destino_id = dest.id_destino
        INNER JOIN DISPONIBILIDAD disp
        ON disp.id_servicio = serv.id_servicio
        GROUP BY dest.id_destino
    ) aux ON aux.id_destino =  dest.id_destino
    WHERE (TO_DATE(aux.fechaDesde,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
        (TO_DATE(aux.fechaHasta,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL);
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_3 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE, destino_nombre VARCHAR2, destinoID NUMBER) 
AS
begin
  OPEN cursorMemoria FOR
    SELECT
    dest.nombre "Destino Turistico",
    paq.fechas.fechaInicio "Fecha Desde",
    paq.fechas.fechaFin "Fecha Hasta",
    dest.foto "Foto",
    aux.caracteristicas "Caracteristicas",
    CONCAT(CONCAT('$ ',paq.precio),' por persona') "Costo"
    FROM DESTINO dest
    INNER JOIN PAQUETE paq
    ON paq.destino_id = dest.id_destino
    INNER JOIN (
        SELECT
        dest.id_destino,
        paq.id_paquete,
        LISTAGG(DISTINCT '- '|| serv.nombre ,chr(13) || chr(10) )  WITHIN GROUP (ORDER BY serv.nombre) as caracteristicas
        FROM DESTINO dest
        INNER JOIN PAQUETE paq
        ON paq.destino_id = dest.id_destino
        INNER JOIN SUBSCRIPCION sub
        ON sub.paquete_id = paq.id_paquete
        INNER JOIN DISPONIBILIDAD disp
        ON disp.id_disponibilidad = sub.disponibilidad_id
        INNER JOIN SERVICIO serv
        ON serv.id_servicio = disp.id_servicio
        GROUP BY dest.id_destino, paq.id_paquete 
    ) aux
    ON aux.id_paquete = paq.id_paquete
    WHERE (TO_DATE(paq.fechas.fechaInicio,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
    ( TO_DATE(paq.fechas.fechaFin,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL) AND
    ( dest.nombre = destino_nombre OR destino_nombre IS NULL) AND
    (dest.id_destino = destinoID OR destinoID IS NULL);
end;
/
CREATE OR REPLACE PROCEDURE REPORTE_4 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE, dispositivo_compra VARCHAR2)
AS
BEGIN
    OPEN cursorMemoria FOR
    SELECT
    dest.nombre "Destino Turistico",
    paq.fechas.fechaInicio "Fecha Desde",
    paq.fechas.fechaFin "Fecha Hasta",
    dest.foto "Foto",
    caracteristicas "Caracteristicas",
    CONCAT(CONCAT('$ ',paq.precio),' por persona') "Costo",
    CONCAT(CONCAT(cli.datos.nombre,' '),cli.datos.apellido) "Cliente",
    cli.datos.correo "Email",
    aux.forma_pago "Forma de Pago",
    paq_medio.canal "Canal Utilizado",
    fac.dispositivo "Dispositivo"
    FROM DETFACTURA det
    INNER JOIN FACTURA fac
    ON fac.id_factura = det.factura_id
    INNER JOIN PAQUETE paq
    ON paq.id_paquete = det.paquete_id
    INNER JOIN MEDIO paq_medio
    ON paq_medio.id_medio = fac.medio_id
    INNER JOIN (
        SELECT
        det.id_detFactura,
        LISTAGG('$ '|| ROUND(mpa.cantidad,2) ||' - '|| mpa.forma ,chr(13) || chr(10) )  WITHIN GROUP (ORDER BY mpa.cantidad) as forma_pago
        FROM DETFACTURA det
        INNER JOIN MPAGO mpa
        ON mpa.detFactura_id = det.id_detFactura
        GROUP BY det.id_detFactura
    ) aux 
    ON aux.id_detFactura = det.id_detFactura
    INNER JOIN (
        SELECT
        dest.id_destino,
        paq.id_paquete,
        LISTAGG(DISTINCT '- '|| serv.nombre ,chr(13) || chr(10) )  WITHIN GROUP (ORDER BY serv.nombre) as caracteristicas
        FROM DESTINO dest
        INNER JOIN PAQUETE paq
        ON paq.destino_id = dest.id_destino
        INNER JOIN SUBSCRIPCION sub
        ON sub.paquete_id = paq.id_paquete
        INNER JOIN DISPONIBILIDAD disp
        ON disp.id_disponibilidad = sub.disponibilidad_id
        INNER JOIN SERVICIO serv
        ON serv.id_servicio = disp.id_servicio
        GROUP BY dest.id_destino, paq.id_paquete 
    ) aux2
    ON aux2.id_paquete = paq.id_paquete
    INNER JOIN DESTINO dest
    ON dest.id_destino = paq.destino_id
    INNER JOIN PROPIETARIO prop
    ON prop.paquete_id = paq.id_paquete
    INNER JOIN CLIENTE cli
    ON cli.id_cliente = prop.cliente_id
    WHERE (TO_DATE(paq.fechas.fechaInicio,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
    ( TO_DATE(paq.fechas.fechaFin,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL) AND
    ( fac.dispositivo = dispositivo_compra OR dispositivo_compra IS NULL);
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_5 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE, fechaProx IN DATE)
AS /*TODO: FechaProx es = o =>*/
BEGIN
    OPEN cursorMemoria FOR 
    SELECT cru.id_crucero "ID Crucero",
    cru.foto "Foto",
    TO_CHAR(mant.fecha.fechaInicio,'dd/MM/YYYY') "Fecha Mantenimiento",
    TO_CHAR(mant.fecha_prox,'dd/MM/YYYY') "Fecha de próximo mantenimiento",
    mant.descripcion "Descripcion Mantenimiento",
    CONCAT('$ ',mant.costo) "Costo"
    FROM CRUCERO cru
    INNER JOIN MANTENIMIENTO mant
    ON cru.id_crucero = mant.crucero_id
    WHERE (TO_DATE(mant.fecha.fechaInicio,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
    ( TO_DATE(mant.fecha.fechaInicio,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL) AND
    (TO_DATE(mant.fecha_prox,'dd/MM/YYYY') = TO_DATE(fechaProx,'dd/MM/YYYY') OR fechaProx IS NULL);
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_6 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, categoriaServicio IN VARCHAR2)
AS
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    to_char(disp.fecha.fechaInicio, 'MONTH YYYY') "Mes",
    serv.nombre "Categoria de Servicio",
    CONCAT(ROUND((SUM(disp.balance.numeroVentas) / SUM(disp.balance.existencia))*100,2), ' %')  "% Demanda del Servicio",
    SUM(disp.balance.numeroVentas) "Cantidad de clientes que lo han solicitado"
    FROM SERVICIO serv
    INNER JOIN DISPONIBILIDAD disp
    ON disp.id_servicio = serv.id_servicio
    WHERE disp.balance.existencia > 0 AND
    (serv.nombre = categoriaServicio OR categoriaServicio IS NULL) AND
    (TO_CHAR(disp.fecha.fechaInicio,'MM/YYYY') = TO_CHAR(fechaMes,'MM/YYYY') OR fechaMes IS NULL)
    GROUP BY to_char(disp.fecha.fechaInicio, 'MONTH YYYY'),serv.nombre
    ORDER BY TO_DATE(to_char(disp.fecha.fechaInicio, 'MONTH YYYY'), 'MONTH YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_7 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, categoriaServicio IN VARCHAR2)
AS
BEGIN
    OPEN cursorMemoria FOR 
        SELECT 
        to_char(disp.fecha.fechaInicio, 'MONTH YYYY') "Mes",
        'Gastos' as Gastos,
        'Ingresos' as Ingresos,
        ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(disp.fecha.fechaInicio, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
        serv.nombre "Categoria de Servicio",
        ROUND(SUM(disp.balance.egreso),2) "Costos directos e Indirectos" ,
        ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2) "Ingresos recibidos por el servicio",
        ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario))-SUM(disp.balance.egreso),2) "Ganancia"
        FROM SERVICIO serv
        INNER JOIN DISPONIBILIDAD disp
        ON disp.id_servicio = serv.id_servicio
        WHERE disp.balance.existencia > 0 AND
        (serv.nombre = categoriaServicio OR categoriaServicio IS NULL) AND
        (TO_CHAR(disp.fecha.fechaInicio,'MM/YYYY') = TO_CHAR(fechaMes,'MM/YYYY') OR fechaMes IS NULL)
        GROUP BY to_char(disp.fecha.fechaInicio, 'MONTH YYYY'),serv.nombre
        HAVING ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2) > 0
        ORDER BY TO_DATE(to_char(disp.fecha.fechaInicio, 'MONTH YYYY'), 'MONTH YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_7_G (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, categoriaServicio IN VARCHAR2, filax IN NUMBER)
AS
BEGIN
    OPEN cursorMemoria FOR 
        SELECT* FROM (SELECT 
        to_char(disp.fecha.fechaInicio, 'MONTH YYYY') "Mes",
        'Gastos' as Gastos,
        'Ingresos' as Ingresos,
        ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(disp.fecha.fechaInicio, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
        serv.nombre "Categoria de Servicio",
        ROUND(((ROUND(SUM(disp.balance.egreso),2)*100)/(ROUND(SUM(disp.balance.egreso),2)+ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2))),2) "Costos directos e Indirectos",
        ROUND(((ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2)*100)/(ROUND(SUM(disp.balance.egreso),2)+ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2))),2) "Ingresos recibidos por el servicio",
        ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario))-SUM(disp.balance.egreso),2) "Ganancia"
        FROM SERVICIO serv
        INNER JOIN DISPONIBILIDAD disp
        ON disp.id_servicio = serv.id_servicio
        WHERE disp.balance.existencia > 0 AND
        (serv.nombre = categoriaServicio OR categoriaServicio IS NULL) AND
        (TO_CHAR(disp.fecha.fechaInicio,'MM/YYYY') = TO_CHAR(fechaMes,'MM/YYYY') OR fechaMes IS NULL)
        GROUP BY to_char(disp.fecha.fechaInicio, 'MONTH YYYY'),serv.nombre
        HAVING ROUND(SUM(BALANCE.calcularIngreso(disp.balance.numeroVentas,disp.balance.precio_unitario)),2) > 0
        ORDER BY TO_DATE(to_char(disp.fecha.fechaInicio, 'MONTH YYYY'), 'MONTH YYYY') ASC)
        unpivot( quantity  -- unpivot_clause
        FOR tipo --  unpivot_for_clause
        IN ( -- unpivot_in_clause
            "Ingresos recibidos por el servicio" AS 'INGRESOS',
            "Costos directos e Indirectos" AS 'GASTOS'
        ))
        WHERE (trunc(Fila) = trunc(filax));
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_8 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    to_char(fact.fecha, 'MONTH YYYY') "Mes",
    ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
    ROUND((COUNT(tdc.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2) "TDC",
    ROUND((COUNT(wallet.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2)  "WALLET",
    ROUND((COUNT(cripto.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2) "CRIPTOMONEDAS"
    FROM FACTURA fact
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'TDC'
    ) tdc
    ON fact.id_factura = tdc.detFactura_factura_id
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'Wallet'
    ) wallet
    ON fact.id_factura = wallet.detFactura_factura_id
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'Criptomonedas'
    ) cripto
    ON fact.id_factura = cripto.detFactura_factura_id
    WHERE (TO_CHAR(fact.fecha, 'MM/YYYY') = TO_CHAR(fechaMes,'MM/YYYY') OR fechaMes IS NULL)
    GROUP BY to_char(fact.fecha, 'MONTH YYYY')
    ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_8_G (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, filax IN NUMBER)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT * FROM (
    SELECT 
    to_char(fact.fecha, 'MONTH YYYY') "Mes",
    ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
    ROUND((COUNT(tdc.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2) "TDC",
    ROUND((COUNT(wallet.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2)  "WALLET",
    ROUND((COUNT(cripto.id_mpago)*100)/(COUNT(tdc.id_mpago)+ COUNT(wallet.id_mpago)+COUNT(cripto.id_mpago)),2) "CRIPTOMONEDAS"
    FROM FACTURA fact
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'TDC'
    ) tdc
    ON fact.id_factura = tdc.detFactura_factura_id
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'Wallet'
    ) wallet
    ON fact.id_factura = wallet.detFactura_factura_id
    LEFT JOIN (
        SELECT
        mp.id_mpago,
        mp.detFactura_factura_id
        FROM MPAGO mp
        WHERE mp.forma = 'Criptomonedas'
    ) cripto
    ON fact.id_factura = cripto.detFactura_factura_id
    WHERE (TO_CHAR(fact.fecha, 'MM/YYYY') = TO_CHAR(fechaMes,'MM/YYYY') OR fechaMes IS NULL)
    GROUP BY to_char(fact.fecha, 'MONTH YYYY')
    ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY') ASC)
    unpivot( quantity  -- unpivot_clause
        FOR tipo --  unpivot_for_clause
        IN ( -- unpivot_in_clause
            "TDC" AS 'TDC',
            "WALLET" AS 'WALLET',
            "CRIPTOMONEDAS" AS 'CRIPTOMONEDAS'
        ))
        WHERE (trunc(Fila) = trunc(filax));
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_9 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE, fechaFin IN DATE)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    TO_CHAR(ali.fecha.fechaInicio,'dd/MM/YYYY') "Fecha inicio de Alianza",
    prov.nombre "Nombre Proveedor",
    prov.logo "Logo",
    prov.foto "Foto"
    FROM ALIANZA ali
    INNER JOIN PROVEEDOR prov
    ON ali.proveedor_id = prov.id_proveedor
    WHERE (TO_DATE(ali.fecha.fechaInicio, 'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY')  OR fechaInicio IS NULL)
    AND (TO_DATE(ali.fecha.fechaInicio, 'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY')  OR fechaFin IS NULL)
    ORDER BY TO_DATE(ali.fecha.fechaInicio, 'dd/MM/YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_10 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    to_char(venta.fecha_mes, 'MONTH YYYY') "Mes",
    comp.nombre "Competencia",
    comp.logo "Foto Logo",
    venta.cantidad "Ventas Competencia",
    venta_ec.cantidad "Ventas Estrella Caribeña"
    FROM VENTA venta
    INNER JOIN COMPETENCIA comp
    ON venta.competencia_id = comp.id_competencia
    INNER JOIN (
        SELECT 
        to_char(fact.fecha, 'MONTH YYYY') as fecha_mes,
        COUNT(detf.paquete_id) as cantidad
        FROM DETFACTURA detf
        INNER JOIN FACTURA fact
        ON detf.factura_id = fact.id_factura
        GROUP BY to_char(fact.fecha, 'MONTH YYYY')
    )
    venta_ec
    ON  to_char(venta.fecha_mes, 'MONTH YYYY') = venta_ec.fecha_mes
    WHERE (to_char(venta.fecha_mes, 'MONTH YYYY') = to_char(fechaMes,'MONTH YYYY')  OR fechaMes IS NULL)
    ORDER BY TO_DATE(venta.fecha_mes, 'dd/MM/YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_11 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, paisnombre IN VARCHAR2)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    aux.fecha_mes "Mes",
    pa.foto "Foto Pais",
    pa.nombre "Pais",
    aux.cantidad "Unidades Compradas"
    FROM PAIS pa
    INNER JOIN (
        SELECT 
        TO_CHAR(fact.fecha, 'MONTH YYYY') as fecha_mes,
        pa.id_pais,
        COUNT(detf.id_detFactura) as cantidad
        FROM PAIS pa
        INNER JOIN CLIENTE cli
        ON pa.id_pais = cli.pais_id
        INNER JOIN FACTURA fact
        ON cli.id_cliente = fact.cliente_id
        INNER JOIN DETFACTURA detf
        ON fact.id_factura = detf.factura_id
        GROUP BY TO_CHAR(fact.fecha, 'MONTH YYYY'), pa.id_pais
    ) aux
    ON pa.id_pais = aux.id_pais
    WHERE (aux.fecha_mes = to_char(fechaMes,'MONTH YYYY')  OR fechaMes IS NULL) 
    AND (pa.nombre = paisnombre OR paisnombre IS NULL)
    ORDER BY TO_DATE(aux.fecha_mes, 'MONTH YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_12 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    to_char(fact.fecha, 'MONTH YYYY') "Mes",
    ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
    ROUND((COUNT(agencia.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Agencia Fisica",
    ROUND((COUNT(aplicacion.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Aplicacion Movil",
    ROUND((COUNT(paginaweb.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Pagina Web",
    ROUND((COUNT(whatsapp.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Whatsapp",
    ROUND((COUNT(instagram.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Instagram"
    FROM FACTURA fact
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Agencia Fisica'
    ) agencia
    ON fact.medio_id = agencia.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Aplicacion Movil'
    ) aplicacion
    ON fact.medio_id = aplicacion.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Pagina Web'
    ) paginaweb
    ON fact.medio_id = paginaweb.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Whatsapp'
    ) whatsapp
    ON fact.medio_id = whatsapp.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Instagram'
    ) instagram
    ON fact.medio_id = instagram.id_medio
    WHERE (to_char(fact.fecha, 'MONTH YYYY') = to_char(fechaMes,'MONTH YYYY')  OR fechaMes IS NULL)
    GROUP BY to_char(fact.fecha, 'MONTH YYYY')
    ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY') ASC;
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_12_G (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, filax IN NUMBER)
AS 
BEGIN
    OPEN cursorMemoria FOR 
    SELECT * FROM (
    SELECT 
    to_char(fact.fecha, 'MONTH YYYY') "Mes",
    ROW_NUMBER() OVER (ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY')) as Fila,
    ROUND((COUNT(agencia.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Agencia Fisica",
    ROUND((COUNT(aplicacion.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Aplicacion Movil",
    ROUND((COUNT(paginaweb.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Pagina Web",
    ROUND((COUNT(whatsapp.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Whatsapp",
    ROUND((COUNT(instagram.canal)*100)/(COUNT(agencia.canal)+COUNT(aplicacion.canal)+COUNT(paginaweb.canal)+COUNT(whatsapp.canal)+COUNT(instagram.canal)),2) "Instagram"
    FROM FACTURA fact
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Agencia Fisica'
    ) agencia
    ON fact.medio_id = agencia.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Aplicacion Movil'
    ) aplicacion
    ON fact.medio_id = aplicacion.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Pagina Web'
    ) paginaweb
    ON fact.medio_id = paginaweb.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Whatsapp'
    ) whatsapp
    ON fact.medio_id = whatsapp.id_medio
    LEFT JOIN (
        SELECT
        m.id_medio,
        m.canal
        FROM MEDIO m
        WHERE m.canal = 'Instagram'
    ) instagram
    ON fact.medio_id = instagram.id_medio
    WHERE (to_char(fact.fecha, 'MONTH YYYY') = to_char(fechaMes,'MONTH YYYY')  OR fechaMes IS NULL)
    GROUP BY to_char(fact.fecha, 'MONTH YYYY')
    ORDER BY TO_DATE(to_char(fact.fecha, 'MONTH YYYY'), 'MONTH YYYY') ASC)
    unpivot( quantity  -- unpivot_clause
        FOR tipo --  unpivot_for_clause
        IN ( -- unpivot_in_clause
            "Agencia Fisica" AS 'Agencia Fisica',
            "Aplicacion Movil" AS 'Aplicacion Movil',
            "Pagina Web" AS 'Pagina Web',
            "Whatsapp" AS 'Whatsapp',
            "Instagram" AS 'Instagram'
        ))
    WHERE (trunc(Fila) = trunc(filax));

END;
/
CREATE OR REPLACE PROCEDURE REPORTE_13 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE,escala IN VARCHAR2)
AS
BEGIN
    OPEN cursorMemoria FOR 
    SELECT * FROM (
    SELECT
    TO_CHAR(obs.fechaCreacion, 'MONTH YYYY') "Mes",
    serv.nombre "Servicio",
    ROUND(AVG(obs.escala)) "Escala",
    CASE
        WHEN ROUND(AVG(obs.escala)) > 2 AND ROUND(AVG(obs.escala)) < 4  THEN 'Neutral'
        WHEN ROUND(AVG(obs.escala)) >= 4 THEN 'Muy Satisfecho'
        ELSE 'Insatisfecho'
    END AS valoracion,
    CASE
        WHEN ROUND(AVG(obs.escala)) > 2 AND ROUND(AVG(obs.escala)) < 4  THEN ':|'
        WHEN ROUND(AVG(obs.escala)) >= 4 THEN '<style forecolor="green">:-)</style>'
        ELSE '<style forecolor="red">:(</style>'
    END AS carita,
    LISTAGG('- ' || obs.descripcion,chr(13) || chr(10)) WITHIN GROUP (ORDER BY obs.fechaCreacion) "Observaciones"
    FROM OBSERVACION obs
    INNER JOIN SERVICIO serv
    ON serv.id_servicio = obs.servicio_id
    WHERE (TO_CHAR(obs.fechaCreacion, 'MONTH YYYY') = to_char(fechaMes,'MONTH YYYY')  OR fechaMes IS NULL)
    GROUP BY TO_CHAR(obs.fechaCreacion, 'MONTH YYYY'), serv.nombre
    ORDER BY TO_DATE(TO_CHAR(obs.fechaCreacion, 'MONTH YYYY'), 'MONTH YYYY') ASC)
    WHERE (valoracion = escala OR escala IS NULL);
END;
/
