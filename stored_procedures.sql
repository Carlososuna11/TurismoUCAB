CREATE OR REPLACE PROCEDURE INSERTAR_PAIS(
    id NUMBER,
    nombre VARCHAR(50), 
    foto VARCHAR(50), 
    nacionalidad VARCHAR(50))
IS 
BEGIN
    DECLARE
    V_bfile BFILE;
    V_blob BLOB;
BEGIN
    INSERT INTO pais(id_pais, nombre, foto, nacionalidad)
    VALUES (id, nombre, EMPTY_BLOB(), nacionalidad) RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('ORACLECLRDIR', foto);
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
    END;
END;