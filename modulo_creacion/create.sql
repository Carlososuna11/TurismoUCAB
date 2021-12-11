
CREATE TABLE PROVEEDOR (
    id_proveedor NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    logo BLOB NOT NULL,
    foto BLOB NOT NULL
);

/
CREATE TABLE PAIS (
    id_pais NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    foto BLOB NOT NULL,
    nacionalidad VARCHAR2(50)
);

/
CREATE TABLE CRUCERO (
    id_crucero NUMBER PRIMARY KEY,
    foto BLOB NOT NULL
);

/
CREATE TABLE DESTINO (
    id_destino NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(2500) NOT NULL,
    foto BLOB NOT NULL,
    video BLOB NOT NULL
);

/
CREATE TABLE ALIANZA (
    id_alianza NUMBER NOT NULL,
    fecha FECHA_RANGO NOT NULL,
    proveedor_id NUMBER NOT NULL,
    CONSTRAINT FK_PROVEEDOR FOREIGN KEY (proveedor_id)
    REFERENCES PROVEEDOR(id_proveedor),
    CONSTRAINT pk_alianza PRIMARY KEY (id_alianza, proveedor_id)
);

/
CREATE TABLE SERVICIO (
    id_servicio NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    vacunado NUMBER(1),
    crucero_id NUMBER,
    destino_id NUMBER NOT NULL,
    alianza_id NUMBER,
    proveedor_id NUMBER,
    CONSTRAINT FK_CRUCERO FOREIGN KEY (crucero_id)
    REFERENCES CRUCERO(id_crucero),
    CONSTRAINT FK_DESTINO FOREIGN KEY (destino_id)
    REFERENCES DESTINO(id_destino),
    CONSTRAINT FK_ALIANZA FOREIGN KEY (alianza_id, proveedor_id)
    REFERENCES ALIANZA(id_alianza, proveedor_id)
);

/
CREATE TABLE DISPONIBILIDAD (
    id_disponibilidad NUMBER NOT NULL,
    fecha FECHA_RANGO NOT NULL,
    balance BALANCE NOT NULL,
    id_servicio NUMBER NOT NULL,
    fecha_creacion DATE NOT NULL,
    CONSTRAINT FK_SERVICIO FOREIGN KEY (id_servicio)
    REFERENCES SERVICIO(id_servicio),
    CONSTRAINT pk_disponibilidad PRIMARY KEY (id_disponibilidad, id_servicio)
);

/
CREATE TABLE MANTENIMIENTO (
    id_mantenimiento NUMBER PRIMARY KEY,
    fecha FECHA_RANGO NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    fecha_prox DATE NOT NULL,
    costo DECIMAL(10,2),
    crucero_id NUMBER NOT NULL,
    CONSTRAINT FK_CRUCERO_MANTENIMIENTO FOREIGN KEY (crucero_id)
    REFERENCES CRUCERO(id_crucero)
);

/
CREATE TABLE CLIENTE (
    id_cliente NUMBER PRIMARY KEY,
    datos DATOS_USUARIO NOT NULL,
    vacunado NUMBER(1) NOT NULL,
    pais_id NUMBER,
    CONSTRAINT FK_PAIS FOREIGN KEY (pais_id)
    REFERENCES PAIS(id_pais)
);

/
CREATE TABLE OBSERVACION (
    id_observacion NUMBER,
    fechaCreacion DATE NOT NULL,
    escala DECIMAL(2,1) NOT NULL,
    descripcion VARCHAR2(250),
    servicio_id NUMBER NOT NULL,
    cliente_id NUMBER NOT NULL,
    CONSTRAINT FK_SERVICIO_CLIENTE FOREIGN KEY (servicio_id)
    REFERENCES SERVICIO(id_servicio),
    CONSTRAINT FK_CLIENTE_OBSERVACION FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE(id_cliente),
    CONSTRAINT pk_observacion PRIMARY KEY (id_observacion, servicio_id, cliente_id)
);

/
CREATE TABLE PAQUETE (
    id_paquete NUMBER PRIMARY KEY,
    fechaCreacion DATE NOT NULL,
    vacunado NUMBER(1) NOT NULL,
    precio DECIMAL(10,2),
    fechas FECHA_RANGO,
    destino_id NUMBER NOT NULL, 
    CONSTRAINT FK_DESTINO_PAQUETE FOREIGN KEY (destino_id)
    REFERENCES DESTINO(id_destino)
);

