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
    WHERE (disp.fecha.fechaInicio >= fechaInicio OR fechaInicio IS NULL) AND 
    ( disp.fecha.fechaFin <= fechaFin OR fechaFin IS NULL) AND
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
        WHERE (disp.fecha.fechaInicio >= fechaInicio OR fechaInicio IS NULL) AND 
        ( disp.fecha.fechaFin <= fechaFin OR fechaFin IS NULL)
        GROUP BY dest.id_destino
    ) aux ON aux.id_destino =  dest.id_destino;
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
    WHERE (paq.fechas.fechaInicio >= fechaInicio OR fechaInicio IS NULL) AND 
    ( paq.fechas.fechaFin <= fechaFin OR fechaFin IS NULL) AND
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
    CONCAT(CONCAT('$ ',paq.precio),' por persona') "Costo",
    CONCAT(CONCAT(cli.datos.nombre,' '),cli.datos.apellido) "Cliente",
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
        det.factura_id,
        LISTAGG('$ '|| ROUND(mpa.cantidad,2) ||' - '|| mpa.forma ,chr(13) || chr(10) )  WITHIN GROUP (ORDER BY mpa.cantidad) as forma_pago
        FROM DETFACTURA det
        INNER JOIN MPAGO mpa
        ON mpa.detFactura_id = det.id_detFactura
        GROUP BY det.factura_id
    ) aux 
    ON aux.factura_id = det.factura_id
    INNER JOIN DESTINO dest
    ON dest.id_destino = paq.destino_id
    INNER JOIN PROPIETARIO prop
    ON prop.paquete_id = paq.id_paquete
    INNER JOIN CLIENTE cli
    ON cli.id_cliente = prop.cliente_id
    WHERE (paq.fechas.fechaInicio >= fechaInicio OR fechaInicio IS NULL) AND 
    ( paq.fechas.fechaFin <= fechaFin OR fechaFin IS NULL) AND
    ( fac.dispositivo = dispositivo_compra OR dispositivo_compra IS NULL);
END;