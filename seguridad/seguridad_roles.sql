-- Roles

CREATE ROLE administrador;
CREATE ROLE gerente_ventas;
CREATE ROLE empleado;


-- Asignación de permisos

GRANT ALL PRIVILEGES TO administrador;
GRANT CREATE SESSION TO gerente_ventas;
GRANT CREATE SESSION TO empleado;


-- Permisos para administrador

GRANT ALL ON FACTURAS TO administrador;
GRANT ALL ON SERVICIO TO administrador;
GRANT ALL ON PAQUETE TO administrador;
GRANT ALL ON PROVEEDOR TO administrador;
GRANT ALL ON DESTINO TO administrador;
GRANT ALL ON MEDIO TO administrador;
GRANT ALL ON MPAGO TO administrador;
GRANT ALL ON DISPONIBILIDAD TO administrador;
GRANT ALL ON CRUCERO TO administrador;
GRANT ALL ON MANTENIMIENTO TO administrador;


-- Permisos para gerente_ventas

GRANT INSERT, SELECT, UPDATE ON FACTURAS TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON SERVICIO TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON PROVEEDOR TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON PAGO TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON MEDIO TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON DESTINO TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON MPAGO TO gerente_ventas;
GRANT INSERT, SELECT, UPDATE ON DISPONIBILIDAD TO gerente_ventas;
GRANT SELECT ON CRUCERO TO gerente_ventas;
GRANT SELECT ON MANTENIMIENTO TO gerente_ventas;


-- Permisos para empleado

GRANT SELECT ON CLIENTE TO empleado;
GRANT SELECT ON FACTURAS TO empleado;
GRANT SELECT ON SERVICIO TO empleado;
GRANT SELECT ON PROVEEDOR TO empleado;
GRANT SELECT ON PAGO TO empleado;
GRANT SELECT ON MEDIO TO empleado;
GRANT SELECT ON DESTINO TO empleado;
GRANT SELECT ON MPAGO TO empleado;
GRANT SELECT ON DISPONIBILIDAD TO empleado;
GRANT SELECT ON CRUCERO TO empleado;
GRANT SELECT ON MANTENIMIENTO TO empleado;

-- Usuarios
CREATE USER administrador1 IDENTIFIED BY administrador1;
CREATE USER gerente1 IDENTIFIED BY gerente1;
CREATE USER empleado1 IDENTIFIED BY empleado1;


-- Roles para los usuarios
GRANT administrador TO administrador1;
GRANT gerente_ventas TO gerente1;
GRANT empleado TO empleado1;