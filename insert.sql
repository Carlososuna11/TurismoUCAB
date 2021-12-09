ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
-- Paises
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN 
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Argentina',EMPTY_BLOB(),'Argentino') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'argentina.jpg');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Brasil',EMPTY_BLOB(),'Brasilero') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'brasil.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Chile',EMPTY_BLOB(),'Chileno') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'chile.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Colombia',EMPTY_BLOB(),'Colombiano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'colombia.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Ecuador',EMPTY_BLOB(),'Ecuatoriano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'ecuador.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Peru',EMPTY_BLOB(),'Peruano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'peru.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Uruguay',EMPTY_BLOB(),'Uruguayo') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'uruguay.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Venezuela',EMPTY_BLOB(),'Venezolano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'venezuela.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Bolivia',EMPTY_BLOB(),'Boliviano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'bolivia.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Paraguay',EMPTY_BLOB(),'Paraguayo') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'paraguay.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Italia',EMPTY_BLOB(),'Italiano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'italia.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Alemania',EMPTY_BLOB(),'Aleman') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'alemania.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Francia',EMPTY_BLOB(),'Frances') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'francia.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Mexico',EMPTY_BLOB(),'Mexicano') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'mexico.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;
/
SET serveroutput ON;
DECLARE 
    V_blob BLOB;
    V_bfile BFILE;
BEGIN
    INSERT INTO PAIS (id_pais,nombre,foto,nacionalidad) 
    VALUES (id_pais.nextVal,'Belgica',EMPTY_BLOB(),'Belga') RETURNING foto INTO V_blob;
    V_bfile := BFILENAME('IMAGES', 'belgica.png');
    DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
    DBMS_LOB.CLOSE(V_bfile);
    COMMIT;
END;

-- CLIENTES --
-- cliente 1
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id) 
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Carlos',
    'Alvaro',
    'V-29772315',
    'Osuna',
    'Piñero',
    '+(58)-414-878-9234',
    '07-09-2001'
),FLOOR(RAND()),NULL);

-- cliente 2
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Yuliana',
    'Andrea',
    'V-30345678',
    'Osuna',
    'Piñero',
    '+(58)-426-745-4265',
    '03-11-2003'
),FLOOR(RAND()),NULL);

-- cliente 3
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Andres',
    'Eduardo',
    'V-29772315',
    'Osuna',
    'Sanabria',
    '+(58)-416-523-2434',
    '03-01-1962'
),FLOOR(RAND()),NULL);

-- cliente 4
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Luis',
    'Emilio',
    'E-45931254',
    'Ortiz',
    'Gonzalez',
    '+(1)-35-515-1425',
    '12-10-1998'
),FLOOR(RAND()),NULL);

-- cliente 5
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Daniel',
    'Josue',
    'V-27638942',
    'Saco',
    'Sanchez',
    '+(34)-657-171-545',
    '05-10-1998'
),FLOOR(RAND()),NULL);

-- cliente 6
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Juan',
    'Javier',
    'V-34782315',
    'Vargas',
    'Campos',
    '+(15)-845-878-9234',
    '04-05-1999'
),FLOOR(RAND()),NULL);

-- cliente 7
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Antonio',
    'Lorenzo',
    'V-34774315',
    'Vargas',
    'Campos',
    '+(15)-845-878-9244',
    '01-03-2000'
),FLOOR(RAND()),NULL);

-- cliente 8
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Luisa',
    'Maria',
    'V-12354378',
    'Vargas',
    'Campos',
    '+(15)-845-876-9734',
    '01-02-1990'
),FLOOR(RAND()),NULL);

-- cliente 9
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Alfredo',
    'Elias',
    'V-28303703',
    'Gonzalez',
    'Salazar',
    '+(58)-426-489-1736',
    '05-07-2001'
),FLOOR(RAND()),NULL);

-- cliente 10
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Jose',
    'Antonio',
    'V-34782315',
    'Di Pietro',
    'Zambrano',
    '+(58)-414-817-5234',
    '17-08-2001'
),FLOOR(RAND()),NULL);

-- cliente 11
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Maria',
    'Fernanda',
    'V-34782315',
    'Sanchez',
    'Sanchez',
    '+(58)-414-782-6781',
    '12-08-2000'
),FLOOR(RAND()),NULL);

-- cliente 12
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Alejandro',
    'Jose',
    'V-34782315',
    'Sanchez',
    'Sanchez',
    '+(58)-412-865-7834',
    '11-07-2003'
),FLOOR(RAND()),NULL);

