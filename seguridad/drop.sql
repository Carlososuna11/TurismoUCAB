alter session set "_oracle_script"=true;
Revoke empleado from EMPLEADO1;
DROP USER EMPLEADO1 CASCADE ;
DROP ROLE EMPLEADO;

Revoke administrador from ADMINISTRADOR1;
DROP USER ADMINISTRADOR1 CASCADE ;
DROP ROLE administrador;

Revoke gerente_ventas from GERENTE1;
DROP USER GERENTE1 CASCADE ;
DROP ROLE gerente_ventas;
