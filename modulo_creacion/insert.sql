
BEGIN
    -- 1
    INSERTAR_PAIS(id_pais.nextVal,'Argentina','argentina.jpg','Argentino');
    -- 2
    INSERTAR_PAIS(id_pais.nextVal,'Bolivia','bolivia.png','Boliviano');
    -- 3
    INSERTAR_PAIS(id_pais.nextVal,'Brasil','brasil.png','Brasilero');
    -- 4
    INSERTAR_PAIS(id_pais.nextVal,'Chile','chile.png','Chileno');
    -- 5
    INSERTAR_PAIS(id_pais.nextVal,'Colombia','colombia.png','Colombiano');
    -- 6
    INSERTAR_PAIS(id_pais.nextVal,'Ecuador','ecuador.png','Ecuatoriano');
    -- 7
    INSERTAR_PAIS(id_pais.nextVal,'Paraguay','paraguay.png','Paraguayo');
    -- 8
    INSERTAR_PAIS(id_pais.nextVal,'Peru','peru.png','Peruano');
    -- 9
    INSERTAR_PAIS(id_pais.nextVal,'Uruguay','uruguay.png','Uruguayo');
    -- 10
    INSERTAR_PAIS(id_pais.nextVal,'Venezuela','venezuela.png','Venezolano');
    -- 11
    INSERTAR_PAIS(id_pais.nextVal,'Italia','italia.png','Italiano');
    -- 12
    INSERTAR_PAIS(id_pais.nextVal,'Francia','francia.png','Frances');
    -- 13
    INSERTAR_PAIS(id_pais.nextVal,'Alemania','alemania.png','Aleman');
    -- 14
    INSERTAR_PAIS(id_pais.nextVal,'Mexico','mexico.png','Mexicano');
    -- 15
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
    TO_DATE('07-09-2001','DD-MM-YYYY'),
    'carlosalvaroosuna1@yomail.com'
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
    TO_DATE('03-11-2003','DD-MM-YYYY'),
    'yuyiosuna3@outlook.com'
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
    TO_DATE('03-01-1962','DD-MM-YYYY'),
    'andresabogado@gmail.com'
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
    TO_DATE('12-10-1998','DD-MM-YYYY'),
    'luisemilioortiz@hotmail.com'
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
    TO_DATE('05-10-1998','DD-MM-YYYY'),
    'danielsanchez98@gmail.com'
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
    TO_DATE('04-05-1999','DD-MM-YYYY'),
    'armarjavier@hotmail.com'
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
    TO_DATE('01-03-2000','DD-MM-YYYY'),
    'antonio_lorenzo_04@gmail.com'
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
    TO_DATE('01-02-1990','DD-MM-YYYY'),
    'mariavargas1990@gmail.com'
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
    TO_DATE('05-07-2001','DD-MM-YYYY'),
    'alfredogonzalezsalazar@gmail.com'
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
    TO_DATE('17-08-2001','DD-MM-YYYY'),
    'josedipietro@gmail.com'
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
    TO_DATE('12-08-2000','DD-MM-YYYY'),
    'mariafernanda1208@hotmail.com'
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
    TO_DATE('11-07-2003' ,'DD-MM-YYYY'),
    'alejandrojss03@gmail.com'
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
    TO_DATE('24-06-2000','DD-MM-YYYY'),
    'carlosarriaga@gmail.com'
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
    TO_DATE('10-06-1978','DD-MM-YYYY'),
    'yuli_car_2@gmail.com'
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
    TO_DATE('4-11-1996','DD-MM-YYYY'),
    'luluroldans@hotmail.com'
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

/

