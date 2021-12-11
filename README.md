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

- Ejecutar drop.sql
- Ejecutar tda.sql
- Ejecutar sequence.sql
- Ejecutar create.sql
- Ejecutar stored_procedures.sql
- Ejecutar insert.sql