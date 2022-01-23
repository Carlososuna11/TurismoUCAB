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
AS /* TODO: LISTO, CREO */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT cru.id "ID Crucero",
    cru.foto "Foto",
    mant.fecha.fechaInicio "Fecha Mantenimiento",
    mant.descripcion "Descripcion Mantenimiento",
    mant.fecha_prox "Fecha de próximo mantenimiento",
    mant.costo "Costo"
    FROM CRUCERO cru
    INNER JOIN MANTENIMIENTO mant
    ON cru.id = mant.crucero_id
    WHERE (TO_DATE(mant.fecha.fechaInicio,'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY') OR fechaInicio IS NULL) AND 
    ( TO_DATE(mant.fecha.fechaFin,'dd/MM/YYYY') <= TO_DATE(fechaFin,'dd/MM/YYYY') OR fechaFin IS NULL)
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_6 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, categoriaServicio IN INT)
AS /* TODO: NO SUPE HACER NADA XD */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    FROM SERVICIO serv
    WHERE serv.id == categoriaServicio
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_7 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, categoriaServicio IN INT)
AS /* TODO: UNIR LOS QUERY Y CALCULAR GANANCIA Y GRAFICOS */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT mant.costo "Costo"
    FROM MANTENIMIENTO mant
    INNER JOIN (
        SELECT cru.id,
        FROM SERVICIO serv
        INNER JOIN CRUCERO cru
        ON cru.id = serv.crucero_id
        WHERE serv.id == categoriaServicio
    ) aux ON aux.id =  mant.crucero_id
    INNER JOIN CRUCERO cru
    ON aux.id = mant.crucero_id
    WHERE (TO_DATE(mant.fecha.fechaInicio,'dd/MM/YYYY') == TO_DATE(fechaMes,'dd/MM/YYYY') OR fechaMes IS NULL)
    GROUP BY mant.id

    SELECT detFact.precio "Precio"
    FROM DETFACTURA detFact
    INNER JOIN PAQUETE paq
    ON paq.id = detFact.paquete_id
    INNER JOIN (
        SELECT dest.id,
        FROM SERVICIO serv
        INNER JOIN DESTINO dest
        ON dest.id = serv.destino_id
        WHERE serv.id == categoriaServicio
    ) aux ON aux.id =  paq.destino_id
    WHERE (TO_DATE(paq.fecha.fechaInicio,'dd/MM/YYYY') == TO_DATE(fechaMes,'dd/MM/YYYY') OR fechaMes IS NULL)
    GROUP BY detFact.id

END;
/
CREATE OR REPLACE PROCEDURE REPORTE_8 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS /* TODO: SUMAR LOS MEDIOS DE PAGO Y SACAR % Y GRAFICA */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT mpago.forma "Medio de pago",
    paq.fecha.fechaInicio "Mes"
    FROM DETFACTURA det
    INNER JOIN PAQUETE paq
    ON paq.id_paquete = det.paquete_id
    INNER JOIN MPAGO mpago
    ON mpago.detFactura_id = det.id
    WHERE (TO_DATE(paq.fecha.fechaInicio,'dd/MM/YYYY') == TO_DATE(fechaMes,'dd/MM/YYYY') OR fechaMes IS NULL)
    GROUP BY mpago.forma
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_9 (cursorMemoria OUT SYS_REFCURSOR, fechaInicio IN DATE)
AS /* TODO: LISTO, CREO */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT ali.fecha.fechaInicio "Fecha inicio de Alianza",
    prov.nombre "Nombre Proveedor",
    prov.logo "Logo",
    prov.foto "Foto",
    FROM ALIANZA ali
    INNER JOIN PROVEEDOR prov
    ON ali.proveedor_id = prov.id
    WHERE (TO_DATE(ali.fecha.fechaInicio, 'dd/MM/YYYY') >= TO_DATE(fechaInicio,'dd/MM/YYYY')  OR fechaInicio IS NULL)
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_10 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS /* TODO: UNIR LOS QUERYS Y HACER LA SUMA DE CANTIDAD DE PAQUETES DE ESTRELLA CARIBEÑA */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT 
    FROM DETFACTURA det
    INNER JOIN PAQUETE paq
    ON paq.id = det.paquete_id
    INNER JOIN FACTURA fac
    ON fac.id = det.factura_id
    WHERE (TO_DATE(paq.fecha.fechaInicio, 'dd/MM/YYYY') >= TO_DATE(fechaMes,'dd/MM/YYYY')  OR fechaMes IS NULL)

    SELECT venta.cantidad "Cantidad Competencia",
    veta.fechaMes "Fecha de ventas",
    comp.foto "Foto Logo",
    comp.nombre "Competencia"
    FROM VENTA venta
    INNER JOIN COMPETENCIA comp
    ON venta.competencia_id = comp.id
    WHERE (TO_DATE(paq.fecha.fechaInicio, 'dd/MM/YYYY') >= TO_DATE(fechaMes,'dd/MM/YYYY')  OR fechaMes IS NULL)
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_11 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE, pais IN VARCHAR2)
AS /* TODO: HACER LA SUMA DE LA CANTIDAD DE PAQUETES */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT pais.nombre "País",
    pais.foto "Foto País",
    paq.fecha.fechaInicio "Fecha",
    FROM PROPIETARIO pro
    INNER JOIN PAQUETE paq
    ON pro.paquete_id = paq.id
    INNER JOIN CLIENTE cli
    ON pro.cliente_id = cli.id
    INNER JOIN PAIS pais
    ON pais.id = cli.pais_id
    WHERE (TO_DATE(paq.fecha.fechaInicio, 'dd/MM/YYYY') >= TO_DATE(fechaMes,'dd/MM/YYYY')  OR fechaMes IS NULL) AND pais.nombre == pais
    GROUP BY pais.nombre, paq.fecha.fechaInicio
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_12 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS /* TODO: SACAR LOS % Y GRAFICA */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT pago_medio.canal "Canal utilizado",
    paq.fecha.fechaInicio "Mes"
    FROM DETFACTURA det
    INNER JOIN FACTURA fact
    ON fact.id = det.factura_id
    INNER JOIN PAQUETE paq
    ON paq.id_paquete = det.paquete_id
    INNER JOIN MEDIO pago_medio
    ON pago_medio.id = fact.medio_id
    WHERE (TO_DATE(paq.fecha.fechaInicio,'dd/MM/YYYY') == TO_DATE(fechaMes,'dd/MM/YYYY') OR fechaMes IS NULL)
    GROUP BY pago_medio.canal
END;
/
CREATE OR REPLACE PROCEDURE REPORTE_13 (cursorMemoria OUT SYS_REFCURSOR, fechaMes IN DATE)
AS /* TODO: SACAR PROMEDIO DE LAS OBSERVACIONES Y AGRUPAR COMENTARIOS POR SERVICIO */
BEGIN
    OPEN cursorMemoria FOR 
    SELECT obs.escala "Puntaje",
    obs.descripcion "Comentario",
    serv.nombre "Servicio",
    FROM SERVICIO serv
    INNER JOIN OBSERVACION obs
    ON serv.id = obs.servicio_id
    INNER JOIN DESTINO dest
    ON dest.id = serv.destino_id
    INNER JOIN PAQUETE paq
    ON dest.id = paq.destino_id
    WHERE (TO_DATE(paq.fecha.fechaInicio,'dd/MM/YYYY') == TO_DATE(fechaMes,'dd/MM/YYYY') OR fechaMes IS NULL)
    GROUP BY serv.id
END;
/