-- INICIO DESTINOS ------------------------
BEGIN
    INSERTAR_DESTINO(
    id_destino.nextVal,
    'JuanGriego',
    'Paraiso idilico y hermoso, es la Bahia de Juan Griego; colmada de aguas mansas y sin oleaje con un colorido en tonalidades que van desde el azul celeste hasta los mas intensos y adornada por pelicanos que posan sobre los botes de los pescadores de la region.',
    'juangriego.jpeg',
    'gif_margarita.gif'
    );

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Pampatar',
    'La ciudad de Pampatar es la capital del municipio Maneiro, en la isla de Margarita, estado Nueva Esparta (Venezuela). Su antiguo nombre era Pampatare o Mampatar. Pampatar es voz indígena que significa «casa de sal».',
    'pampatar.jpg',
    'gif_pampatar.gif');

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Porlamar',
    'Porlamar, es una ciudad ubicada al sureste de la Isla de Margarita, Nueva Esparta, Venezuela; capital del municipio Mariño, es el principal centro urbano y económico de la isla.',
    'porlamar.jpg',
    'gif_porlamar.gif');

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Isla de Coche',
    'La Isla de Coche es una isla ubicada en el estado Nueva Esparta, Venezuela, en la costa occidental de la República Bolivariana de Venezuela. Su nombre original era Coche, y fue cambiado en el año 2000 por la Isla de Margarita, debido a que la isla de Coche se encuentra en el lugar donde se encuentra la capital del municipio Mariño.',
    'coche.jpg',
    'gif_isla_de_coche.gif');

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Los Roques',
    'El Archipielago de Los Roques ubicado en el mar Caribe contiene más de 300 islas y cayos que rodean una laguna de 400 km cuadrados.',
    'los_roques.jpg',
    'gif_los_roques.gif');

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Isla La Tortuga ',
    'La Tortuga es una isla en el Mar Caribe conformada por una isla mayor y varios islotes y cayos más pequeños.',
    'tortuga.jpg',
    'gif_tortuga.gif');

    INSERTAR_DESTINO(
    id_destino.nextVal,
    'Morrocoy',
    'El Parque Nacional Morrocoy es una isla protegida y una reserva marina en la costa caribeña de Venezuela. Se encuentra en el estado Falcón y es conocida por sus manglares, sus playas y sus cayos, como el Cayo Sombrero.',
    'morrocoy.jpg',
    'gif_morrocoy.gif'
    );

    INSERTAR_DESTINO(id_destino.nextVal,
    'Bahia de Cata','La bahía de Cata es una playa del estado Aragua, de gran extensión, finísima arena, aguas cristalinas y adornadas por la sombra de erguidos cocoteros.',
    'bahia_cata.jpg',
    'gif_cata.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Choroní','Choroní tiene varias playas hermosas, Playa Grande, Tipire, El Diario, Valle seco, Chuao y varios lugaros para visitar con lancha',
    'choroni.jpg',
    'gif_choroni.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Lecheria','Lecheria tiene varias playas hermosas y varios lugares para visitar.',
    'lecheria.jpg',
    'gif_lecheria.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Mochima','Mochima es uno de los destinos turísticos más espectaculares de Venezuela. Playa Colorada es mundialmente famosa por su fina arena de color dorado, casi rojizo, que da nombre al lugar.',
    'mochima.jpg',
    'gif_mochima.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Cuyagua','Cuyagua es un pueblo ubicado en la costa de Aragua, Venezuela. Entre sus ríos se encuentran el Pozo de Arena y el Pozo San Pedro. Tiene una playa que posee un fuerte oleaje donde se practica el surf y el bodyboard',
    'cuyagua.jpg',
    'gif_cuyagua.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Cayo Sombrero','Cayo Sombrero​ es el nombre de una isla del mar Caribe que pertenece al parque nacional Morrocoy​.',
    'cayo_sombrero.jpg',
    'gif_cayo_sombrero.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Urama','Urama es un pueblo en el estado Vargas, tiene varias playas hermosas y rios para visitar.',
    'urama.jpg',
    'gif_urama.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Los Frailes','Uno de los lugares menos visitados en Margarita son las islas de Los Frailes. Son esas islas que se ven a lo lejos desde las playas de Guacuco, El Tirano, Parguito o El Agua.',
    'los_frailes.jpg',
    'gif_margarita.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Los Testigos','El Archipiélago Los Testigos es de clima cálido, semi-árido y con un tiempo suave y agradable durante la mayoría del año, un clima muy parecido al vecino Archipiélago de Los Frailes.',
    'los_testigos.jpg',
    'gif_margarita.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'La Orchila','Isla la Orchila es una isla en la costa de Venezuela. Tiene numerosas playas, incluida una donde la arena es notablemente rosada.',
    'la_orchila.jpg',
    'gif_margarita.gif');

    INSERTAR_DESTINO(id_destino.nextVal,
    'Las Aves','Es una pequeña y remota isla venezolana, lugar de descanso y reproducción para las aves marinas y para la tortuga verde.',
    'las_aves.jpg',
    'gif_margarita.gif');

-- FIN DESTINOS ------------------------

-- INICIO PROVEEDORES ------------------------

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Hesperia',
        'Hesperia_logo.png',
        'Hesperia_hotel.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Unik Hotel',
        'unik_logo.png',
        'unik_hotel.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Margarita Dynasty Hotel & Suites',
        'dynasty_logo.png',
        'dynasty_hotel.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Proxima Ruta Venezuela',
        'proxima_ruta_logo.png',
        'proxima_ruta_feed.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Mochileros Venezuela',
        'mochileros_venezuela.jpg',
        'mochileros_venezuela_feed.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Ruta Extrema',
        'ruta_extrema.jpg',
        'ruta_extrema_feed.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Fundación Azul Ambientalistas',
        'fundacion_azul.jpg',
        'fundacion_azul_foto.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Fundación Tierra Viva',
        'fundacion_tierra_viva.jpg',
        'tierra_viva_foto.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Recreación Bululu',
        'bululu_logo.png',
        'bululu_foto.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Sendero cojedes',
        'senderos_cojedes_logo.jpg',
        'senderos_cojedes_feed.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Rutas Mochileras',
        'rutas_mochileras_logo.png',
        'rutas_mochileras_feed.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Suites Cristina',
        'suites_cristina.png',
        'suites_cristina_hotel.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Woi-Kaa',
        'woikaa_logo.jpg',
        'woikaa_feed.png'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Marriot',
        'marriot_logo.png',
        'marriot_hotel.jpg'
    );

    INSERTAR_PROVEEDOR(
        id_proveedor.nextVal,
        'Eurobuilding Express',
        'eurobuilding_logo.png',
        'eurobuilding_hotel.jpg'
    );

