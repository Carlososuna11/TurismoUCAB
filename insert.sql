ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
-- Paises

BEGIN
    INSERTAR_PAIS(id_pais.nextVal,'Argentina','argentina.jpg','Argentino');
    INSERTAR_PAIS(id_pais.nextVal,'Bolivia','bolivia.png','Boliviano');
    INSERTAR_PAIS(id_pais.nextVal,'Brasil','brasil.png','Brasilero');
    INSERTAR_PAIS(id_pais.nextVal,'Chile','chile.png','Chileno');
    INSERTAR_PAIS(id_pais.nextVal,'Colombia','colombia.png','Colombiano');
    INSERTAR_PAIS(id_pais.nextVal,'Ecuador','ecuador.png','Ecuatoriano');
    INSERTAR_PAIS(id_pais.nextVal,'Paraguay','paraguay.png','Paraguayo');
    INSERTAR_PAIS(id_pais.nextVal,'Peru','peru.png','Peruano');
    INSERTAR_PAIS(id_pais.nextVal,'Uruguay','uruguay.png','Uruguayo');
    INSERTAR_PAIS(id_pais.nextVal,'Venezuela','venezuela.png','Venezolano');
    INSERTAR_PAIS(id_pais.nextVal,'Italia','italia.png','Italiano');
    INSERTAR_PAIS(id_pais.nextVal,'Francia','francia.png','Frances');
    INSERTAR_PAIS(id_pais.nextVal,'Alemania','alemania.png','Aleman');
    INSERTAR_PAIS(id_pais.nextVal,'Mexico','mexico.png','Mexicano');
    INSERTAR_PAIS(id_pais.nextVal,'Belgica','belgica.png','Belga');
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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

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
),round(DBMS_RANDOM.VALUE (0, 1)),NULL);

-- PCR ------------------------
INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),1);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),2);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),3);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),4);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),5);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),6);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),7);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),8);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),9);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),10);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),11);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),12);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),13);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),14);

INSERT INTO PCR (pcr_fecha,pcr_positivo,cliente_id)
VALUES (SYSDATE,round(DBMS_RANDOM.VALUE (0, 1)),15);

-- DESTINOS ------------------------

-- SET serveroutput ON
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

-- INSERT_DESTINO(id_destino.nextVal,
-- 'JuanGriego','Paraíso idílico y hermoso, es la Bahía de Juan Griego; colmada de aguas mansas y sin oleaje con un colorido en tonalidades que van desde el azul celeste hasta los más intensos y adornada por pelícanos que posan sobre los botes de los pescadores de la región.',
-- 'juangriego.jpeg',
-- 'Margarita.mp4');

-- INSERT_PROVEEDOR(
--     id_proveedor.nextVal,
--     'Hesperia',
--     'Hesperia.png',
--     'Hesperia.mp4'
-- );