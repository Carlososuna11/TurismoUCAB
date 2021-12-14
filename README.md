# TurismoUCAB

### Creación usuario

1. Iniciar sesión en la Base de Datos como System user.
2. Modificar la sesión para poder crear usuario
```terminal
alter session set "_ORACLE_SCRIPT"=true;  
```
3. Crear Usuario. 
```terminal
CREATE USER <username> IDENTIFIED BY <password>;
```
**Nota**: `<username>` y `<password>` deben ser reemplazados por el nombre de usuario y contraseña que deseen.

4. Conceder todos los privilegios.
```terminal
    GRANT ALL PRIVILEGES TO <username>;
```

5. Conceder Roles.
```terminal
GRANT CONNECT TO <username>;
GRANT CONNECT, RESOURCE, DBA TO <username>;
```

6. Conceder espacio ilimitado.
```terminal
GRANT UNLIMITED TABLESPACE TO <username>;
```

7. Privilegios de Directorio
```terminal
GRANT READ, WRITE ON DIRECTORY ORACLECLRDIR TO <username>;
```

### Ejecutar

- Orden de Ejecución de Los Scripts

1.  [drop.sql](drop.sql)
2. Modulo de Creación

    2.  [tda.sql](modulo_creacion/tda.sql)
    3.  [sequences.sql](modulo_creacion/sequences.sql)
    4.  [stored_procedures.sql](modulo_creacion/stored_procedures.sql)
    5.  [create.sql](modulo_creacion/create.sql)
    6.  [insert.sql](modulo_creacion/insert.sql)
3. Modulo de Inicio

    1. [modulo_inicio.sql](modulo_inicio/modulo_inicio.sql)
4. Modulo de Servicios
    
    1. [modulo_servicios.sql](modulo_servicios/modulo_servicios.sql)

5. Modulo de Paquetes

    1. [modulo_paquete.sql](modulo_paquetes/modulo_paquete.sql)

6. Modulo de Compra

    1. [modulo_compra.sql](modulo_compra/modulo_compra.sql)

7. Modulo de Analisis

    1. [modulo_analisis.sql](modulo_analisis/modulo_analisis.sql)

9. Modulo de Mantenimiento

    1. [modulo_mantenimiento.sql](modulo_mantenimiento/modulo_mantenimiento.sql)

9. Modulo de Observaciones

    1. [modulo_observacion.sql](modulo_observaciones/modulo_observacion.sql)

8. Modulo de Reportes

    1. [stored_procedures_reportes.sql](Reportes/stored_procedures_reportes.sql)

Luego ejecutar el Script de simulación y habilitar el DBMS_OUTPUT

    1. [simulacion.sql](simulacion.sql)