-- FIN PROVEEDORES ------------------------

-- INICIO CRUCEROS ------------------------

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero1.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero2.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero3.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero1.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero2.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero3.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero1.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero2.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero3.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero1.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero2.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero3.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero1.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero2.jpg'
    );

    INSERTAR_CRUCERO(
    id_crucero.nextVal,
    'crucero3.jpg'
    );

END;

/
-- Inserts Medios de Pago
-- medio 1
INSERT INTO MEDIO (id_medio, canal, comision)
VALUES (id_medio.nextVal,'Agencia Fisica',0.35);
-- medio 2
INSERT INTO MEDIO (id_medio, canal, comision)
VALUES (id_medio.nextVal,'Aplicacion Movil',1);
-- medio 3
INSERT INTO MEDIO (id_medio, canal, comision)
VALUES (id_medio.nextVal,'Pagina Web',2);
-- medio 4
INSERT INTO MEDIO (id_medio, canal, comision)
VALUES (id_medio.nextVal,'Whatsapp',1.2);
-- medio 5
INSERT INTO MEDIO (id_medio, canal, comision)
VALUES (id_medio.nextVal,'Instagram',1.3);

-- Inserts de Servicios de Cruceros
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    1,
    1,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    2,
    2,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    3,
    3,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    4,
    4,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    5,
    5,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    6,
    6,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    7,
    7,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    8,
    8,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    9,
    9,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    10,
    10,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    11,
    11,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    12,
    12,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    13,
    13,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    14,
    14,
    NULL,
    NULL
);
INSERT INTO SERVICIO VALUES(
    id_servicio_s.nextVal,
    'Paseos a crucero',
    0,
    15,
    15,
    NULL,
    NULL
);
INSERT INTO METODOS_PAGO VALUES(
    1,
    'TDC'
);
INSERT INTO METODOS_PAGO VALUES(
    2,
    'Wallet'
);
INSERT INTO METODOS_PAGO VALUES(
    3,
    'Criptomonedas'
);

-- INSERTAR MANTENIMIENTOS 

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+10,
    DBMS_RANDOM.VALUE (40, 50),
    1
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento Preventivo',
    SYSDATE+20,
    DBMS_RANDOM.VALUE (40, 50),
    2
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Popa',
    SYSDATE+4,
    DBMS_RANDOM.VALUE (40, 50),
    3
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+12,
    DBMS_RANDOM.VALUE (40, 50),
    4
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento',
    SYSDATE+30,
    DBMS_RANDOM.VALUE (40, 50),
    5
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+80,
    DBMS_RANDOM.VALUE (40, 50),
    6
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+6,
    DBMS_RANDOM.VALUE (40, 50),
    7
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+47,
    DBMS_RANDOM.VALUE (40, 50),
    8
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+9,
    DBMS_RANDOM.VALUE (40, 50),
    9
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+12,
    DBMS_RANDOM.VALUE (40, 50),
    10
);

INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+4,
    DBMS_RANDOM.VALUE (40, 50),
    11
);


INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+14,
    DBMS_RANDOM.VALUE (40, 50),
    12
);


INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+17,
    DBMS_RANDOM.VALUE (40, 50),
    13
);


INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+24,
    DBMS_RANDOM.VALUE (40, 50),
    14
);


INSERT INTO MANTENIMIENTO VALUES (
    id_mantenimiento_s.nextVal,
    FECHA_RANGO(SYSDATE-1,SYSDATE+1),
    'Mantenimiento de la Proa',
    SYSDATE+28,
    DBMS_RANDOM.VALUE (40, 50),
    15
);

-- INSERTAR COMPETENCIA
begin
    --1
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Hovertours',
        'hovertours.png'
    );
    --2
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Quo Vadis',
        'quovadis.jpg'
    );
    --3
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Drumtrips',
        'drumtrips.png'
    );
    --4
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Mega Tours',
        'megatours.png'
    );
    --5
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Mega Venezuela',
        'megavenezuela.jpeg'
    );
    --6
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'D Mundo Travels',
        'dmundo.png'
    );
    --7
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Mundo Travel',
        'mundotravel.jpg'
    );
    --8
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Elite Tours Venezuela',
        'elitetours.png'
    );
    --9
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Tom Tours',
        'tomtours.jpeg'
    );
    --10
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Turaser',
        'turaser.jpeg'
    );
    --11
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Venezuela Travel International',
        'vti.png'
    );
    --12
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Turismo Maso Internacional',
        'turismomaso.png'
    );
    --13
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Atom Travel',
        'atomtravel.jpeg'
    );
    --14
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Mega Travel',
        'megatravel.jpg'
    );
    --15
    INSERTAR_COMPETENCIA(
        id_competencia.nextVal,
        'Italviajes',
        'italviajes.jpeg'
    );
end;