/
CREATE TABLE SUBSCRIPCION (
    paquete_id NUMBER NOT NULL,
    disponibilidad_id NUMBER NOT NULL,
    disponibilidad_id_servicio NUMBER NOT NULL,
    CONSTRAINT FK_PAQUETE_SUBSCRIPCION FOREIGN KEY (paquete_id)
    REFERENCES PAQUETE(id_paquete),
    CONSTRAINT FK_DISPONIBILIDAD_SUBSCRIPCION FOREIGN KEY (disponibilidad_id, disponibilidad_id_servicio)
    REFERENCES DISPONIBILIDAD(id_disponibilidad, id_servicio),
    CONSTRAINT pk_subscripcion PRIMARY KEY (paquete_id, disponibilidad_id)
);

/
CREATE TABLE PROPIETARIO (
    utilizo NUMBER(1),
    razon_no_utilizo VARCHAR2(10),
    cliente_id NUMBER NOT NULL,
    paquete_id NUMBER NOT NULL,
    CONSTRAINT FK_CLIENTE_PROPIETARIO FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE(id_cliente),
    CONSTRAINT FK_PAQUETE_PROPIETARIO FOREIGN KEY (paquete_id)
    REFERENCES PAQUETE(id_paquete),
    CONSTRAINT pk_propietario PRIMARY KEY (cliente_id, paquete_id)
);

/
CREATE TABLE PCR(
    pcr_fecha DATE NOT NULL,
    pcr_positivo NUMBER(1) NOT NULL,
    cliente_id NUMBER NOT NULL,
    CONSTRAINT FK_CLIENTE_PRC FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE(id_cliente),
    CONSTRAINT pk_pcr PRIMARY KEY (pcr_fecha, cliente_id)
);

/
CREATE TABLE MEDIO(
    id_medio NUMBER PRIMARY KEY,
    canal VARCHAR2(50) NOT NULL,
    comision DECIMAL(5,2) NOT NULL
);

CREATE TABLE FACTURA(
    id_factura NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    dispositivo VARCHAR2(50),
    cliente_id NUMBER NOT NULL,
    medio_id NUMBER NOT NULL,
    CONSTRAINT FK_CLIENTE_FACTURA FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE(id_cliente),
    CONSTRAINT FK_MEDIO FOREIGN KEY (medio_id)
    REFERENCES MEDIO(id_medio)
);

/
CREATE TABLE DETFACTURA(
    id_detFactura NUMBER NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    factura_id NUMBER NOT NULL,
    paquete_id NUMBER NOT NULL,
    CONSTRAINT FK_FACTURA FOREIGN KEY (factura_id)
    REFERENCES FACTURA(id_factura),
    CONSTRAINT FK_PAQUETE_DETFACTURA FOREIGN KEY (paquete_id)
    REFERENCES PAQUETE(id_paquete),
    CONSTRAINT pk_detFactura PRIMARY KEY (id_detFactura, factura_id, paquete_id)
);

/
CREATE TABLE MPAGO(
    id_mpago NUMBER,
    forma varchar2(10),
    cantidad DECIMAL(10,2),
    detFactura_id NUMBER NOT NULL,
    detFactura_factura_id NUMBER NOT NULL,
    detFactura_paquete_id NUMBER NOT NULL,
    CONSTRAINT FK_DETFACTURA FOREIGN KEY (detFactura_id, detFactura_factura_id, detFactura_paquete_id)
    REFERENCES DETFACTURA(id_detFactura, factura_id, paquete_id),
    CONSTRAINT PK_MPAGO PRIMARY KEY (id_mpago, detFactura_factura_id, detFactura_paquete_id, detFactura_id)
);

/
CREATE TABLE COMPETENCIA(
    id_competencia NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    logo BLOB NOT NULL
);

/
CREATE TABLE VENTA(
    fecha_mes DATE NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cantidad NUMBER NOT NULL,
    competencia_id NUMBER NOT NULL,
    CONSTRAINT FK_COMPETENCIA FOREIGN KEY (competencia_id)
    REFERENCES COMPETENCIA(id_competencia),
    CONSTRAINT pk_venta PRIMARY KEY (fecha_mes, competencia_id)
);
