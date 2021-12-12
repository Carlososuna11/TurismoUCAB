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
    SELECT dest.nombre "Destino Turistico",
    t1.col1 "Fecha desde",
    t1.col2 "Fecha Hasta",
    dest.foto "Foto",
    dest.video "Video",
    dest.descripcion "Descripción"
    FROM DESTINO dest
    INNER JOIN (
        SELECT dest.id_destino "id_destino", 
        MIN(disp.fecha.fechaInicio) "min_fecha",
        MAX(disp.fecha.fechaFin) "max_fecha"
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