-- cliente 13
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Carlos',
    'Alejandro',
    'V-34782315',
    'Arriaga',
    'Darmiano',
    '+(58)-412-785-6354',
    '24-06-2000'
),FLOOR(RAND()),NULL);

-- cliente 14
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Yuleima',
    'Trinidad',
    'V-14039698',
    'Piñero',
    'Contreras',
    '+(58)-416-245-7676',
    '10-06-1978'
),FLOOR(RAND()),NULL);

-- cliente 15
INSERT INTO CLIENTE (id_cliente,datos,vacunado,pais_id)
VALUES (id_cliente.nextVal,DATOS_USUARIO(
    'Leonela',
    'Maria',
    'V-34782315',
    'Roldan',
    'Mendez',
    '+(54)-654-654-834',
    '4-11-1996'
),FLOOR(RAND()),NULL);

-- PCR ------------------------
INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),1);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),2);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),3);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),4);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),5);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),6);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),7);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),8);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),9);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),10);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),11);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),12);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),13);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),14);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,FLOOR(RAND()),15);

-- DESTINOS ------------------------

-- SET serveroutput ON;
-- DECLARE 
--     V_blob BLOB;
--     V2_blob BLOB;
--     V_bfile BFILE;
--     V2_bfile BFILE;
-- BEGIN 
--     INSERT INTO DESTINO (id_destino,nombre,descripcion,foto,video)
--     VALUES (
--         id_destino.nextVal,
--         'JuanGriego'
--         'Paraíso idílico y hermoso, es la Bahía de Juan Griego; colmada de aguas mansas y sin oleaje con un colorido en tonalidades que van desde el azul celeste hasta los más intensos y adornada por pelícanos que posan sobre los botes de los pescadores de la región. 

-- La Bahía de Juan Griego se encuentra perfectamente refugiada de los fuertes vientos, y los lugareños suelen anclar sus embarcaciones en ella. El lugar posee servicios turísticos como las cómodas sillas de extensión, sombrillas y establecimientos de comida. 
 
-- Esta playa presenta mayor afluencia de lugareños. La localidad de Juan Griego extiende sus brazos para recibir a miles de turistas anualmente, debido a la fuerte atracción de los establecimientos comerciales ubicados frente al preciado mar. Allí encontrarán cafés y un fabuloso bulevar que recorre toda la extensión de la playa.

-- Los turistas viajan a diversas partes de la isla para contar sus experiencias; no cabe duda que una magnífica opción la ofrece El Fondadero, donde bajo una churuata en compañía de un divino coctel podrán observar el panorama bellísimo que les brinda la playa.
 
-- El atractivo principal de Juan Griego es el fortín. Desde ese punto podrás disfrutar de un paisaje completo de la ciudad y de La Galera. Por lo general este lugar es uno de los más visitados, pues no se puede perder el extraordinario ocaso que sencillamente lo dejará sin aliento. En El Fortín se encuentran niños, los cuales le preguntarán si desea conocer la historia; al responderles de manera afirmativa y por una pequeña propina les será contada la historia que relata el por qué del nombre de Juan Griego y la famosa Batalla de Matasiete.
 
-- Podrás ubicar a Juan Griego al extremo noreste de la isla, en la ciudad de Juan Griego, entre los poblados de La Galera y Taguantar.',
--         EMPTY_BLOB(),
--         EMPTY_BLOB()
--     ) RETURNING foto,video INTO V_blob,V2_blob;
--     V_bfile := BFILENAME('IMAGES', 'Hesperia.png');
--     DBMS_LOB.OPEN(V_bfile, DBMS_LOB.LOB_READONLY);
--     DBMS_LOB.LOADFROMFILE(V_blob, V_bfile, SYS.DBMS_LOB.GETLENGTH(V_bfile));
--     DBMS_LOB.CLOSE(V_bfile);
--     V2_bfile := BFILENAME('VIDEOS', 'Margarita.mp4');
--     DBMS_LOB.OPEN(V2_bfile, DBMS_LOB.LOB_READONLY);
--     DBMS_LOB.LOADFROMFILE(V2_blob, V2_bfile, SYS.DBMS_LOB.GETLENGTH(V2_bfile));
--     DBMS_LOB.CLOSE(V2_bfile);
--     COMMIT;
-- END;
