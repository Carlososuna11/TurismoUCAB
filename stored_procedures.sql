CREATE OR REPLACE PROCEDURE INSERTAR_PAIS(
    id NUMBER,
    nombre VARCHAR2, 
    foto VARCHAR2, 
    nacionalidad VARCHAR2)
IS 
    V_bfile BFILE;
    V_blob BLOB;
BEGIN
    DBMS_OUTPUT.enable;
    INSERT INTO PAIS VALUES (id, nombre, EMPTY_BLOB(), nacionalidad) RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('ORACLECLRDIR', foto);
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;