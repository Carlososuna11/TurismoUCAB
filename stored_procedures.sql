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

/
CREATE OR REPLACE PROCEDURE INSERTAR_DESTINO(
    id NUMBER,
    nombre VARCHAR2, 
    descripcion VARCHAR2, 
    foto VARCHAR2,
    video VARCHAR2)
IS
    V_bfile_video BFILE;
    V_blob_video BLOB;
    V_bfile_foto BFILE;
    V_blob_foto BLOB;
BEGIN
    DBMS_OUTPUT.enable;
    INSERT INTO DESTINO VALUES (id, nombre, descripcion, EMPTY_BLOB(), EMPTY_BLOB()) RETURNING foto,video INTO V_blob_foto,V_blob_video;
    V_bfile_foto := BFILENAME('ORACLECLRDIR', foto);
    DBMS_LOB.OPEN(V_bfile_foto, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob_foto, V_bfile_foto, DBMS_LOB.GETLENGTH(V_bfile_foto));
    DBMS_LOB.CLOSE(V_bfile_foto);
    COMMIT;
    V_bfile_video := BFILENAME('ORACLECLRDIR', video);
    DBMS_LOB.OPEN(V_bfile_video, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob_video, V_bfile_video, DBMS_LOB.GETLENGTH(V_bfile_video));
    DBMS_LOB.CLOSE(V_bfile_video);
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE INSERTAR_PROVEEDOR(
    id NUMBER,
    nombre VARCHAR2,
    logo VARCHAR2,
    foto VARCHAR2
)
IS
    V_bfile_logo BFILE;
    V_blob_logo BLOB;
    V_bfile_foto BFILE;
    V_blob_foto BLOB;
BEGIN
    DBMS_OUTPUT.enable;
    INSERT INTO PROVEEDOR VALUES (id, nombre, EMPTY_BLOB(), EMPTY_BLOB()) RETURNING logo,foto INTO V_blob_logo,V_blob_foto;
    V_bfile_logo := BFILENAME('ORACLECLRDIR', logo);
    DBMS_LOB.OPEN(V_bfile_logo, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob_logo, V_bfile_logo, DBMS_LOB.GETLENGTH(V_bfile_logo));
    DBMS_LOB.CLOSE(V_bfile_logo);
    COMMIT;
    V_bfile_foto := BFILENAME('ORACLECLRDIR', foto);
    DBMS_LOB.OPEN(V_bfile_foto, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob_foto, V_bfile_foto, DBMS_LOB.GETLENGTH(V_bfile_foto));
    DBMS_LOB.CLOSE(V_bfile_foto);
    COMMIT;
END;

/
CREATE OR REPLACE PROCEDURE INSERTAR_CRUCERO(
    id NUMBER,
    foto VARCHAR2
)
IS
    V_bfile_foto BFILE;
    V_blob_foto BLOB;
BEGIN
    DBMS_OUTPUT.enable;
    INSERT INTO CRUCERO VALUES (id, EMPTY_BLOB()) RETURNING foto INTO V_blob_foto;
    V_bfile_foto := BFILENAME('ORACLECLRDIR', foto);
    DBMS_LOB.OPEN(V_bfile_foto, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob_foto, V_bfile_foto, DBMS_LOB.GETLENGTH(V_bfile_foto));
    DBMS_LOB.CLOSE(V_bfile_foto);
    COMMIT;
END;
/