ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
--  TDA FECHA_RANGO 
/
CREATE OR REPLACE TYPE FECHA_RANGO AS OBJECT(
fechaInicio DATE,
fechaFin DATE,
STATIC FUNCTION validarFechas(fechaInicio DATE, fechaFin DATE) RETURN DATE,
CONSTRUCTOR FUNCTION FECHA_RANGO(SELF IN OUT NOCOPY FECHA_RANGO,fechaInicio DATE, fechaFin DATE) RETURN SELF AS RESULT
);

/
CREATE OR REPLACE TYPE BODY FECHA_RANGO AS
STATIC FUNCTION validarFechas ( fechaInicio DATE, fechaFin DATE ) RETURN DATE
IS
    BEGIN
        IF (fechaFin IS NULL) THEN
            return fechaFin;
        ELSIF (fechaFin >= fechaInicio) THEN
            return fechaFin;
        ELSE
            RAISE_APPLICATION_ERROR(-20401,'Fecha Fin no Es Mayor o igual A Fecha
            Inicio');
        END IF;
    END;
CONSTRUCTOR FUNCTION FECHA_RANGO(SELF IN OUT NOCOPY FECHA_RANGO, fechaInicio DATE, fechaFin DATE ) RETURN SELF AS RESULT
IS
    BEGIN
        IF (fechaInicio IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'La fecha de inicio no puede ser nula');
        END IF;
        SELF.fechaInicio := fechaInicio;
        IF (fechaFin IS NULL) THEN
            SELF.fechaFin := NULL;
            RETURN;
        ELSIF (fechaFin >= fechaInicio) THEN
            SELF.fechaFin := fechaFin;
            RETURN;
        ELSE
            RAISE_APPLICATION_ERROR(-20402, 'La fecha de fin debe ser mayor o igual a la fecha de inicio');
        END IF;
    END;
END;
-- FIN TDA FECHA_RANGO 
/

--  TDA DATOS_USUARIO 
/
CREATE OR REPLACE TYPE DATOS_USUARIO AS OBJECT(
  nombre VARCHAR2(30),
  segundoNombre VARCHAR2(30), 
  dni VARCHAR2(30), 
  apellido VARCHAR2(30), 
  segundoApellido VARCHAR2(30), 
  telefono VARCHAR2(30), 
  fechaNacimiento DATE, 
  STATIC FUNCTION calcularEdad(fechaNacimiento DATE) RETURN INTEGER,
  STATIC FUNCTION validarDNI(dni VARCHAR2) RETURN VARCHAR2,
  STATIC FUNCTION validarTelefono(telefono VARCHAR2) RETURN VARCHAR2,
  CONSTRUCTOR FUNCTION DATOS_USUARIO(
    SELF IN OUT NOCOPY DATOS_USUARIO,
    nombre VARCHAR2,
    segundoNombre VARCHAR2, 
    dni VARCHAR2, 
    apellido VARCHAR2, 
    segundoApellido VARCHAR2, 
    telefono VARCHAR2, 
    fechaNacimiento DATE
  ) RETURN SELF AS RESULT
);

/
CREATE OR REPLACE TYPE BODY DATOS_USUARIO AS
STATIC FUNCTION calcularEdad(fechaNacimiento DATE) RETURN INTEGER
IS
    BEGIN
        IF (fechaNacimiento IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401,'La fecha de nacimiento no puede ser null');
        
        return FLOOR(MONTHS_BETWEEN(fechaNacimiento, SYSDATE) / 12);
        END IF;
    END;
STATIC FUNCTION validarDNI(dni VARCHAR2) RETURN VARCHAR2
IS
    BEGIN
        IF (SELECT count(*) FROM CLIENTE cliente WHERE cliente.datos.dni = dni) > 0 THEN
            RAISE_APPLICATION_ERROR(-20002,'Ya existe un Cliente con este DNI');
        END IF;
        IF ((dni LIKE 'V-%') OR (dni LIKE 'E-%')) THEN
            return dni;
        ELSE
            RAISE_APPLICATION_ERROR(-20001,'Formato de dni inválido');
        END IF;
    END;

STATIC FUNCTION validarTelefono(telefono VARCHAR2) RETURN VARCHAR2
IS
    BEGIN
        IF (telefono IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401,'El teléfono no puede ser null');
        ELSIF (REGEXP_LIKE(telefono, '^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')) THEN
            return telefono;
        END IF;
        RAISE_APPLICATION_ERROR(-20402,'El teléfono es invalido');
    END;
CONSTRUCTOR FUNCTION DATOS_USUARIO (
    SELF IN OUT NOCOPY DATOS_USUARIO,
    nombre VARCHAR2,
    segundoNombre VARCHAR2, 
    dni VARCHAR2, 
    apellido VARCHAR2, 
    segundoApellido VARCHAR2, 
    telefono VARCHAR2, 
    fechaNacimiento DATE
  ) RETURN SELF AS RESULT
IS
    BEGIN
        IF (nombre IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El nombre no puede ser nulo');
        ELSIF (apellido IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El apellido no puede ser nulo');
        ELSIF (dni IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El DNI no puede ser nulo');
        ELSIF (fechaNacimiento IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'La fecha de nacimiento no puede ser nulo');
        END IF;

        SELF.nombre = nombre;
        SELF.segundoNombre = segundoNombre;
        SELF.dni = dni;
        -- SELF.dni = DATOS_USUARIO.validarDNI(dni);
        SELF.apellido = apellido;
        SELF.segundoApellido = segundoApellido;
        SELF.telefono = telefono;
        -- SELF.telefono = DATOS_USUARIO.validarTelefono(telefono);
        SELF.fechaNacimiento = fechaNacimiento;

        RETURN;
    END;
END;
--  FIN TDA DATOS_USUARIO 
/
--  TDA BALANCE 
CREATE OR REPLACE TYPE BALANCE AS OBJECT(
  egreso DECIMAL(10,2),
  existencia NUMBER, 
  numeroVentas NUMBER, 
  precio_unitario DECIMAL(10,2),
  STATIC FUNCTION calcularIngreso RETURN DECIMAL,
  STATIC FUNCTION calcularGanancia RETURN DECIMAL,
  STATIC FUNCTION calcularPrecioU(fecha DATE, egreso DECIMAL, existencia NUMBER) RETURN DECIMAL,
  CONSTRUCTOR FUNCTION BALANCE (
    SELF IN OUT NOCOPY BALANCE,
    egreso DECIMAL,
    existencia NUMBER, 
    numeroVentas NUMBER, 
    precio_unitario DECIMAL
  ) RETURN SELF AS RESULT
);

/
CREATE OR REPLACE TYPE BODY BALANCE AS
FUNCTION calcularGanancia RETURN DECIMAL
IS
    BEGIN
        return 0.0;
    END;
FUNCTION calcularIngreso RETURN DECIMAL
IS
    BEGIN
        return 0.0;
    END;

FUNCTION calcularPrecioU (fecha DATE, egreso DECIMAL, existencia NUMBER) RETURN DECIMAL
IS
    BEGIN
        return 0.0;
    END;
CONSTRUCTOR FUNCTION BALANCE (
    SELF IN OUT NOCOPY BALANCE,
    egreso DECIMAL,
    existencia NUMBER, 
    numeroVentas NUMBER, 
    precio_unitario DECIMAL,
  ) RETURN SELF AS RESULT
IS
    BEGIN
        IF (egreso IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El egreso no puede ser nulo');
        ELSIF (existencia IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'La existencia no puede ser nulo');
        ELSIF (numeroVentas IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El numeroVentas no puede ser nulo');
        ELSIF (precio_unitario IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20401, 'El precio unitario no puede ser nulo');
        END IF;

        SELF.egreso = egreso;
        SELF.existencia = existencia;
        SELF.numeroVentas = numeroVentas;
        SELF.precio_unitario = precio_unitario;

        RETURN;
    END;
END;
--  FIN TDA BALANCE 
/




