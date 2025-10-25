-- USE master
-- GO

-- CREATE DATABASE DB_BookLoanSystem
-- GO

-- USE DB_BookLoanSystem
-- GO

-- Drop tables if they exist (in reverse dependency order)
-- DROP TABLE loan_details;
-- DROP TABLE loans;
-- DROP TABLE users;
-- DROP TABLE profiles;
-- DROP TABLE borrowers;
-- DROP TABLE books;
-- DROP TABLE publishers;

-- Publishers table (formerly editoriales)
CREATE TABLE publishers (
    id INT IDENTITY,
    publisher_code NVARCHAR(10) NOT NULL,
    publisher_name NVARCHAR(150),
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

    CONSTRAINT pk_publishers PRIMARY KEY (id),
    constraint publishers_publisher_code_uq UNIQUE (publisher_code)
)
    GO

-- Books table (formerly libros)
CREATE TABLE books (
    id INT IDENTITY,
    isbn NVARCHAR(100) NOT NULL,
    title NVARCHAR(300),
    authors NVARCHAR(300),
    edition NVARCHAR(100),
    publication_year INT,
    publisher_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

   CONSTRAINT pk_books PRIMARY KEY (id),
   CONSTRAINT fk_books_publisher_id FOREIGN KEY (publisher_id) REFERENCES publishers(id)
)
    GO

-- Borrowers table (formerly solicitantes)
CREATE TABLE borrowers (
    id INT IDENTITY,
    full_name NVARCHAR(200),
    identity_document NVARCHAR(20),
    email NVARCHAR(100),
    phone_number NVARCHAR(20),
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

   CONSTRAINT pk_borrowers PRIMARY KEY (id)
)
    GO

-- Profiles table (formerly perfiles)
create table profiles
(
    id INT IDENTITY,
    name NVARCHAR(200)  NOT NULL,
    description NVARCHAR(1000),
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

    constraint profiles_pk PRIMARY KEY (id),
    constraint profiles_name_uq UNIQUE (name)
);

-- Users table (formerly usuarios)
create table users
(
    id INT IDENTITY,
    name NVARCHAR(200) not null,
    last_name NVARCHAR(200),
    email NVARCHAR(100) not null,
    password NVARCHAR(200) not null,
    profile_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

    constraint users_pk PRIMARY KEY (id),
    constraint users_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles (id),
    constraint users_email_uq UNIQUE (email)
);


-- Loans table (formerly prestamos)
CREATE TABLE loans (
    id INT IDENTITY,
    loan_date DATETIME DEFAULT GETDATE(),
    due_date DATETIME,
    loan_status INT DEFAULT 0, -- {0=active_loan, 1=returned, 2=partially_returned}
    borrower_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

    CONSTRAINT pk_loans PRIMARY KEY (id),
    CONSTRAINT fk_loans_borrower_id FOREIGN KEY (borrower_id) REFERENCES borrowers(id),
    CONSTRAINT fk_loans_user_id FOREIGN KEY (user_id) REFERENCES users(id)
)
    GO

-- Loan Details table (formerly prestamos_detalles)
CREATE TABLE loan_details (
    loan_id INT NOT NULL,
    book_id INT NOT NULL,
    is_returned INT DEFAULT 0,
    late_fee DECIMAL(12,2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,

    CONSTRAINT pk_loan_details PRIMARY KEY (loan_id, book_id),
    CONSTRAINT fk_loan_details_loan_id FOREIGN KEY (loan_id) REFERENCES loans(id),
    CONSTRAINT fk_loan_details_book_id FOREIGN KEY (book_id) REFERENCES books(id)
)
    GO



-- select * from publishers;

SET IDENTITY_INSERT publishers  ON
GO

insert into publishers (id,publisher_code, publisher_name) values (1,'EDI00001','Oxford University Press');
insert into publishers (id,publisher_code, publisher_name) values (2,'EDI00002','Konrad Adenauer');
insert into publishers (id,publisher_code, publisher_name) values (3,'EDI00003','Catarata');
insert into publishers (id,publisher_code, publisher_name) values (4,'EDI00004','ELACID');
insert into publishers (id,publisher_code, publisher_name) values (5,'EDI00005','Centro de GestiÛn y CooperaciÛn Internacional para el Desarrollo (CGCID), AsociaciÛn Mexicana de Est');
insert into publishers (id,publisher_code, publisher_name) values (6,'EDI00006','EIL');
insert into publishers (id,publisher_code, publisher_name) values (7,'EDI00007','GRAO');
insert into publishers (id,publisher_code, publisher_name) values (8,'EDI00008','Aique. buenos Aires');
insert into publishers (id,publisher_code, publisher_name) values (9,'EDI00009','ANAYA MULTIMEDIA');
insert into publishers (id,publisher_code, publisher_name) values (10,'EDI00010','IT Revolution Press');
insert into publishers (id,publisher_code, publisher_name) values (11,'EDI00011','PRENTICE-HALL INTERNATIONAL EDITION');
insert into publishers (id,publisher_code, publisher_name) values (12,'EDI00012','Universidad de Castilla La Mancha');
insert into publishers (id,publisher_code, publisher_name) values (13,'EDI00013','PEGUIN RANDOM HOUSE GRUPO S.A');
insert into publishers (id,publisher_code, publisher_name) values (14,'EDI00014','CRC Press');
insert into publishers (id,publisher_code, publisher_name) values (15,'EDI00015','McGraw-Hill');
insert into publishers (id,publisher_code, publisher_name) values (16,'EDI00016','Pearson educaciÛn');
insert into publishers (id,publisher_code, publisher_name) values (17,'EDI00017','McGraw Hill');
insert into publishers (id,publisher_code, publisher_name) values (18,'EDI00018','Editorial MÈdica Panamericana');
insert into publishers (id,publisher_code, publisher_name) values (19,'EDI00019','Manual Moderno');
insert into publishers (id,publisher_code, publisher_name) values (20,'EDI00020','UC');
insert into publishers (id,publisher_code, publisher_name) values (21,'EDI00021','Academic Press');
insert into publishers (id,publisher_code, publisher_name) values (22,'EDI00022','Pearson');
insert into publishers (id,publisher_code, publisher_name) values (23,'EDI00023','Ediciones Universidad Catolica de Chile');
insert into publishers (id,publisher_code, publisher_name) values (24,'EDI00024','-');
insert into publishers (id,publisher_code, publisher_name) values (25,'EDI00025','Ediciones UC');
insert into publishers (id,publisher_code, publisher_name) values (26,'EDI00026','Narcea');
insert into publishers (id,publisher_code, publisher_name) values (27,'EDI00027','Gustavo Gili');
insert into publishers (id,publisher_code, publisher_name) values (28,'EDI00028','Wageningen Academic Publisher');
insert into publishers (id,publisher_code, publisher_name) values (29,'EDI00029','Herder');
insert into publishers (id,publisher_code, publisher_name) values (30,'EDI00030','Express Publishing');
insert into publishers (id,publisher_code, publisher_name) values (31,'EDI00031','Ocho Libros');
insert into publishers (id,publisher_code, publisher_name) values (32,'EDI00032','Pharmaceutical Press');
insert into publishers (id,publisher_code, publisher_name) values (33,'EDI00033','SÌntesis');
insert into publishers (id,publisher_code, publisher_name) values (34,'EDI00034','Elsevier');
insert into publishers (id,publisher_code, publisher_name) values (35,'EDI00035','CABI');
insert into publishers (id,publisher_code, publisher_name) values (36,'EDI00036','Syrawood Publishing House');
insert into publishers (id,publisher_code, publisher_name) values (37,'EDI00037','National Academies Press');
insert into publishers (id,publisher_code, publisher_name) values (38,'EDI00038','Storey Publishing');
insert into publishers (id,publisher_code, publisher_name) values (39,'EDI00039','Idea Books');
insert into publishers (id,publisher_code, publisher_name) values (40,'EDI00040','Paidos');
insert into publishers (id,publisher_code, publisher_name) values (41,'EDI00041','Springer');
insert into publishers (id,publisher_code, publisher_name) values (42,'EDI00042','Siruela');
insert into publishers (id,publisher_code, publisher_name) values (43,'EDI00043','Editoria universitaria');
insert into publishers (id,publisher_code, publisher_name) values (44,'EDI00044','Wiley Blackbell');
insert into publishers (id,publisher_code, publisher_name) values (45,'EDI00045','Current Conceptions, Inc.');
insert into publishers (id,publisher_code, publisher_name) values (46,'EDI00046','Barcelona');
insert into publishers (id,publisher_code, publisher_name) values (47,'EDI00047','Buenos Aires');
insert into publishers (id,publisher_code, publisher_name) values (48,'EDI00048','Madrid');
insert into publishers (id,publisher_code, publisher_name) values (49,'EDI00049','New York');
insert into publishers (id,publisher_code, publisher_name) values (50,'EDI00050','Oxford');
insert into publishers (id,publisher_code, publisher_name) values (51,'EDI00051','Universal');
insert into publishers (id,publisher_code, publisher_name) values (52,'EDI00052','Fondo editorial UMCE');
insert into publishers (id,publisher_code, publisher_name) values (53,'EDI00053','RIL editores');
insert into publishers (id,publisher_code, publisher_name) values (54,'EDI00054','Cambridge University Press');
insert into publishers (id,publisher_code, publisher_name) values (55,'EDI00055','PIRAMIDE');
insert into publishers (id,publisher_code, publisher_name) values (56,'EDI00056','Pearson EducaciÛn');
insert into publishers (id,publisher_code, publisher_name) values (57,'EDI00057','FONDO DE CULTURA ECON”MICA');
insert into publishers (id,publisher_code, publisher_name) values (58,'EDI00058','Ediciones Universidad Alberto Hurtado');
insert into publishers (id,publisher_code, publisher_name) values (59,'EDI00059','OíReilly');
insert into publishers (id,publisher_code, publisher_name) values (60,'EDI00060','Prentice Hall.');
insert into publishers (id,publisher_code, publisher_name) values (61,'EDI00061','Routledge Taylor & Francis');
insert into publishers (id,publisher_code, publisher_name) values (62,'EDI00062','SAGE Publications Inc');
insert into publishers (id,publisher_code, publisher_name) values (63,'EDI00063','Elsevier Science');
insert into publishers (id,publisher_code, publisher_name) values (64,'EDI00064','Cuatro Vientos');
insert into publishers (id,publisher_code, publisher_name) values (65,'EDI00065','Acanto S.A');
insert into publishers (id,publisher_code, publisher_name) values (66,'EDI00066','University of Chicago Press');
insert into publishers (id,publisher_code, publisher_name) values (67,'EDI00067','Editorial Critica');
insert into publishers (id,publisher_code, publisher_name) values (68,'EDI00068','Debolsillo');
insert into publishers (id,publisher_code, publisher_name) values (69,'EDI00069','Bradford Books');
insert into publishers (id,publisher_code, publisher_name) values (70,'EDI00070','Katz editores');
insert into publishers (id,publisher_code, publisher_name) values (71,'EDI00071','Servizo de PublicaciÛns e Intercambio CientÌfico da USC');
insert into publishers (id,publisher_code, publisher_name) values (72,'EDI00072','MIT PRESS');
insert into publishers (id,publisher_code, publisher_name) values (73,'EDI00073','Albujayra sl');
insert into publishers (id,publisher_code, publisher_name) values (74,'EDI00074','Albujayra');
insert into publishers (id,publisher_code, publisher_name) values (75,'EDI00075','AMERICAN INSTITUTE OF STEEL CONSTRUCTION');
insert into publishers (id,publisher_code, publisher_name) values (76,'EDI00076','McGraw-Hill Education');
insert into publishers (id,publisher_code, publisher_name) values (77,'EDI00077','CENGAGE LEARNING');
insert into publishers (id,publisher_code, publisher_name) values (78,'EDI00078','McGraw-Hill Interamericana de EspaÒa S.L.');
insert into publishers (id,publisher_code, publisher_name) values (79,'EDI00079','ClÈ international');
insert into publishers (id,publisher_code, publisher_name) values (80,'EDI00080','FCE');
insert into publishers (id,publisher_code, publisher_name) values (81,'EDI00081','Ediciones Universidad del BÌo-BÌo + STOQ editoria');
insert into publishers (id,publisher_code, publisher_name) values (82,'EDI00082','Wiley');
insert into publishers (id,publisher_code, publisher_name) values (83,'EDI00083','Pasado y Presente');
insert into publishers (id,publisher_code, publisher_name) values (84,'EDI00084','JOHN WILEY AND SONS');
insert into publishers (id,publisher_code, publisher_name) values (85,'EDI00085','TAYLOR AND FRANCIS GROUP');
insert into publishers (id,publisher_code, publisher_name) values (86,'EDI00086','Blackwell');
insert into publishers (id,publisher_code, publisher_name) values (87,'EDI00087','Saunders Elsevier');
insert into publishers (id,publisher_code, publisher_name) values (88,'EDI00088','Wolters Kluwer');
insert into publishers (id,publisher_code, publisher_name) values (89,'EDI00089','Pearson Prentice Hall');
insert into publishers (id,publisher_code, publisher_name) values (90,'EDI00090','Macmillan Learning');
insert into publishers (id,publisher_code, publisher_name) values (91,'EDI00091','Routledge');
insert into publishers (id,publisher_code, publisher_name) values (92,'EDI00092','CENGAGE');
insert into publishers (id,publisher_code, publisher_name) values (93,'EDI00093','Edit AC Madrid');
insert into publishers (id,publisher_code, publisher_name) values (94,'EDI00094','Springer-Verlag New York');
insert into publishers (id,publisher_code, publisher_name) values (95,'EDI00095','Santillana');
insert into publishers (id,publisher_code, publisher_name) values (96,'EDI00096','Ediciones Mundiprensa');
insert into publishers (id,publisher_code, publisher_name) values (97,'EDI00097','Ediciones SM Chile S.A.');
insert into publishers (id,publisher_code, publisher_name) values (98,'EDI00098','Ediciones Pir·mide');
insert into publishers (id,publisher_code, publisher_name) values (99,'EDI00099','STOQ editorial');
insert into publishers (id,publisher_code, publisher_name) values (100,'EDI00100','Omega S.A.');
insert into publishers (id,publisher_code, publisher_name) values (101,'EDI00101','CSIC');
insert into publishers (id,publisher_code, publisher_name) values (102,'EDI00102','Rueda');
insert into publishers (id,publisher_code, publisher_name) values (103,'EDI00103','Literatura Random');
insert into publishers (id,publisher_code, publisher_name) values (104,'EDI00104','LIMUSA');
insert into publishers (id,publisher_code, publisher_name) values (105,'EDI00105','Limusa Wiley');
insert into publishers (id,publisher_code, publisher_name) values (106,'EDI00106','Sexto piso');
insert into publishers (id,publisher_code, publisher_name) values (107,'EDI00107','NÛmadas');
insert into publishers (id,publisher_code, publisher_name) values (108,'EDI00108','Seix barral');
insert into publishers (id,publisher_code, publisher_name) values (109,'EDI00109','Caja negra editores');
insert into publishers (id,publisher_code, publisher_name) values (110,'EDI00110','DALY');
insert into publishers (id,publisher_code, publisher_name) values (111,'EDI00111','LEXUS');
insert into publishers (id,publisher_code, publisher_name) values (112,'EDI00112','TRILLAS');
insert into publishers (id,publisher_code, publisher_name) values (113,'EDI00113','EDICIONES TURISTICAS LADEVI PROTURISMO');
insert into publishers (id,publisher_code, publisher_name) values (114,'EDI00114','LEGAL PUBLISHING');
insert into publishers (id,publisher_code, publisher_name) values (115,'EDI00115','Mc Graw Hill Education');
insert into publishers (id,publisher_code, publisher_name) values (116,'EDI00116','Edhasa');
insert into publishers (id,publisher_code, publisher_name) values (117,'EDI00117','Pearson EducaciÛn, Mexico');
insert into publishers (id,publisher_code, publisher_name) values (118,'EDI00118','Integral, Barcelona');
insert into publishers (id,publisher_code, publisher_name) values (119,'EDI00119','MUNDI-PRENSA');
insert into publishers (id,publisher_code, publisher_name) values (120,'EDI00120','LUMEN HUMANITAS');
insert into publishers (id,publisher_code, publisher_name) values (121,'EDI00121','Pearson ELT');
insert into publishers (id,publisher_code, publisher_name) values (122,'EDI00122','Editora Copygraph LTDA');
insert into publishers (id,publisher_code, publisher_name) values (123,'EDI00123','left coast press');
insert into publishers (id,publisher_code, publisher_name) values (124,'EDI00124','Editorial Acribia s.a.');
insert into publishers (id,publisher_code, publisher_name) values (125,'EDI00125','cendeac');
insert into publishers (id,publisher_code, publisher_name) values (126,'EDI00126','Gredos');
insert into publishers (id,publisher_code, publisher_name) values (127,'EDI00127','Thieme');
insert into publishers (id,publisher_code, publisher_name) values (128,'EDI00128','Mosby');
insert into publishers (id,publisher_code, publisher_name) values (129,'EDI00129','Wiley-Blackwell');
insert into publishers (id,publisher_code, publisher_name) values (130,'EDI00130','AKAL');
insert into publishers (id,publisher_code, publisher_name) values (131,'EDI00131','S.L. FONDO DE CULTURA ECONOMICA DE ESPA—A');
insert into publishers (id,publisher_code, publisher_name) values (132,'EDI00132','Cambridge Univeristy press');
insert into publishers (id,publisher_code, publisher_name) values (133,'EDI00133','United States Pharmacopeia');
insert into publishers (id,publisher_code, publisher_name) values (134,'EDI00134','Mc Graw Hill');
insert into publishers (id,publisher_code, publisher_name) values (135,'EDI00135','La Muralla');
insert into publishers (id,publisher_code, publisher_name) values (136,'EDI00136','Elsevier Health Sciences');
insert into publishers (id,publisher_code, publisher_name) values (137,'EDI00137','Donn');
insert into publishers (id,publisher_code, publisher_name) values (138,'EDI00138','El Croquis');
insert into publishers (id,publisher_code, publisher_name) values (139,'EDI00139','Shinkenchiku-sha');
insert into publishers (id,publisher_code, publisher_name) values (140,'EDI00140','Detail');
insert into publishers (id,publisher_code, publisher_name) values (141,'EDI00141','Melos ediciones musicales');
insert into publishers (id,publisher_code, publisher_name) values (142,'EDI00142','Ablex Publishing');
insert into publishers (id,publisher_code, publisher_name) values (143,'EDI00143','Focal Press');
insert into publishers (id,publisher_code, publisher_name) values (144,'EDI00144','Wolke');
insert into publishers (id,publisher_code, publisher_name) values (145,'EDI00145','Alianza M˙sica');
insert into publishers (id,publisher_code, publisher_name) values (146,'EDI00146','Michael Wiese production');
insert into publishers (id,publisher_code, publisher_name) values (147,'EDI00147','Real Musical');
insert into publishers (id,publisher_code, publisher_name) values (148,'EDI00148','Mundimusica');
insert into publishers (id,publisher_code, publisher_name) values (149,'EDI00149','Madrid: Real Musical');
insert into publishers (id,publisher_code, publisher_name) values (150,'EDI00150','Madrid: Alianza Musica');
insert into publishers (id,publisher_code, publisher_name) values (151,'EDI00151','Barcelona: Seix Barral');
insert into publishers (id,publisher_code, publisher_name) values (152,'EDI00152','Akal Ediciones Sa');
insert into publishers (id,publisher_code, publisher_name) values (153,'EDI00153','CASIMIRO Libros');
insert into publishers (id,publisher_code, publisher_name) values (154,'EDI00154','AAB Office The Warwick Enterprise Park, Wellesbourne, Warwick CV35 9EF, UK');
insert into publishers (id,publisher_code, publisher_name) values (155,'EDI00155','editorial siglo XXI');
insert into publishers (id,publisher_code, publisher_name) values (156,'EDI00156','Acantilado Quaderns Crema, S. A . U.');
insert into publishers (id,publisher_code, publisher_name) values (157,'EDI00157','Prometeo');
insert into publishers (id,publisher_code, publisher_name) values (158,'EDI00158','taurus');
insert into publishers (id,publisher_code, publisher_name) values (159,'EDI00159','Princeton Architectural Press');
insert into publishers (id,publisher_code, publisher_name) values (160,'EDI00160','The MIT Press');
insert into publishers (id,publisher_code, publisher_name) values (161,'EDI00161','Tecnos');
insert into publishers (id,publisher_code, publisher_name) values (162,'EDI00162','Blackwell Science Ltd');
insert into publishers (id,publisher_code, publisher_name) values (163,'EDI00163','Kerber†');
insert into publishers (id,publisher_code, publisher_name) values (164,'EDI00164','cendeuc');
insert into publishers (id,publisher_code, publisher_name) values (165,'EDI00165','pre-textos');
insert into publishers (id,publisher_code, publisher_name) values (166,'EDI00166','Colegio oficial de aparejadores y arquitectos tecnic');
insert into publishers (id,publisher_code, publisher_name) values (167,'EDI00167','Thames & Hudson');
insert into publishers (id,publisher_code, publisher_name) values (168,'EDI00168','charta');
insert into publishers (id,publisher_code, publisher_name) values (169,'EDI00169','elba');
insert into publishers (id,publisher_code, publisher_name) values (170,'EDI00170','la fabrica');
insert into publishers (id,publisher_code, publisher_name) values (171,'EDI00171','Urano');
insert into publishers (id,publisher_code, publisher_name) values (172,'EDI00172','Elsievier');
insert into publishers (id,publisher_code, publisher_name) values (173,'EDI00173','Saunders');
insert into publishers (id,publisher_code, publisher_name) values (174,'EDI00174','Cambridge University Press');
insert into publishers (id,publisher_code, publisher_name) values (175,'EDI00175','Instituto de Salud P˙blica de Chile, Ministerio de Salud, Gobierno de Chile');
insert into publishers (id,publisher_code, publisher_name) values (176,'EDI00176','Alianza Musica');
insert into publishers (id,publisher_code, publisher_name) values (177,'EDI00177','CreateSpace');
insert into publishers (id,publisher_code, publisher_name) values (178,'EDI00178','Island Press');
insert into publishers (id,publisher_code, publisher_name) values (179,'EDI00179','Stoq');
insert into publishers (id,publisher_code, publisher_name) values (180,'EDI00180','GG');
insert into publishers (id,publisher_code, publisher_name) values (181,'EDI00181','S.L. CIVITAS EDICIONES');
insert into publishers (id,publisher_code, publisher_name) values (182,'EDI00182','The Guilford Press');
insert into publishers (id,publisher_code, publisher_name) values (183,'EDI00183','Ediciones UACh (Universidad Austral de Chile)');
insert into publishers (id,publisher_code, publisher_name) values (184,'EDI00184','Mediterraneo');
insert into publishers (id,publisher_code, publisher_name) values (185,'EDI00185','Instituto de Salud Publica de Chile, Ministerio de Salud');
insert into publishers (id,publisher_code, publisher_name) values (186,'EDI00186','De Facto Publishing');
insert into publishers (id,publisher_code, publisher_name) values (187,'EDI00187','Routledge');
insert into publishers (id,publisher_code, publisher_name) values (188,'EDI00188','ELSEVIER ESPA—A');
insert into publishers (id,publisher_code, publisher_name) values (189,'EDI00189','AutoediciÛn Financiada FC Go.Reg. Tarapac· Emelnor Impresores');
insert into publishers (id,publisher_code, publisher_name) values (190,'EDI00190','Scheidegger und Spiess AG, Verlag');
insert into publishers (id,publisher_code, publisher_name) values (191,'EDI00191','Aguilar-Asuri');
insert into publishers (id,publisher_code, publisher_name) values (192,'EDI00192','Celeste');
insert into publishers (id,publisher_code, publisher_name) values (193,'EDI00193','RevertÈ');
insert into publishers (id,publisher_code, publisher_name) values (194,'EDI00194','Holt, Rinehart & Winston');
insert into publishers (id,publisher_code, publisher_name) values (195,'EDI00195','Wadsworth Publishing Co Inc');
insert into publishers (id,publisher_code, publisher_name) values (196,'EDI00196','MCGRAW-HILL / INTERAMERICANA DE ESPA—A S.A.');
insert into publishers (id,publisher_code, publisher_name) values (197,'EDI00197','Walter Luzio');
insert into publishers (id,publisher_code, publisher_name) values (198,'EDI00198','Ediciones Universitarias de ValparaÌso, Universidad CatÛlica de ValparaÌso.');
insert into publishers (id,publisher_code, publisher_name) values (199,'EDI00199','978-987-629-327-3');
insert into publishers (id,publisher_code, publisher_name) values (200,'EDI00200','Arena Libros');
insert into publishers (id,publisher_code, publisher_name) values (201,'EDI00201','C·tedra');
insert into publishers (id,publisher_code, publisher_name) values (202,'EDI00202','Prentice Hall');
insert into publishers (id,publisher_code, publisher_name) values (203,'EDI00203','Hipatia');
insert into publishers (id,publisher_code, publisher_name) values (204,'EDI00204','Universidad de Playa Ancha');
insert into publishers (id,publisher_code, publisher_name) values (205,'EDI00205','Rutgers University Press');
insert into publishers (id,publisher_code, publisher_name) values (206,'EDI00206','Prueba');
insert into publishers (id,publisher_code, publisher_name) values (207,'EDI00207','UACh');
insert into publishers (id,publisher_code, publisher_name) values (208,'EDI00208','Blume');
insert into publishers (id,publisher_code, publisher_name) values (209,'EDI00209','Ediciones Universidad CatÛlica de Chile');
insert into publishers (id,publisher_code, publisher_name) values (210,'EDI00210','Paleontological Society');
insert into publishers (id,publisher_code, publisher_name) values (211,'EDI00211','W H Freeman');
insert into publishers (id,publisher_code, publisher_name) values (212,'EDI00212','Elsevier');
insert into publishers (id,publisher_code, publisher_name) values (213,'EDI00213','Jones & Bartlett');
insert into publishers (id,publisher_code, publisher_name) values (214,'EDI00214','Lippincott Williams and Wilkins');
insert into publishers (id,publisher_code, publisher_name) values (215,'EDI00215','panamericana');
insert into publishers (id,publisher_code, publisher_name) values (216,'EDI00216','UNIVERSIDAD DE CANTABRIA');
insert into publishers (id,publisher_code, publisher_name) values (217,'EDI00217','Destino');
insert into publishers (id,publisher_code, publisher_name) values (218,'EDI00218','Pearson Chile');
insert into publishers (id,publisher_code, publisher_name) values (219,'EDI00219','Harvard University Graduate School of Design ñ Mohsen Mostafavi y Gareth Doherty');
insert into publishers (id,publisher_code, publisher_name) values (220,'EDI00220','FUNDACION CAJA DE ARQUITECTOS');
insert into publishers (id,publisher_code, publisher_name) values (221,'EDI00221','Texas A&M University Press, College Station');
insert into publishers (id,publisher_code, publisher_name) values (222,'EDI00222','Medica Panamericana');
insert into publishers (id,publisher_code, publisher_name) values (223,'EDI00223','Biblioteca Nueva SL');
insert into publishers (id,publisher_code, publisher_name) values (224,'EDI00224','Gustavo Gili- EspaÒa');
insert into publishers (id,publisher_code, publisher_name) values (225,'EDI00225','Ediciones Universidad CatÛlica');
insert into publishers (id,publisher_code, publisher_name) values (226,'EDI00226','Mediterr·neo');
insert into publishers (id,publisher_code, publisher_name) values (227,'EDI00227','GGILI');
insert into publishers (id,publisher_code, publisher_name) values (228,'EDI00228','SIGLO XXI');
insert into publishers (id,publisher_code, publisher_name) values (229,'EDI00229','Anagrama');
insert into publishers (id,publisher_code, publisher_name) values (230,'EDI00230','Biblioteca Ayacucho');
insert into publishers (id,publisher_code, publisher_name) values (231,'EDI00231','Gusravo Gili');
insert into publishers (id,publisher_code, publisher_name) values (232,'EDI00232','Ernst & Sohn');
insert into publishers (id,publisher_code, publisher_name) values (233,'EDI00233','OXFORD');
insert into publishers (id,publisher_code, publisher_name) values (234,'EDI00234','Editorial Trotta S.A.');
insert into publishers (id,publisher_code, publisher_name) values (235,'EDI00235','wiley-vch');
insert into publishers (id,publisher_code, publisher_name) values (236,'EDI00236','princeton university press');
insert into publishers (id,publisher_code, publisher_name) values (237,'EDI00237','Universidad de Chile');
insert into publishers (id,publisher_code, publisher_name) values (238,'EDI00238','Mc Gill-queens University Press');
insert into publishers (id,publisher_code, publisher_name) values (239,'EDI00239','Haworth Pr Inc');
insert into publishers (id,publisher_code, publisher_name) values (240,'EDI00240','Garland');
insert into publishers (id,publisher_code, publisher_name) values (241,'EDI00241','Davies');
insert into publishers (id,publisher_code, publisher_name) values (242,'EDI00242','EDUSP');
insert into publishers (id,publisher_code, publisher_name) values (243,'EDI00243','Ed. Links Structure');
insert into publishers (id,publisher_code, publisher_name) values (244,'EDI00244','Wiley & Sons Inc, New York');
insert into publishers (id,publisher_code, publisher_name) values (245,'EDI00245','Ed.Mairea-Celeste, Madrid');
insert into publishers (id,publisher_code, publisher_name) values (246,'EDI00246','RUBES');
insert into publishers (id,publisher_code, publisher_name) values (247,'EDI00247','Volpe/Fox');
insert into publishers (id,publisher_code, publisher_name) values (248,'EDI00248','MÈdica Panamericana, S.A.');
insert into publishers (id,publisher_code, publisher_name) values (249,'EDI00249','Lippincott, Willians & Wilkins');
insert into publishers (id,publisher_code, publisher_name) values (250,'EDI00250','Quintessence Publishing Co Ltd');
insert into publishers (id,publisher_code, publisher_name) values (251,'EDI00251','John Wiley & Sons, Inc.');
insert into publishers (id,publisher_code, publisher_name) values (252,'EDI00252','Sage Publications, Inc');
insert into publishers (id,publisher_code, publisher_name) values (253,'EDI00253','National Academy Press');
insert into publishers (id,publisher_code, publisher_name) values (254,'EDI00254','LibrerÌa Aurea Cl·sicos');
insert into publishers (id,publisher_code, publisher_name) values (255,'EDI00255','Calamar EdiciÛn y DiseÒo, S.L.');
insert into publishers (id,publisher_code, publisher_name) values (256,'EDI00256','Gustavo Gili');
insert into publishers (id,publisher_code, publisher_name) values (257,'EDI00257','planeta');
insert into publishers (id,publisher_code, publisher_name) values (258,'EDI00258','Z-E');
insert into publishers (id,publisher_code, publisher_name) values (259,'EDI00259','Bicentenario');
insert into publishers (id,publisher_code, publisher_name) values (260,'EDI00260','D.G. de PlanificaciÛn. Centro de Publicaciones, Ministerio de Fomento');
insert into publishers (id,publisher_code, publisher_name) values (261,'EDI00261','Springer Verlag. Australia');
insert into publishers (id,publisher_code, publisher_name) values (262,'EDI00262','UNIVERSITY OF SAN FRANCISCO sullivan@usfca.edu');
insert into publishers (id,publisher_code, publisher_name) values (263,'EDI00263','informa health care');
insert into publishers (id,publisher_code, publisher_name) values (264,'EDI00264','desconocido');
insert into publishers (id,publisher_code, publisher_name) values (265,'EDI00265','DESCONOCIDO');
insert into publishers (id,publisher_code, publisher_name) values (266,'EDI00266','Serie Roja');
insert into publishers (id,publisher_code, publisher_name) values (267,'EDI00267','C&C Ediciones');
insert into publishers (id,publisher_code, publisher_name) values (268,'EDI00268','The American Psychiatric Publishing');
insert into publishers (id,publisher_code, publisher_name) values (269,'EDI00269','Butterworth-Heinemann');
insert into publishers (id,publisher_code, publisher_name) values (270,'EDI00270','Waveland Pr Inc');
insert into publishers (id,publisher_code, publisher_name) values (271,'EDI00271','Porr˙a');
insert into publishers (id,publisher_code, publisher_name) values (272,'EDI00272','Canbridge University Press');
insert into publishers (id,publisher_code, publisher_name) values (273,'EDI00273','Castalia-Ohio State University.');
insert into publishers (id,publisher_code, publisher_name) values (274,'EDI00274','Michigan, University Microfilms International.');
insert into publishers (id,publisher_code, publisher_name) values (275,'EDI00275','Vox (Bibliogr·fica)');
insert into publishers (id,publisher_code, publisher_name) values (276,'EDI00276','OrganizaciÛn Panamericana de la salud');
insert into publishers (id,publisher_code, publisher_name) values (277,'EDI00277','Demos');
insert into publishers (id,publisher_code, publisher_name) values (278,'EDI00278','CONICYT, Menssage');
insert into publishers (id,publisher_code, publisher_name) values (279,'EDI00279','Ediciones del Temple');
insert into publishers (id,publisher_code, publisher_name) values (280,'EDI00280','Don Bosco');
insert into publishers (id,publisher_code, publisher_name) values (281,'EDI00281','U.de Santiago');
insert into publishers (id,publisher_code, publisher_name) values (282,'EDI00282','ChileamÈrica CESOC');
insert into publishers (id,publisher_code, publisher_name) values (283,'EDI00283','Red Internacional del Libro');
insert into publishers (id,publisher_code, publisher_name) values (284,'EDI00284','Ediciones documentos');
insert into publishers (id,publisher_code, publisher_name) values (285,'EDI00285','Pittsburg.PA:Instituto Internacional de Literatura Iberoamericana');
insert into publishers (id,publisher_code, publisher_name) values (286,'EDI00286','Tusquets');
insert into publishers (id,publisher_code, publisher_name) values (287,'EDI00287','Editorial Nueva Sociedad');
insert into publishers (id,publisher_code, publisher_name) values (288,'EDI00288','Can. Spec. Publ. Fish. Aquat. Sci.');
insert into publishers (id,publisher_code, publisher_name) values (289,'EDI00289','Elsevier EspaÒa S.A.');
insert into publishers (id,publisher_code, publisher_name) values (290,'EDI00290','journal of the marine biological association of the UK');
insert into publishers (id,publisher_code, publisher_name) values (291,'EDI00291','Cambridge, MA: Harvard University Press');
insert into publishers (id,publisher_code, publisher_name) values (292,'EDI00292','Ariel');
insert into publishers (id,publisher_code, publisher_name) values (293,'EDI00293','Taurus ediciones');
insert into publishers (id,publisher_code, publisher_name) values (294,'EDI00294','Labor (Barcelona)');
insert into publishers (id,publisher_code, publisher_name) values (295,'EDI00295','Universidad Arcis');
insert into publishers (id,publisher_code, publisher_name) values (296,'EDI00296','Masson');
insert into publishers (id,publisher_code, publisher_name) values (297,'EDI00297','CrÌtica');
insert into publishers (id,publisher_code, publisher_name) values (298,'EDI00298','ciertopez');
insert into publishers (id,publisher_code, publisher_name) values (299,'EDI00299','VICENS VIVES');
insert into publishers (id,publisher_code, publisher_name) values (300,'EDI00300','Macmillan');
insert into publishers (id,publisher_code, publisher_name) values (301,'EDI00301','Caister Academic Press');
insert into publishers (id,publisher_code, publisher_name) values (302,'EDI00302','McGraw-Hill/Appleton & Lange');
insert into publishers (id,publisher_code, publisher_name) values (303,'EDI00303','Fondo de Cultura EconÛmica');
insert into publishers (id,publisher_code, publisher_name) values (304,'EDI00304','informacion en: http://www.clinpathcd.com/');
insert into publishers (id,publisher_code, publisher_name) values (305,'EDI00305','Edimetri Ril Editores');
insert into publishers (id,publisher_code, publisher_name) values (306,'EDI00306','McGrawHill Interamericana');
insert into publishers (id,publisher_code, publisher_name) values (307,'EDI00307','Elsevier Mosby');
insert into publishers (id,publisher_code, publisher_name) values (308,'EDI00308','Harcourt');
insert into publishers (id,publisher_code, publisher_name) values (309,'EDI00309','Mc Grawhill. Interamericana');
insert into publishers (id,publisher_code, publisher_name) values (310,'EDI00310','CENGAGE Learning (Pag. 25)');
insert into publishers (id,publisher_code, publisher_name) values (311,'EDI00311','CENGAGE Learning (Pag. 22)');
insert into publishers (id,publisher_code, publisher_name) values (312,'EDI00312','CENGAGE Learning (Pag 9)');
insert into publishers (id,publisher_code, publisher_name) values (313,'EDI00313','CENGAGE Learning (Pag. 12)');
insert into publishers (id,publisher_code, publisher_name) values (314,'EDI00314','CENGAGE Learning (Pag. 10)');
insert into publishers (id,publisher_code, publisher_name) values (315,'EDI00315','CENGAGE Learning (Pag 5)');
insert into publishers (id,publisher_code, publisher_name) values (316,'EDI00316','CENGAGE Learning (Pag. 13)');
insert into publishers (id,publisher_code, publisher_name) values (317,'EDI00317','CENGAGE Learning (Pag 4)');
insert into publishers (id,publisher_code, publisher_name) values (318,'EDI00318','CENGAGE Learning (Pag. 16)');
insert into publishers (id,publisher_code, publisher_name) values (319,'EDI00319','CENGAGE Learning (Pag. 23)');
insert into publishers (id,publisher_code, publisher_name) values (320,'EDI00320','Optimal Books');
insert into publishers (id,publisher_code, publisher_name) values (321,'EDI00321','Naciones Unidas');
insert into publishers (id,publisher_code, publisher_name) values (322,'EDI00322','Eudeba');
insert into publishers (id,publisher_code, publisher_name) values (323,'EDI00323','Ed. del Corregidor');
insert into publishers (id,publisher_code, publisher_name) values (324,'EDI00324','Galerna');
insert into publishers (id,publisher_code, publisher_name) values (325,'EDI00325','ed.del Corregidor');
insert into publishers (id,publisher_code, publisher_name) values (326,'EDI00326','ASM Press');
insert into publishers (id,publisher_code, publisher_name) values (327,'EDI00327','Iberoamericana');
insert into publishers (id,publisher_code, publisher_name) values (328,'EDI00328','Arco');
insert into publishers (id,publisher_code, publisher_name) values (329,'EDI00329','manantial - argentina');
insert into publishers (id,publisher_code, publisher_name) values (330,'EDI00330','McGraw-Hill Interamericana');
insert into publishers (id,publisher_code, publisher_name) values (331,'EDI00331','GEDISA');
insert into publishers (id,publisher_code, publisher_name) values (332,'EDI00332','Cambridgr University Press');
insert into publishers (id,publisher_code, publisher_name) values (333,'EDI00333','Altazor (?)');
insert into publishers (id,publisher_code, publisher_name) values (334,'EDI00334','LOM');
insert into publishers (id,publisher_code, publisher_name) values (335,'EDI00335','Universidad CatÛlica');
insert into publishers (id,publisher_code, publisher_name) values (336,'EDI00336','Addison Wesley');
insert into publishers (id,publisher_code, publisher_name) values (337,'EDI00337','Marisa Cuneo Ediciones');
insert into publishers (id,publisher_code, publisher_name) values (338,'EDI00338','Editorial Universitaria RamÛn Areces, Madrid');
insert into publishers (id,publisher_code, publisher_name) values (339,'EDI00339','Architectural press');
insert into publishers (id,publisher_code, publisher_name) values (340,'EDI00340','Urban Land Institute');
insert into publishers (id,publisher_code, publisher_name) values (341,'EDI00341','Mc Graww-Hill');
insert into publishers (id,publisher_code, publisher_name) values (342,'EDI00342','ED. UNIVERSIDAD DE CONCEPCI”N');
insert into publishers (id,publisher_code, publisher_name) values (343,'EDI00343','MEDITERR¡NEO');
insert into publishers (id,publisher_code, publisher_name) values (344,'EDI00344','ELSEVIER-MASSON');
insert into publishers (id,publisher_code, publisher_name) values (345,'EDI00345','Edimetri');
insert into publishers (id,publisher_code, publisher_name) values (346,'EDI00346','Granica, Buenos Aires');
insert into publishers (id,publisher_code, publisher_name) values (347,'EDI00347','Granica; Buenos Aires');
insert into publishers (id,publisher_code, publisher_name) values (348,'EDI00348','Pearson - Prentice Hall; Madrid');
insert into publishers (id,publisher_code, publisher_name) values (349,'EDI00349','F.T. Prentice Hall - Madrid');
insert into publishers (id,publisher_code, publisher_name) values (350,'EDI00350','Mexico D.F. Pearson EducaciÛn Prentice Hall');
insert into publishers (id,publisher_code, publisher_name) values (351,'EDI00351','Madrid: Fondo de Cultura EconÛmica');
insert into publishers (id,publisher_code, publisher_name) values (352,'EDI00352','Madrid: Taurus');
insert into publishers (id,publisher_code, publisher_name) values (353,'EDI00353','Nobuko');
insert into publishers (id,publisher_code, publisher_name) values (354,'EDI00354','PAIDOTRIBO');
insert into publishers (id,publisher_code, publisher_name) values (355,'EDI00355','GESTION 2000');
insert into publishers (id,publisher_code, publisher_name) values (356,'EDI00356','PARANINFO');
insert into publishers (id,publisher_code, publisher_name) values (357,'EDI00357','AMORRORTU');
insert into publishers (id,publisher_code, publisher_name) values (358,'EDI00358','ELSEVIER-MASSON');
insert into publishers (id,publisher_code, publisher_name) values (359,'EDI00359','Thomson Learning Publisher');
insert into publishers (id,publisher_code, publisher_name) values (360,'EDI00360','Pearson -Prentice Hall');
insert into publishers (id,publisher_code, publisher_name) values (361,'EDI00361','EUDEMA');
insert into publishers (id,publisher_code, publisher_name) values (362,'EDI00362','Catalonia');
insert into publishers (id,publisher_code, publisher_name) values (363,'EDI00363','Mc Graw-Hill Profesional');
insert into publishers (id,publisher_code, publisher_name) values (364,'EDI00364','Addison_wesley');
insert into publishers (id,publisher_code, publisher_name) values (365,'EDI00365','Elsevier - Mosby');
insert into publishers (id,publisher_code, publisher_name) values (366,'EDI00366','Mosby- Elsevier');
insert into publishers (id,publisher_code, publisher_name) values (367,'EDI00367','W.W. Norton And Company, INC');
insert into publishers (id,publisher_code, publisher_name) values (368,'EDI00368','Blackwell publishing');

SET IDENTITY_INSERT publishers  OFF
GO



-- SELECT * FROM books;

SET IDENTITY_INSERT books  ON
GO

insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (1,'9780198825548','The globalization of world politics. An introduction to international relations ','Baylis, Smith & Owens ','8',2020,1);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (2,'9789211220421','Gobernanza y desempeÒo exportador de los servicios modernos en AmÈrica Latina y la India','Alvarez, Fern·ndez-Stark y Mulder','1',2020,2);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (3,'9788413520070','Pensamiento crÌtico latinoamericano sobre desarrollo','Tahina Ojeda Medina y MarÌa del Carmen Villarreal Villamar','1',2020,3);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (4,' 978-958-8422-59-6','Debates sobre CooperaciÛn  Internacional para el Desarrollo','Jairo Agudelo Taborda','1',2021,4);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (5,'978-607-97144-2-0','TeorÌa y pr·ctica de la CooperaciÛn Internacional para el Desarrollo: Una perspectiva desde MÈxico','Esther Ponce Adame, Simone Lucatello y Rafael Vel·zquez Flores','3',2020,5);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (6,'9789560108456','Historia de las Relaciones Internacionales de Chile 1810-2020','Ra˙l Bernal Meza','1',2020,6);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (7,'978-84-7827-199-3','El tiempo y el espacio en la did·ctica de las cs.sociales','Cristofol A. Trepat; Pilar Comes','5∞',2006,7);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (8,'9507013806','La transposiciÛn did·ctica : del saber sabio al saber enseÒado','Chevallard, Yves y otros ','tercera o superior',2013,8);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (9,'978-8441539907','Arquitectura limpia: GuÌa para especialistas en la estructura y el diseÒo de software','Robert Martin','Primera',2018,9);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (10,'978-1942788003','The DevOps Handbook: How to Create World-Class Agility, Reliability, and Security in Technology Orga','Gene kim','Primera',2016,10);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (11,'8441532109','CÛdigo limpio','Robert Martin','1st Edition',2012,9);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (12,'9780134757599','Refactoring','Martin Fowler','Second',2018,11);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (13,'978-84-9044-349-1','Renovar el asombro. Un panorama de la poesÌa infantil y juvenil contempor·nea en espaÒol','Adolfo CÛrdova','1',2019,12);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (14,'978950644417-4','LA NUEVA EDUCACION ','Cesar Bona','PRIMERA ',2017,13);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (15,'978-1-315-16666-7','Remote Sensing Applications in Environmental and Earth System Sciences','Nicolas R. Dalezios','Primera',2021,14);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (16,'978-607-15-0741-9','Finanzas corporativas','Ross, Stephen A., Westerfield, Randolph W., JaffÈ, Jeffrey F., Jordan, Bradford D.','11',2018,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (17,'970-26-0511-3','FÌsica universitaria. Vol 1. DÈcimo primera ediciÛn ','Sears, Francis W., Zemansky, Mark W., Young','DÈcimo primera',2004,16);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (18,'978-607-15-0553-8','FarmacologÌa para Enfermeras','RodrÌgez Palomares C., Garfias Arvizu, A.','2∞',2011,17);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (19,'978-84-9110','FarmacologÌa en EnfermerÌa. TeorÌa y Casos ClÌnicos','Somoza,Beatriz-Cano M. Victoria -LÛpez Pedro','2∞',2020,18);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (20,'9786074488562','Manual de Publicaciones de la American Psychological Association, 4 ™ ediciÛn ( 7 ™ ediciÛn en inglÈ','american psychological association','7™',2021,19);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (21,'9789561419247','CHILE 1810-2010. La Rep˙blica en cifras','Gert Wagner - JosÈ DÌaz - Rolf L¸ders','EPUB POR FAVOR',2016,20);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (22,'9780128152775','The Science of Animal Growth and Meat Technology','Steve Lonergan, David Topel, Dennis Marple','Second',2018,21);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (23,'978-0134602691','Beef Production and Management Decisions (What`s New in Trades & Technology)','Thomas Field','Sexta',2017,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (24,'9786071514387','MicologÌa medica b·sica','Alexandro Bonifaz ','6 ediciÛn',2020,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (25,'9789561412606','La mujer compositora y su aporte al desarrollo musical chileno','Raquel Bustos Valderrama','original',2012,23);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (26,'-','Earth beings: ecologies of practice across a andean worlds','Marisol de la Cadena','espaÒol',2015,24);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (27,'97801346027','Beef Production and management Decisions','Thomas G. Field','6th',2018,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (28,'9789561426238','CHILE 1810-2010. La Rep˙blica en cifras','Gert Wagner, JosÈ DÌaz, Rolf L¸ders','Favor comprar EPUB',2016,25);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (29,'978-84-277-1437-3','Cerebro y Aprendizaje. Competencias e implicaciones educativas','Jensen, Eric','2010',2010,26);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (30,'84-252-1973-6','Efecto Real. Debates postmodernos sobre fotografÌa.','Picazo, Gloria y Ribalta, Jorge ed.','Primera',2004,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (31,'9789086862924','INRA feeding system for ruminants','INRA','Primera',2018,28);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (32,'13  9788425436529','La FotografÌa. Entre documento y arte contempor·neo','AndrÈ RouillÈ','Tapa blanda',2017,29);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (33,'978-1-4715-7812-0','Career Paths: Journalism','Charles Moore, Jenny Dooley','1',2015,30);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (34,'978-956-335-490-4','Naturaleza en Sociedad: Una mirada a la dimensiÛn humana de la conservaciÛn de la biodiversidad','Cerda, C.; Silva-RodrÌguez. E.; BriceÒo, C.','1',2019,31);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (35,'9780857111746','Physicochemical Principles of Pharmacy In Manufacture, Formulation and Clinical Use','Florence, Alexander T; Attwood, David','6',2015,32);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (36,'8499589537','Tratado general de Biofarmacia y FarmacocinÈtica. Vol. II, VÌas de administraciÛn de f·rmacos: aspec','JosÈ DomÈnech Berrozpe','1',2013,33);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (37,'8499589529','Tratado general de Biofarmacia y FarmacocinÈtica. Vol. I, LADME, An·lisis farmacocinÈtico, Biodispon','JosÈ DomÈnech Berrozpe','1',2013,33);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (38,'9788490222607','Biofarmacia y farmacocinÈtica: Ejercios y problemas resueltos','Antonio Aguilar Ros, MarÌa Consuelo Montejo Rubio, Manuel CaamaÒo Somoza and FÈlix RamÛn MartÌn Mart','2',2014,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (39,'978-0128170526','Animal Agriculture: Sustainability, Challenges and Innovations','Fuller W. Bazer, G. Cliff Lamb, Guoyao Wu','1st EdiciÛn',2019,21);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (40,'9781780645070','Beef Cattle Production Systems','Andy Herring','1st EdiciÛn',2014,35);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (41,'9780134602691','Beef Production and Management Decisions','Thomas G. Field','6th edition',2017,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (42,'9781682866566','Genetic Management of Animals','Dominic Fasso','1st EdiciÛn',2019,36);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (43,'978-0309317023','Nutrient Requirements of Beef Cattle: Eighth Revised Edition (Nutrient Requirements of Animals) ','The NationalAcademies of Sciences, Engineering, Medicine','8va EdiciÛn Revisada',2016,37);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (44,'9781682864388','Animal Breeding and Livestock Management','Carlos Hassey','1st EdiciÛn',2017,36);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (45,'978-1612127446','Temple Grandin`s Guide to Working with Farm Animals: Safe, Humane Livestock Handling Practices for t','Temple Grandin','1st EdiciÛn',2017,38);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (46,'8482362836','InvestigaciÛn Educativa y experiencia vivida','Max Van Manen','4',2003,39);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (47,'8449305659','El tacto en la enseÒanza','Max Van Manen','2',1998,40);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (48,'978-0-85777-838-3','Nursing','Virginia Evans & Kori Salcido','primera',2011,30);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (49,'978-3-540-68616-3','Technical English for Geosciences','Brigitte Markner-J‰ger','1',2008,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (50,'9783319262772','Global Marketing Strategy. An Executive Digest','Schlegelmilch, Bodo','1',2016,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (51,'9780134129945','GLOBAL MARKETING','KEEGAN, WARREN J. - GREEN, MARK C.','9',2017,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (52,'978-84-15937-54-8','La ciudad de las damas','Cristina de Piz·n','2™',2018,42);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (53,'978-956-11-2561-2','Terapia Ocupacional y pragmatismo: Contribuciones teÛricas para la pr·ctica','Rodolfo Morrison Jara','1∫',2017,43);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (54,'978-981-13-8445-5','Ethnography and Education Policy: A Critical Analysis of Normalcy and Difference in Schools','MATUS CLAUDIA','1∫',2019,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (55,'978-1-118-47083-1','Bovine Reproduction','Richard M. Hopper','Primera EdiciÛn',2014,44);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (56,'978-0-7020-7233-8','Veterinary Reproduction and Obstetrics','David E. Noakes, Timothy J. Parkinson, Gary C. W. England','Decima ediciÛn',2019,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (57,'0-9657648-3-4','Pathways pregnancy & parturition','P.L. Senger','Tercera ediciÛn',2012,45);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (58,'84-493-1185-3','La (de)construcciÛn del conocimiento pedagÛgico. ','Antonio J. Colom CaÒellas','PaidÛs IbÈrica',2002,46);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (59,'978-987-538-124-7','Gestionar es hacer que las cosas sucedan','Bernardo Blejmar','NOVEDUC',2014,47);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (60,'978-84-7112-530-9','El diagnÛstico de los niÒos y adolescentes problem·ticos: Una crÌtica a los discursos sobre los tras','Valerie Harwood','Morata',2009,48);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (61,'978-84-7827-903-6','El desarrollo del tacto pedagÛgico','Josep Asensio','GRAO',2010,46);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (62,'978-0-415-895361','Foucault, Power and Education.','Stephen Ball','Routledge',2013,49);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (63,'978-0199024858','The sociology of education in Canad·. Fifth edition. ','Terry Wotherspoon','University Press',2017,50);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (64,'978-1581127997','The Japanese Education System. ','Yasuhiro Nemoto','Publishers',1999,51);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (65,'978-987-629-409-6','Miedo y OsadÌa. La Cotidianidad del Docente que se Arriesga a Practicar una PedagogÌa Transformadora','Freire, P., y Shor, I. ','Siglo XXI',2014,47);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (66,'978-0415479875','School Trouble. Identity, power and politics in education. ','Deborah Youdell','Routledge',2011,49);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (67,'978-956-706-273-7','10 aÒos de bilinguismo en Chile','INDESOR y UMCE','unica',2014,52);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (68,'978-956-01-0497-7','Lectores sordos bilingues: un logro posible','Herrera Fernandez, Valeria ','unica',2017,53);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (69,'9781108436694','TRANSNATIONAL MANAGEMENT: TEXT AND CASES IN CROSS-BORDER MANAGEMENT','CHRISTOPHER BARTLETT - PAUL BEAMISH','8va',2018,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (70,'978-84-368-3830-5','INVESTIGACION DE MARKETING 3.0','TEODORO LUQUE MARTINEZ','1a',2017,55);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (71,'978-84-368-2619-7','TECNICAS DE ANALISIS DE DATOS EN INVESTIGACION DE MERCCADOS','TEODORO LUQUE MARTINEZ','2da',2012,55);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (72,'9788580552553','QuÌmica General','Chang, Raymond','12a',2017,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (73,'9702612861','QuÌmica General','John E. McMurry','5',2009,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (74,'9789505577088','Karl Marx  o el espÌritu del mundo',' Jacques Attali','1',2007,57);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (75,'978-956-357-136-3 ','EnseÒando, afirmando y reconociendo a jÛvenes trans*+ y de gÈnero creativo: Un marco de enseÒanza qu','SJ Miller','1',2018,58);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (76,'978-1449361327','Data Science for Business','Foster Provost and Tom Fawcett ','1',2013,59);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (77,'978-0134291079','Big Data Fundamentals: Concepts, Drivers & Techniques','Thomas Erl, Wajid Khattak, and Paul Buhler ','1',2016,60);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (78,'978-1138811935','A Beginner`s Guide to Structural Equation Modeling','Randall E. Schumaker & Richard G. Lomaz ','4',2016,61);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (79,'978-1483377445','A Primer on Partial Least Squares Structural Equation Modeling (PLS-SEM)','Joe Hair, G. Tomas M. Hult, Christian M. Ringle & Marko Sarstedt ','2',2016,62);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (80,'978-0124114616','Business Intelligence Guidebook: From Data Integration to Analytics','Rick Sherman ','1',2015,63);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (81,'84-89333-20-3','El reencantamiento del mundo ','Morris Berman','2∞ EDICION',2007,64);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (82,'9788415053668','ComunicaciÛn no violenta un lenguaje de vida','Marshall B. Rosenberg','3∞ EDICI”N AMPLIADA',2017,65);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (83,'978-0226521428','Explaining Music : Essays and Explorations','Leonard Meyer','1',1978,66);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (84,'978-84-7423-383-4','El Hombre, Un Signo','Charles Sanders Peirce','1',1988,67);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (85,'978-8483464205','Contra la interpretaciÛn y otros ensayos','Susan Sontag','1',2018,68);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (86,'978-8425432637','Charles Sanders Peirce: SemiÛtica, iconicidad y analogÌa','Mauricio Beuchot','1',2014,29);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (87,'978-0262140966','The Musical Representation : Meaning, Ontology, and Emotion','Charles O. Nussbaum','1',2007,69);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (88,'978-8492946259','Metafisicas Canibales','Eduardo Viveiros de Castro','1',2010,70);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (89,' 978-84-16183-14-2','SemiÛtica - Textos Selectos','Charles Sanders Peirce','1',2015,71);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (90,'026251317X','Spaces speak, are you listening','Harry Blesser','Primera',2011,72);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (91,'8494051903','Gram·tica ·rabe comentada','Antonio morales delgado','primera',2014,73);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (92,'8493741035','Gram·tica pr·ctica de ·rabe','Joana hern·ndez martÌnez','primera ',2009,74);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (93,'9781564240354','Seismic Design Manual, 3rd Edition','AMERICAN INSTITUTE OF STEEL CONSTRUCTION','AISC',2016,75);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (94,'1-56424-007-1','Steel Construction Manual, 15th Ed.','AMERICAN INSTITUTE OF STEEL CONSTRUCTION','AISC',2016,75);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (95,'9786071512093','MARKETING INTERNACIONAL','PHILIP CATEORA','16',2014,76);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (96,'9788483226407','Estrategias de Marketing internacional ','Svend Hollensen','4',2010,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (97,'9786074819489','MARKETING INTERNACIONAL','CZINKOTA, MICHAEL','10',2013,77);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (98,'9788483226407','ESTRATEGIAS DE MARKETING INTERNACIONAL','HOLLENSEN, SVEND ','4',2010,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (99,'9786071512901','NEGOCIOS INTERNACIONALES COMO COMPETIR EN EL MERCADO GLOBAL',' Charles W. L. Hill','10',2015,76);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (100,'978-6071512093','MARKETING INTERNACIONAL','PHILIP CATEORA','16',2014,78);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (101,'978-2-09-038498-7','Nickel 1','HÈlËne Auge Npai','Nickel',2014,79);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (102,'978-968-16-0750-0','El Toro de Minos','Leonard Cottrell','I Ed. XIV reimpresiÛn',2014,80);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (103,'978-956-9741-02-9','Arquitectura y ciudad moderna en el sur de Chile. Memoria, territorio y proyecto','Pablo Fuentes y Veronica Esparza editores','1',2017,81);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (104,'1119142288','Principles of Genetics',' D. Peter Snustad','7 edition',2015,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (105,'9788494100819','El precariado. Una nueva clase social','Guy Standing','Tercera',2013,83);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (106,'978-0471-72756-9','DESIGN AND ANALYSIS OF EXPERIMENTS VOLUMEN 1, 2 Y 3','HINKELMANN, KLAUS AND KEMPTTHORNE, OSCAR','SECOND',2008,84);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (107,'13:978-1-4987-2848-5','DESIGN AND ANALYSIS OF EXPERIMENTS WITH R','LAWSON, JOHN','FIRST',2015,85);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (108,'978-1-4051-1147-8','Veterinary embryology','MacGeady, Thomas A., Quinn, P. J., FitzPatrick, E. S., Ryan, M. T., Cahalan, S.','Sin informaciÛn',2006,86);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (109,'978-0-7020-2899-1','Essentials of domestic animal embryology',' Hyttel, Poul; Sinowatz, Fred; Vejlsted, Morten','sin informaciÛn',2010,87);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (110,'978-84-16353-48-4','EmbriologÌa mÈdica','Langman, Jan; Sadler, T. W.','13a',2016,88);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (111,'321643755','Environmental Geology','Edward Keller','9',2011,89);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (112,'1-4292-3743-0','Environmental Geology: An Earth Systems Approach','Merritts, D., Menking, K., DeWet, A.','2',2014,90);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (113,'73524115','Environmental Geology','Montgomery, C.','10',2013,76);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (114,'978-0415687812','Conservation and Development','Andrew Newsham, Shonil Bhagwat','1',2016,91);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (115,'978-607-526-301-4','ADMINISTRACION. UN ENFOQUE BASADO EN COMPETENCIAS','HELLRIEGEL, DON; JACKSON, SUSAN; SLOCUM JR, JOHN','12',2017,77);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (116,'9786073227674','ADMINISTRACION','ROBBINS, STEPHEN; COULTER, MARY','12',2014,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (117,'978-607-32-2046-0','AuditorÌa Interna','Juan RamÛn Santillana Gonz·lez','tercera',2013,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (118,'978-970-26-0739-7','AuditorÌa un enfoque integral','Alvin A. Arens-Randal Elder-Mark Beasley','Decimoprimera',2007,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (119,'9786075197647','TEORIA Y DISE—O ORGANIZACIONAL','DAFT, RICHARD L.','11',2015,92);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (120,'9786073221177','TEORIA ORGANIZACIONAL, DISE—O Y CAMBIO EN LAS ORGANIZACIONES','JONES, GARETH R.','7',2013,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (121,'9786071509802','INTRODUCCION A LA TEORIA GENERAL DE LA ADMINISTRACION','CHIAVENATO, IDALBERTO','8',2014,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (122,'no disponible','AnatomÌa topogr·fica y aplicada de los animales domÈsticos','BERG, Rolf','2a ',1987,93);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (123,'9786071513670','FarmacologÌa B·sica y ClÌnica','Bertram G. Katzung','13',2015,17);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (124,'978-0-387-94906-2','Hearing by Whales and Dolphins',' Richard R. Fay, Whitlow W.L. Au','1',2000,94);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (125,'978-0-387-97841-3','Comparative Hearing: Mammals','Richard R. Fay','1',1994,94);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (126,'978-956-15-1347-1','AritmÈtica y ¡lgebra Manual Esencial','Baeza, ¡ngela y otros','Primera',2008,95);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (127,'8484766616','EdafologÌa. Uso y ProtecciÛn de los Suelos','Jaume Porta, Marta LÛpez-Acevedo, Rosa Poch','3',2014,96);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (128,'9780133254556','Nature and Properties of Soils, The, 15th Edition','Raymond R. Weil, Nyle C. Brady','15',2017,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (129,'ISBN-10: 0123485304 ','ENCYCLOPEDIA OF SOILS IN THE ENVIRONMENT FOUR-VOLUME SET','Daniel Hillel (Editor-in-Chief)','1',2004,21);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (130,'978-970-26-1132-5','¡lgebra','Oteyza, Elena de','Tercera',2007,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (131,'978-84-9022-842-5','Gray, AnatomÌa para estudiantes','Richard L Drake; Wayne Vogl; Adam W M Mitchell','Tercera',2015,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (132,'9786071505835','Negocios Internacionales. Competencia en el mercado global','Charles Hill','OCTAVA',2011,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (133,'9786074817768','Negocios Globales','Mike Peng','SEGUNDA',2012,92);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (134,'9789563496239','N˙meros Texto para el formador para futuros profesores de enseÒanza b·sica','MartÌnez, SalomÈ y otros','Primera',2014,97);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (135,'978-84-368-2565-7','Matem·ticas para maestros de EducaciÛn Primaria','Segovia, Isidoro y Rico, Luis','Primera',2011,98);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (136,'9789563495980','¡lgebra para futuros profesores de enseÒanza b·sica','MartÌnez, SalomÈ y otros','Primera',2014,97);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (137,'9789569741029','Arquitectura y ciudad moderna en el sur de Chile. Memoria, territorio y proyecto','Pablo Fuentes y Veronica Esparza editores','a',2017,99);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (138,'978-84-282-1561-9','TRATADO PR¡CTICO DE HORTICULTURA','G. Sasias y C. Chesne, M. Guedj','1ra',2011,100);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (139,'978-84-00-09145-3','SedimentologÌa: del proceso fÌsico a la cuenca sedimentaria','Alfredo Arches Miralles','1',2010,101);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (140,'9788472070745','EstratigrafÌa: principios y mÈtodos','Juan Antonio Vera Torres','1',1994,102);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (141,'9788439727972','Como funciona la m˙sica','David Byrne','Primera',2014,103);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (142,'9788483229675','IntroducciÛn a la EconometrÌa, 3ed','Stock, James; Watson, Mark','3era',2012,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (143,'9786070506970','QuÌmica Org·nica','Solomons','3',2014,104);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (144,'9786071512109','QuÌmica Org·nica','Carey, F.A.  McGraw-Hill: MÈxico, 2006','9',2014,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (145,'9786070506963',' QuÌmica Org·nica','Solomons, T.W.G. ','3',2000,105);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (146,'9786077781684','øCÛmo funcional la m˙sica?','David Byrne','prirmera',2014,106);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (147,'8461090152','A La Escucha',' Jean-Luc Nancy','Primera',2013,107);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (148,'8432209473','Escucha esto','Alex Ross','primera',2012,108);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (149,'9789871622528','Oceano de sonido','David Toop','prirmera',2016,109);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (150,'9788495818331','HOTELERIA Y TURISMO: MANUAL DE ADMINISTRACI”N HOTELERA','VV.AA.','2013',2013,110);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (151,'9789972209970','TURISMO, HOTELERÕA Y RESTAURANTES','VV.AA.','Primera',2011,111);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (152,'9786071701985','COMPETITIVIDAD DE LOS DESTINOS TURÕSTICOS','MIGUEL ANGEL ACERENZA','Primera',2009,112);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (153,'978-987-9473-98-6','TURISMO 2.0','TOMAELLO, FLAVIA Y DUER, WALTER','Primera',2015,113);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (154,'9562389243','Contabilidad informaciÛn y control en las empresas; SEXTA EDICI”N','GABRIEL TORRES SALAZAR','Sexta',2010,114);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (155,'978-607-15-1144-7','PreparaciÛn y EvaluaciÛn de Proyectos','Nassir Sapag Chain, Reinaldo Sapag Chain, JosÈ Manuel Sapag P.','6ta',2014,115);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (156,'9780134436050','Introduction to Animal Science: Global, Biological, Social and Industry Perspectives','W. Stephen Damron','Sexta',2018,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (157,'978-987-628-381-6','Una guerra infame La verdadera historia de la Conquista del Desierto','AndrÈs Bonatti , Javier Valdez','1',2015,116);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (158,'978-607-442-021-0','QuÌmica, la Ciencia Central','Theodore L. Browm  ','decimoprimera',2009,117);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (159,'84-7901-047-9','Gaia: una ciencia para curar el planeta',' James Lovelock ','1a',1999,118);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (160,'9788484764311','Las Maquinas AgrÌcolas Y Su AplicaciÛn','Ortiz-CaÒavate Jaime','7a sÈptima',2012,119);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (161,'9789870008606','MetodologÌas de acciÛn social','Ezequiel Ander Egg','2',2013,120);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (162,'9781447923831','ENGLISH FOR INTERNATIONAL TOURISM COURSEBOOK. INTERMEDIATE.','Peter Strutt','Third Edition',2013,121);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (163,'978-956-7119-79-0','BASES METODOL”GICAS PARA EL DIAGN”STICO BACTERIOL”GICO DE LAS INFECCIONES POR CAMPYLOBACTER','Heriberto Fern·ndez J., SofÌa Ochoa A., Janneth Simaluiza M.','1',2016,122);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (164,'978-1-61132-997-1','The Maya Rain Forest Garden, eight milenia of sustanible cultivation of the tropical woodlands','Anabel Ford y Ronald Nigh','primera ediciÛn',2015,123);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (165,'8420007676','La evaluaciÛn sensorial de los alimentos en la teorÌa y la pr·ctica','Antonio Anzald˙a-Morales','1',1994,124);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (166,'9788415556114','Teatro Posdram·tico','Hans_Thies Lehmann','I',2016,125);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (167,'84-473-4625-0','La Odisea','Homero','I',2006,126);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (168,'84-473-4624-2','La IlÌada','Homero','I',2006,126);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (169,'9781455740062','Georgis¥ Parasitology for veterinarians','D Bowman','10',2013,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (170,'978-1-4377-0867-7','Equine Surgery','Auer & Stick','cuarta',2012,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (171,'8480862157, 97884808','Medicina Interna de grandes animales','BP Smith','Cuarta',2010,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (172,'9781416056706','Equine Internal Medicine','SM Reed, WM Bayly, DC Sellon (editores)','Tercera',2010,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (173,'865778264','AO Principles of Equine Osteosynthesis','Fackelman, Auer, Nunamaker, Bramlage, Markel, Richardson','primera',1999,127);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (174,'0-323-1848-3','Atlas of Equine Endoscopy','Natahn Slovis','primera',2004,128);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (175,'978-0-8138-1549-7','Adams & Stashak¥s Lameness in horses','Gary Baxter','sexta',2011,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (176,'978-1-4160-6069-7','Diagnosis and management of lameness in the horse ','Roos & Dyson','segunda',2011,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (177,'9788498411034','EN EL MUNDO INTERIOR DEL CAPITAL. PARA UNA TEORIA FILOSOFICA DELA GLOBALIZACION','PETER SLOTERDIJK','1',2010,42);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (178,'9788498410648','EN EL ESPACIO LEEMOS EL TIEMPO','KARL SCHLOGEL','1',2007,42);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (179,'9788446020646','Espacio del capital. Hacia una geografÌa critica','David Harvey','1',2007,130);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (180,'9789681675318','La nueva naturaleza de los mapas : ensayos sobre la historia de la cartografÌa','John Brian Harley','1',2006,131);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (181,'978-3-7692-6315-2','THE UNITED STATES PHARMACOPEIA - en espaÒol (USP 38 NF 33)','United States Pharmacopeia','38',2015,133);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (182,'978-970-10-6889-2 ','PsicologÌa del Desarrollo, de la infancia a la adolescencia','Papalia , Wendkos y Duskin','11',2005,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (183,'978-84-7133-748-1','MetodologÌa de la investigaciÛn educativa','Bisquerra, Rafael ',' Cuarta',2014,135);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (184,'9780729583442','Introduction to Public Health: Edition 3','Mary Louise Fleming Elizabeth Parker ','3',2015,136);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (185,'0327-9022','Summa+ 76','Varios authors','1a',2005,137);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (186,'0327-9022','Summa +114','Varios authors','1a',2011,137);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (187,'0327-9022','Summa+ 116','Varios authors','1a',2012,137);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (188,'0327-9022','Summa+ 126','Varios authors','1a',2011,137);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (189,'2174-0356','El Croquis 144','Varios authors','1a',2009,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (190,'0021-4302','JA 99','Varios authors','1a',2015,139);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (191,'1614-4600','Detail 3 Concept','Varios authors','1a',2010,140);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (192,'978-0-387-09516-5','Acoustics and the Performance of Music','Jurgen Meyer','Modern acoustics',2009,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (193,'978-978-611-021-1','Ac˙stica musical y organologÌa','Tirso de Olozabal','Melos ediciones music',2007,141);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (194,'1-56750-536-8','Acoustic Communication','Barry Truax','Aplex',2001,142);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (195,'978-0-415-87828-9','Music Technology and the project studio','Dan Hosken','Routledge',2012,91);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (196,'978-0-415-87827-2','An introduction to music technology','Dan Hosken','Routledge',2011,91);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (197,'0-240-51-623-0','Spatial Audio','Francis Rumsey','Music Technology ',2001,143);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (198,'978-0-240-81295-3','Audio production and critical listening','Jason Corey','Focal Press',2010,143);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (199,'978-3-95593-055-4','Loadbang: programming electronic music in Pure Data','Johannes Kreidler','Wolke',2013,144);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (200,'978-84-206-8540-3','Tratado de los objetos musicales','Pierre Schaeffer','Alianza M˙sica',2008,145);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (201,'978-0-941188-26-5','Sound Design','David Sonnenschein','Michael Wiese ',2001,146);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (202,'9788438700549','Tratado de armonia','Arnold Schoenberg','?',2015,147);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (203,'9788493663117','ArmonÌa','Walter Piston','?',2009,148);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (204,'9788438701416','ArmonÌa del siglo XX','Vincent Persichetti','?',2007,149);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (205,'9788420685458','Musica, sociedad y educaciÛn','Christopher Small','1™',2006,150);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (206,'9788432209130','El ruido eterno: escuchar al siglo XX a travÈs de su m˙sica ','Alex Ross','1™',2009,151);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (207,'9781315856032','Ways of Sensing. Understanding the Senses In Society','David Howes y Costance Classen','Primera',2014,91);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (208,'978-8446019015','Libro de los pasajes','Walter Benjamin','3',2005,152);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (209,'9788493837594','Breve historia de la fotografÌa','Walter Benjamin','1',2011,153);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (210,'9788446040903','Calle de sentido unico','Walter Benjamin','1',2015,130);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (211,'ISSN 0265-1491','3rd Symposium on Potato Cyst Nematodes','Haydock, P.P.J. (ed)','primera',2010,154);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (212,'978-987-629-126-2','La viena de fin de siglo','Carl Schorske','primera',2011,155);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (213,'978-84-16011-32-2','Terror y utopia','Karl Schlogel','primera',2014,156);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (214,'9875580163','El color del rio','Susana Silvestri','primera',2006,157);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (215,'9788498410648','en el espacio leemos el tiempo','Kar Schlogel','primera',2007,42);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (216,'978-956-347-686-6','Historia del teatro en Chile (1941-1990)','Juan AndrÈs PiÒa','I',2014,158);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (217,'9781616890681','Le Corbusier Redrawn','SooJin (Steven) Park','1a',2012,159);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (218,'9780262521246','A Concrete Atlantis','Reyner Banham','1a',1989,160);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (219,'9788430938698','CINCO CARAS DE LA MODERNIDAD: MODERNISMO, VANGUARDIA, DECADENCIA, KITSCH, POSTMODERNISMO','Matei Calinescu','1',2002,161);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (220,'978-0632063789','Introduction to Ore-Forming Processes','Laurence Robb','Primera',2005,162);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (221,'978-1107022225','Ore Deposit Geology','John Ridley','Primera',2013,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (222,'978-3936646368','Eric Fischl: The Krefeld-Project','Robert Rosenblum','Kerber†',2001,163);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (223,'84-96299-40-6','Un arte contextual','Paul Ardenne','MURCIA',2012,164);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (224,'978-84-8191','La Pintura Encarnada','Georges Didi-Huberman ','espaÒa',2007,165);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (225,'978 8489882089','Teoria de los colores','JOHANN WOLFGANG VON GOETHE†,','Murcia',2001,166);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (226,'978-84-96898','Ante la Imagen','Georges Didi-Huberman ','MURCIA',2010,164);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (227,'978-0500275351','Lucian Freud Paintings','Robert Hughes','Thames & Hudson',2001,167);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (228,'978 8881581177','Boltanski','Christian Boltanski','charta',2010,168);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (229,'978-84-939902-7-5','El siglo del Collage. Una apreciaciÛn radical','Jose Francisco Yras','barcelona',2012,169);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (230,'978 841 530 3510','David Hockeney: El gran Mensaje','David Hockeney','a fabrica',2001,170);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (231,'978 84 252 2289-4','Colores, Historia y significado','Anne Varichon','Gustavo Gili',2001,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (232,'978-84-7953-628-2','El color. Un mÈtodo para dominar el arte de combinar colores','Betty Edwards','espaÒa',2006,171);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (233,'978 847 844 2102','Asi lo veo Yo','David Hockeney','siruela',2001,42);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (234,'84-460-1083-6','Diccionario Akal del color ','Rosa Gallegos/ Juan Carlos Sanz','ESPA—A',2001,130);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (235,'bpm512.a3','trigonometria','sullivan','septima',2006,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (236,'521790697','Clinical Biochemistry of Domestic Animals',' Jiro Jerry Kaneko (Editor), John W. Harvey (Editor), Michael L. Bruss (Editor)','6',2008,172);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (237,'978-1-118-47273-6','Veterinary Hematology and Clinical Chemistry,','Mary Anna Thrall (Editor), Glade Weiser (Editor), Robin Allison (Editor), Terry W. Campbell (Editor)','2nd Edition',2012,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (238,'9781437701739','Veterinary Hematology: A Diagnostic Guide and Color Atlas','John W. Harvey DVM PhD DACVP (Autor)','1',2012,172);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (239,'978-1455740833','Canine and Feline Cytology: A Color Atlas and Interpretation Guide',' Rose E. Raskin DVM PhD DACVP (Author), Denny Meyer DVM DACVIM DACVP (Author)','3',2015,173);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (240,'978-1118611272','Exotic Animal Hematology and Cytology',' Terry W. Campbell (Author)','4',2015,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (241,'978-1416061304','Infectious Diseases of the Dog and Cat',' Craig E. Greene DVM MS DACVIM ','4',2011,173);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (242,'978-0323044684','Atlas of Canine and Feline Peripheral Blood Smears, 1e (Small Animal Laboratory Essentials)',' Amy C. Valenciano DVM MS DACVP (Author), Rick Cowell (Author), Theresa Rizzi (Author), Ronald D. Ty','1',2013,128);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (243,'978-0-8138-1798-9','Schalm`s Veterinary Hematology','Douglas J. Weiss (Editor), K. Jane Wardrop (Editor)','6th Edition',2010,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (244,'978-1-4443-4836-1','Sedimentology and Sedimentary Basins: From Turbulence to Tectonics','Mike R. Leeder','2nd Edition',2011,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (245,'978-0-521-51664-8','Structural Geology','FOSSEN Haakon','Reprinted with correc',2011,174);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (246,'9789567770106','Atlas para la identificacion de elementos parasitarios microscopicos en deposiciones','Patricio Torres H., Maria Isabel Jercic L. y colaboradores','Segunda',2014,175);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (247,'978-84-206-6308-1','Historia de la M˙sica occidental','Grout - Palisca','6™',2011,176);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (248,'978-84-206-8207-5','La interpretaciÛn histÛrica de la m˙sica','Lawson y Stowell','1',2005,176);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (249,'978-84-206-6468-2','La m˙sica en la Època Barroca','Bukofzer','2',2002,176);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (250,'978-84-206-6465-1','Un siglo de m˙sica grabada','Timothy Day','1',2002,176);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (251,'1505634644','Biomimicry Resource Handbook','Dayna Baumeister','1ra',2014,177);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (252,'9781597267151','Biophilic Cities: Integrating Nature Into Urban Design and Planning','Tim Beatley','cualquiera',2011,178);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (253,'9788488386786','JOAO LUIS CARRILHO DA GRACA, TRAZAR CONEXIONES, CONSTRUIR PAUTAS','JOAO LUIS CARRILHO DA GRACA','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (254,'9783869223360','Constructores Inmigrantes. Transferencia de Alemania a Chile','Renato D`AlenÁon, Francisco Prado','1a ediciÛn',2013,25);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (255,'9788488386816','MVRDV, CIUDAD EVOLUTIVA','MVRDV','INGLES / ESPA—OL',2014,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (256,'9789569082009','Arquitectura: CrÌtica y Nueva …poca','Enrique Browne','1a ediciÛn',2011,179);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (257,'9788488386823','DAVID CHIPPERFIELD, FIGURA Y ABSTRACCI”N','DAVID CHIPPERFIELD','INGLES / ESPA—OL',2014,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (258,'9788488386700','Bevk Perovi&#263;, CONDICIONALISMO','Bevk Perovi&#263;','INGLES / ESPA—OL',2012,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (259,'9788488386793','SELGASCANO, VACILANTE NATURALEZ','SELGASCANO','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (260,'9788425227097','Arquitectura y CrÌtica','Josep MarÌa Montaner','3a ediciÛn',2013,180);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (261,'9788425226267','Los ojos de la piel. La arquitectura y los sentidos','Juhani Pallasmaa','2da ediciÛn',2014,180);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (262,'9788488386779','ALVARO SIZA, LECCIONES MAGISTRALES','ALVARO SIZA','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (263,'9788488386762','SMILJAN RADIC, EL JUEGO DE LOS OPUESTOS','SMILJAN RADIC','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (264,'8488386737','Glenn Murcutt Feathers Of Metal','Glenn Murcutt ','INGLES / ESPA—OL',2012,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (265,'9788488386809','STEVEN HOLL, CONCEPTOS Y MELODÕAS','STEVEN HOLL','INGLES / ESPA—OL',2014,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (266,'9788488386694','Neutelings Riedijk, CONVENCIONES E IDENTIDAD','Neutelings Riedijk','INGLES / ESPA—OL',2012,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (267,'9788488386670','Studio Mumbai, MANERAS DE HACER Y DE FABRICAR','Studio Mumbai','INGLES / ESPA—OL',2011,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (268,'9788488386656','Valerio Olgiati, AFINADAS DISCORDANCIAS','Valerio Olgiati','INGLES / ESPA—OL',2011,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (269,'9788488386649','SANAA, ARQUITECTURA INORG¡NICA','SANAA (Sejima + Nishizawa)','INGLES / ESPA—OL',2011,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (270,'9788488386632','Aires Mateus, CONSTRUIR EL MOLDE DEL ESPACIO','Aires Mateus','INGLES / ESPA—OL',2011,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (271,'9788488386625','Herzog & de Meuron, PROGRAMA, MONUMENTO, PAISAJE','Herzog & de Meuron','INGLES / ESPA—OL',2011,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (272,'9788488386618','Sou Fujimoto, TEORÕA E INTUICI”N, MARCA Y EXPERIENCIA','Sou Fujimoto','INGLES / ESPA—OL',2010,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (273,'9788488386755','Caruso St John, RUDA SUTILEZA','Caruso St John','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (274,'9788488386748','Sean Godsell, RUDA SUTILEZA','Sean Godsell','INGLES / ESPA—OL',2013,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (275,'9788488386724','RCR Arquitectes, ABSTRACCI”N PO…TICA','RCR Arquitectes','INGLES / ESPA—OL',2012,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (276,'9788488386717','Mansilla+TuÒÛn, GEOMETRÕAS ACTIVAS','Mansilla+TuÒÛn','INGLES / ESPA—OL',2012,138);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (277,'9788447033027','ECONOMIA URBANA Y REGIONAL: INTRODUCCION A LA GEOGRAFIA ECONOMICA','FERNANDO RUBIERA MOROLLON','1ra',2014,181);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (278,'1-57230-049-3','Spatial Behavior: A Geographic Perspective','Reginald G. Golledge & Robert J. Stimson','1st',1997,182);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (279,'978-956-9412-06-6','EcologÌa Forestal: Bases para el manejo sustentable y conservaciÛn de los bosques nativos de Chile','C. Donoso, ME Gonz·lez, A. Lara (editores)','primera',2014,183);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (280,'978-956-220-366-1','Gestion del Cuidado en Enfermeria.','Ayala, Ricardo; Torres, Cristina y Calvo, M Julia','1',2014,184);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (281,'0','Aprender a Cuidar. Didactica del Proceso de Enfermeria.','Ayala, Ricardo y Messing, Beate','1',2000,184);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (282,'0','Aprender a Cuidar. Didactica del Proceso de Enfermeria.','Ayala, Ricardo y Messing, Beate','1',2014,184);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (283,'9788483223895','GeomorfologÌa','Mateo GutiÈrrez Elorza','1',2008,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (284,'978-956-7770-10-6','Atlas para la identificacion de elementos parasitarios microscopicos en deposiciones','Maria Isabel Jercic Lara - Patricio Torres Hevia','segunda',2014,185);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (285,'978-0615264097','The American Vitruvius: An Architects` Handbook of Civic Art','WERNER HEGEMANN, ELBERT PEETS','quinta',2008,186);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (286,'9780415424073','Sitte, Hegemann and the Metropolis: Modern Civic Art and International Exchanges','Charles C. Bohl, Jean-FranÁois Lejeune ','segunda',2013,187);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (287,'9788481749137','PROYECCIONES RADIOLOGICAS Y CORRELACION ANATOMICA (6™ ED.)','KENNETH L. BONTRAGER; J. LAMPIGNANO','septima',2006,188);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (288,'978-1-118-59113-0','Techniques for Virtual Palaeontology','Mark Sutton, Imran Rahman, Russell Garwood ','1',2014,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (289,'978-956-332-448-8','øQuiÈn le pÛne el cascabel al gato?','Guillermo Ward GÛmez','I',2010,189);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (290,'9788496898417','DIDACTICA DE LA LIBERACION: ARTE CONCEPTUALISTA LATINOAMERICANO','LUIS CAMNITZER','1',2009,125);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (291,'978-3-85881-723-5','Peter Zumthor: Buildings and Projects, 1985-2013','thomas Durisch','1',2014,190);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (292,'84-036-0071-2','Arquitectura Contempor·nea','Manfredo Tafuri','1',1989,191);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (293,'9788425211713','LA ESFERA Y EL LABERINTO, Vanguardia y arquitectura de Piranesi a los aÒos `70 ','TAFURI MANFREDO','1',1984,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (294,'9788482110837','TeorÌas e Historia de la Arquitectura ','Manfredo Tafuri','1',1997,192);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (295,'9788429126280','Fundamentos de EconomÌa','Krugman, Paul; Wells, Robin; Graddy, Kathryn','Segunda',2012,193);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (296,'978-0030202865','Form in tonal music: an introduction to analysis','Douglass M. Green','2nd',1979,194);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (297,'ISBN-13: 978-0155062','Anthology of Musical Analysis','Charles Burkhart','6th Revised edition',2003,195);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (298,'9788448139988','INGENIERIA DE CARRETERAS Vol. II','Carlos Kraemer, Miguel Angel del Val','Primera Edicion',2004,196);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (299,'1119991498','Handbook of Marine Craft Hydrodynamics and Motion Control','Thor I Fossen','1',2011,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (300,'471941131','Guidance and Control of Ocean Vehicles','Thor I Fossen','1',1994,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (301,'9561906481','Suelos de Chile','Walter Luzio, editor','1',2010,197);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (302,'41545','Historia de la m˙sica occidental de Carlos Poblete Varas','Carlos Poblete Varas','Tercera ediciÛn',1982,198);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (303,'978-987-629-327-3','Por una pedagogÌa de la pregunta','Paulo Freire ,  Antonio Faundez','1',2013,199);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (304,'84-95897-09-1','Corpus','Jean-Luc Nancy','1∞ ESPA—OL',2003,200);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (305,'8437617251','Ulises','James Joyce','5',2005,201);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (306,'9788483223895','GeomorfologÌa','Mateo Gutierrez Elorza','1',2008,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (307,'978-84-936743-1','Construyendo escuelas democr·ticas','Feito Alonso, Rafael / LÛpez Ruiz, Juan Ignacio','2™',2008,203);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (308,'84-7827-256-9','El legado PedagÛgico del siglo XX para la escuela del siglo XXI','Jaume Trilla (coord.)','2™',2002,7);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (309,'978-84-936743-0-4','Aprendizaje dialÛgico en la Sociedad de la InformaciÛn','Adriana Aubert, Ainhoa Flecha, Carmen GarcÌa, RamÛn Flecha y Sandra Racionero','3™',2010,203);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (310,'978-956-296-075-5','AdministraciÛn y GestiÛn efectiva en la unidad escolar','Claudio Figueroa LÛpez','1',2009,204);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (311,'6071508762','ParasitologÌa humana','Werner Apt. B.','1',2013,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (312,'0 8135 1762 1','The Anthropology of Self and Behavior','Gerald Michael Erchak','1',1992,205);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (313,'9780521426091','New Directions in Psychological Anthropology','heodore Schwartz, Geoffrey M. White y Catherine A. Lutz','1993',1993,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (314,'123456789','Prueba','Prueba','1',2013,206);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (315,'2336-3012','Prueba','ICI','1',2013,207);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (316,'978-607-15-0744-0','MicologÌa - MÈdica B·sica','Alexandro Bonifaz','4',2012,17);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (317,'978-84-9801-539-3','100 ideas que cambiaron la arquitecura','Richard Weston','1',2012,208);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (318,'9788498015744','Leer la arquitecura, diccionario visual','Owen Hopkins','1',2012,208);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (319,'978-84-9801-353-5','OBRAS MAESTRAS DE LA ARQUITECTURA MUNDIAL','WILL PRYCE','1',2012,208);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (320,'9789561411456','Bases CientÌficas de la DrogadicciÛn','MarÌa Estela AndrÈs, JosÈ Antonio Fuentealba, Katia Gysling. RamÛn Sotomayor','1∫',2010,209);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (321,'978-84-8174-709-6','MÈtodos de investigaciÛn clÌnica y epidemiolÛgica','Josep Ma Argimon Pall·s','tercera',2009,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (322,'1891276492','Macroevolution: Diversity, Disparity, Contingency: Essays in Honor of Stephen Jay Gould','Elisabeth S Vrba and Niles Eldredge','1',2005,210);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (323,'9780716706137','Principles of paleontology','Michael Foote and Arnold Miller','3',2007,211);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (324,'84-8086-959-1','Nelson Tratado de PediatrÌa','Behrman','19',2012,212);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (325,'978-1449601911','Invitation to Oceanography','Pinet, Paul','6ta',2011,213);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (326,'978-0471974710','Estuaries: A Physical Introduction','Dyer, Keith','2da',1998,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (327,'9781437719352','Obstetrics: Normal and Problem Pregnancies:','Gabbe S.','6',2012,173);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (328,'9781608313815','Fetal Monitoring Interpretation','Micki L.','primera',2010,214);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (329,'9786077743231','cirugÌa endoscÛpica en ginecologÌa','garza leal/bustos lopez','primera',2011,215);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (330,'8498352738','Doppler en medicina fetal','gratacos','primera',2010,215);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (331,'9788481021196','GRANDES CALLES','ALLAN B. JACOBS','1',1996,216);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (332,'9788423333356','EL CONOCIMIENTO SECRETO ','David Hockney','espaÒol',2001,217);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (333,'9702610842','Finanzas Corporativas','Johnathan Berk, Peter DeMarzo','1a.',2008,218);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (334,'9786073202527','Las Finanzas en las Empresas Multinacionales','David Eiteman, Arthur Stonehill, Michael Moffet','12',2010,218);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (335,'978-3-03778-189-0','Ecological Urbanism','Varios authors','1',2010,219);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (336,'978-84-939409-3-5','INTRODUCCION AL URBANISMO. LA EVOLUCI”N DE LAS CIUDADES: LA LECCI”N DE LA ANTIG‹EDAD','MARCEL POETE','1',2012,220);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (337,'978-1-60344-135-3','chilean modern architecture since 1950','Fernado Perez Oyarzun, Rodrigo Perez de Arce, Horacio Torrent Schenider','1',2010,221);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (338,'323095615','Pathologic Basis of Veterinary Disease','James F. Zachary  -  M. Donald McGavin','5',2011,128);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (339,'84-7903-917-5','Psicologia','David Myers','7™',2005,222);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (340,'970-613-693-2','TeorÌas de la Personalidad','james Fadiman y Robert frager','segunda',2001,1);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (341,'978-84-9940-089-1','DICCIONARIO DE TERMINOS SOBRE LA CIUDAD Y LO URBANO','Lorenzo LÛpez Trigal','1',2010,223);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (342,'978-84-252-2071-5','Urbanismo Bioclim·tico','Esther Higueras GarcÌa','1',2006,224);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (343,'9789561411920','PediatrÌa Ambulatoria con Enfoque Integral ','Patricia Valenzuela C.; Rosario Moore','1ra.',2009,225);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (344,'956-220-239-9','SemiologÌa Pediatrica','Shonhaut L., Assef M.','1ra.',2004,226);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (345,'978-956-220-323-4','PediatrÌa Ambulatoria','Arnoldo Quezada','2da.',2011,226);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (346,'6071502993','Desarrollo Humano','Diane Papalia','11',2010,15);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (347,'978-1-4020-8645-8','Dimensions of the Sustainable City','Jenks, Mike; Jones, Colin (Eds.)','1',2010,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (348,'9788425220524','la ciudad generica','Rem Koolhaas','sin informacion',2011,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (349,'9788425220357','IDEAS QUE HAN CONFIGURADO EDIFCIIOS','FIL HEARN','SIN INFORMACION',2007,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (350,'9788425221910','Espacio Basura','Rem Koolhaas','SIN INFORMACION',2008,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (351,'9788425224379','Arquitectura y politica, ensayos para mundos anternativos','JOSEP MARIA MONTANER, ZAIDA MUXI','SIN INFORMACION',2011,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (352,'9788432313394','LA ARQUEOLOGIA DEL SABER','MICHEL FOUCAULT','SIN INFORMACION',2009,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (353,'9788425223860','DICCIONARO MANUAL ILUSTRADO DE ARQUITECTURA','DORA WARE, BETTY BEATY','13∞ REIMPRESION',2011,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (354,'9788425224102','DIEZ EDIFICIO CANONICOS 1950-2000','PETER EISENMAN','SIN ',2011,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (355,'9788425223921','SENDAS ONIRICAS DE SINGAPUR, RETRATO DE UNA METROPOLIS POTEMKIMÖ O TREINTA A—OS DE TABLA RASA','Rem Koolhaas','SIN INFORMACION',2011,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (356,'9788425222719','CASA CON PATIO','G‹NTER PFEIFER, PER BRAUNECK','SIN',2009,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (357,'9788425222924','ARQUITECTURA MODERNA EN ZONAS SISMICAS','TERESA GUEVARA','SIN INFORMACION',200,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (358,'97884252221903','SISTENAS ARQUITECTONICOS CONTEMPORANEOS','JOSEP MARIA MONTANER','SIN INFORMACION',2008,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (359,'97884252222368','ALEGORIA DEL PATRIMONIO','FRANCOISE CHOAY','SIN INFORMACION',2007,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (360,'9788425221200','APRENDIENDO DEL POP','DENISE SCOTT BROWN','SIN INFORMACION',2007,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (361,'9788425218514','MEGAESTRUCTURAS, FUTURO URBANO DEL PASADO RECIENTE','REYNER BANHAM','SI',2001,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (362,'9788425223877','2G LIBROS, LINA BOBARDI, OBRA CONSTRUIDA','OLIVIA DE OLIVEIRA','SIN INFORMACION',2010,227);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (363,'84-334-0092-7','EstÈtica de la desapariciÛn','Virilio, Paul','1∫',1988,229);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (364,'980-276-062-5','manifiestos,proclamas y polÈmicas de la vanguardia literaria hispanoamericana','Osorio, Nelson','1∫',1988,230);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (365,'84-493-1036-9','DespuÈs del fin del arte.El arte contempor·neo y el linde de la historia','Danto,Coleman, Arthur','1∫',2003,40);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (366,'978-1-4443-3334-3','Handbook of Food Safety Engineering','Da-Wen-Sun (editor)','Primera',2011,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (367,'9788425218293','La buena vida, visita guiada a las casas de la modernidad','IÒaki Abalos','1',2011,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (368,'9788425221026','HISTORIA DE LA ARQUTECTURA MEXICANA','ENRIQE X.DE ANDA','SIN INFORMACION',2008,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (369,'9788425222740','HISTORIA CRITICA DE LA ARQUITECTURA MODERNA','KENNET FRAMPTON','SIN INFORMACION',2010,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (370,'9788425219559','Arquitectura latinoamericana contemporanea','Hugo Segawa','sin informacion',2004,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (371,'9788425222351','La arquitectura compuesta por partes','Anton Capitel','sin informacion',2009,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (372,'9788425223303','Lo Ordinario','Enrique Walker','primera',2010,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (373,'9788425223273','Pensar la arquitectura','Peter Zumthor','sin informacion',2010,231);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (374,'9788425224058','Cuestiones de persepcion, Fenomenologia de la arquitectura','Steven Holl','primera ',2011,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (375,'9788425223310','La ciudad','Massino Cacciari','primera',2011,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (376,'9788425219887','LA ARQUITECTURA MODERNA, UNA HISTORIA DESAPASIONADA','ALAN COLQUHOUN','SIN INFORMACION',2005,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (377,'9788425223617','Historia del presente inmediato, la invencion del movimiento moderno arquitectonico','Anthony Vidler','primera',2011,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (378,'9788425221170','Atmosferas','Peter Zumthor','3',2009,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (379,'978-84-323-0332-6 ','Vigilar y Castigar','Michel Foucault','1978',1978,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (380,'9788432313394','La arqueologia del saber','Michael Foucault','2009',2009,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (381,'9788425224041','Grandeza, o el problema de la talla','Rem Koolhaas','GG minima',2011,27);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (382,'978-607-15-0600-9','AdministraciÛn de Operaciones. Conceptos y casos contempor·neos','Roger G. Schroeder','Quinta',2011,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (383,'9789682428333','Color ambiental, aplicaciones en arquitectura','TOM PORTER','1A',1988,112);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (384,'9783433018385','The history of the theory of structures: from arch analysis to computational mechanics','Karl-Eugen Kurrer','Primera',2008,232);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (385,'8446024004, 97884460','Arte desde 1900: modernidad, antimodernidad, posmodernidad','Hal Foster, Rosalind E. Krauss, Yves-Alain Bois','ESPA—OL',2006,130);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (386,'978-0-19-956356-2','URBAN ECOLOGY. Patterns, Processes, and Applications','Jari Niemel‰, J¸rgen H. Breuste, Glenn Guntenspergen, Nancy E. McIntyre, Thomas Elmqvist, and Philip','1',2011,233);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (387,'750645520','Descriptive Physical Oceanography','Talley, L., Pickard, G., Emery, W., Swift, J.','Sexta ediciÛn',2011,21);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (388,'978956220-314-2','Obstetricia','Alfredo PÈrez Sanchez- Enrique Donoso','Cuarta (4™)',2011,226);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (389,'978-84-8164-419-7','Obras completas George Trakl','Trakl, George','Segunda',2000,234);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (390,' 978-84-9879-18','PoesÌa completa','Trakl, George','Primera',2010,234);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (391,'3433018383','The history of the theory of structures','Eugen Kurrer','1',2088,235);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (392,'9780691023939','The tower and the bridge: The new art of structural engineering','David P. Billington','1',1111,236);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (393,'978-0-8138-1668-5','Nonthermal Processing Technologies for Food','H. Zhang; G. Barbosa-C·novas; B. Balasubramaniam; P. Dunne; D. Farkas; J. Yuan (editores) ','1™',2011,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (394,'3-540-31210-2','Handbook of soil analysis: mineralogical, organic and inorganic methods','Marc Pansu, Jacques Gautheyrou','1',2006,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (395,'978-956-19-0648-8','Suelos de Chile','Walter Luzio','1',2010,237);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (396,'0773536655) 9780773','Circulation and the City  Essays on Urban Culture','Alexandra Boutros and Will Straw','1',2010,238);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (397,'1560222719','Handbook of Potato Production, Improvement, And Postharvest Management',' J. Gopal and S. M. Paul Khurana','1',2006,239);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (398,'970-686-839-9','Administracion de Operaciones','David Collier - James Evans','segunda edition',2009,77);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (399,'978-1-4051-9978-0','Practical Food Rheology: An Interpretive Approach','Norton, I.; Spyropoulos, F.; Cox, P. (Editores)','Primera',2011,129);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (400,'9780521743495','Urban Ecology (Ecological Reviews)','Kevin J. Gaston (Editor)','primera',2010,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (401,'978-0-8153-4106-2','Molecular Biology of the Cell','Bruce Alberts et al','5',2008,240);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (402,'941022749','Ultrasound Physics Review: A Review for the Ardms SPI Exam ','Cindy Owen','1',2009,241);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (403,'8531401488','Adaptabilidade Humana, IntroduÁao a Antropologia Ecologica.','Emilio F. Moran','10',1994,242);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (404,'9789871566303','La sociedad sin relato. Antrop.y estÈtica de la inminencia','NÈstor GarcÌa Canclini','1∫',2010,70);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (405,'9788496424586','Arquitectura del paisaje','KRAUEL, Jacobo. ','1',2006,243);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (406,'ISBN-13: 978-0471870','Landscape ecology','FORMAN, Richard T.T. and GODRON, Michel','99',1986,244);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (407,'ISBN-13: 978-8482112','La arquitectura de los jardines. De la antig¸edad al siglo XX. ','FARIELLO, Francesco.','1a ediciÛn',2001,245);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (408,'9788449700774','ECOLOGIA URBANA','JAUME TERRADAS','PRIMERA',2001,246);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (409,'978-970-26-0851-6','FÌsica','Jerry Wilson-Anthony Buffa- Bo Lou','sexta ',2007,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (410,'9872082111','Las bases de la medicina basada en evidencias: Como leer un documento.','Greenhalgh, T., & Gimenez, J. ','1',2005,247);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (411,'9789589181751','EpidemiologÌa clÌnica. InvestigaciÛn clÌnica aplicada','¡lvaro Ruiz Morales y Luis Enrique Morillo Z·rate','1',2004,248);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (412,'8493558389','DiseÒo de Investigaciones ClÌnicas','Stephen B. Hulley. Steven M. Cummings Warren S. Browner Deborah G. Grady Thomas B. Newman','3',2008,249);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (413,'1850971269','Evidence-based Dentistry: Managing Information for Better Practice',' Derek Richards, Jan Clarkson, Debora Matthews, Rick Niederman','1',2008,250);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (414,'123738741','Research Methodology in the Medical and Biological Sciences ','Petter Laake, Haakon Breien Benestad, Bjorn Reino Olsen','1',2007,21);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (415,'8445818724','Fundamentos de radiologÌa dental','Whaites, E.','4',2008,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (416,'978-0-470-51792-5','Statistical and Methodological Aspects of Oral Health Research','Emmanuel Lesaffre, Jocelyne Feine (Co-Editor), Brian Leroux (Co-Editor), Dominique Declerck (Co-Edit','1',2009,251);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (417,'803929498','How Many Subjects?: Statistical Power Analysis in Research','Helena Chmura Kraemer, Sue Thiemann','1',1987,252);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (418,'ISBN-10: 0-309-10213','Nutrient Requirements of Small Ruminants:Sheep, Goats, Cervids, and New World Camelids ','National Research Council','ø?',2007,253);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (419,'978-84-460-1532-1','Historia de la crÌtica literaria del siglo XX. Del formalismo al postestructuralismo','Selden, R.','I',2010,254);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (420,'8496235068','Estructuras o por quÈ las cosas no se caen','James Edward Gordon','2',2004,255);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (421,'9788498014358','La arquitectura de la luz natural','Henry Plummer','1',2009,208);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (422,'8425222176','Color y luz. TeorÌa y pr·ctica','Jorrit Tornquist','1',2008,256);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (423,'978-0-321-59550-8','Undestanding Weather and Climate','Edward Aguado & James E. Burt','5',2010,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (424,'0','Inteligencia Social','Daniel Goleman','PLANETA',2006,257);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (425,'9789879649725','MANUAL T…CNICO DE LA AMERICAN ASSOCIATION OF BLOOD BANKS (AABB)','A.A.B.B.','15',2007,258);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (426,'978-956-7892-21-1','1910-2010 AntologÌa: Un Siglo de Dramaturgia Chilena (4 tomos)','Diaz et al','1™',2010,259);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (427,'978-84-498-0822-7 ','Calmar el tr·fico. Pasos para una nueva cultura de la movilidad urbana. ','ALFONSO SANZ ALDU¡N','3',2008,260);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (428,'978-84-481-6283-2','Principios de EconomÌa','Bradley R. Schiller','Sexta',2008,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (429,'978-1-4020-8495-9','Ecopolis, Architecture and Cities for a Changing Climate','Downton, Paul F.','Future City Series',2009,261);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (430,'0-9665807-7-X','A COLOR ATLAS OF PARASITOLOGY','JOHN SULLIVAN','PRIMERA',2009,262);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (431,'978-970-10-6641-6','Sistemas de Control de GestiÛn','Robert Anthony','Duodecima',2008,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (432,'956-14-0759-0','Modelos del C·lculo para las Ciencias MÈdicas','Gonzalo Riera y Ruben Preiss','primera',2005,209);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (433,'1853177040','clinical management of ovarian cancer','lederman,jonathan A.','1',2001,263);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (434,'9788448156466','Manual de Maquinaria de ConstrucciÛn, 2™ ediciÛn (en espaÒol)','DÌaz del RÌo, Manuel','2™',2007,17);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (435,'desconocido','Avances en psicoterapia y cambio psÌquico ','Riquelme, R.; ¡humala, E.','desconocido',2005,264);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (436,'DESCONOCIDO','PsiquiatrÌa ClÌnica ','Heerlein, E.','DESCONOCIDO',2000,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (437,'desconocido','Sinopsis de la PsiquiatrÌa ','Sadock, B. Sadock V.','desconocido',2004,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (438,'desconocido','Fundamentos de PsiquiatrÌa ClÌnica','Valdivieso F. ','desconocido',2005,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (439,'desconocido','SueÒo: diagnÛstico  y tratamiento','Abdaloff, W.','desconocido',2003,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (440,'desconocida','Trastornos Bipolares','Correa E., Silva H., Risco L.','desconocida',2006,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (441,'desconocido','Tecnicas de Psicoterapias Dinamicas','Florenzano, R.','desconocido',1991,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (442,'desconocido','Salud Familiar. Un modelo de AtenciÛn Integral en la AtenciÛn Primaria','Hidalgo C.G. y Carrasco E.','desconocido',2003,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (443,'desconocido','PsiquiatrÌa y Psicologia de la Infancia y Adolescencia','Grau, A y Meneghello, J.','desconocido',2000,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (444,'desconocido','Recomendaciones terapÈuticas en los trastornos mentales','Soler, J; Pere, A. ','desconocido',2000,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (445,'desconocido','DepresiÛn, guia y terapeutica','Retamal, P.','desconocido',2003,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (446,'desconocido ','Terapia Familiar y de Pareja','Roizblatt, A.','desconocido',2006,265);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (447,'9781420052527','Advances in Food Dehydration ','Cristina Ratti (editor)','Primera',2008,14);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (448,'978-3-540-34191-8','Food Physics: Physical Properties - Measurement and Applications','Figura, Ludger O., Teixeira, Arthur A. ','Primera',2007,41);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (449,'GU 2005','PsicopatologÌa de la Mujer','Eduardo Correa , Enrique Jadresic','1∞ ediciÛn',2005,226);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (450,'GPU;3;2:132-133','PSIQUIATRÕA CLÕNICA EN LA UNIDAD DE CORTA ESTADIA','Mario Vidal C.','Sonepsyn',2007,266);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (451,'2;4:375-378','LA ESQUIZOFRENIA CL¡SICA','CÈsar Ojeda','segunda edition am.',2006,267);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (452,'9781585623099','TEXTBOOK OF PSYCHOPHARMACOLOGY','Alan Schatzberg, Charles Nemeroff','Primera EdiciÛn',2009,268);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (453,'471974714','Estuaries: A Physical Introduction','Keith R. Dyer ','2 edition',1998,82);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (454,'750652780','Ocean Circulation','Open University','2nd edition',2001,269);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (455,'1577664299','Introduction to Physical Oceanography','John A. Knauss','2 edition',2005,270);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (456,'970-07-5291-7','Sin novedad en el frente','Erich MarÌa Remarque','Cuarta',2004,271);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (457,'978-0-521-77097-2','Modern Methods of Organic Synthesis','William Carruthers and Iain Coldham','Fourth Edition',2004,272);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (458,'84-7039-842-3','Literatura de Viajes. El Viejo Mundo y el Nuevo.','GarcÌa CastaÒeda, Salvador (coord.) ','1™ ReimpresiÛn',1999,273);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (459,'84-7584-001-9','GeografÌas m·gicas. Viajeros espaÒoles del siglo XIX por paÌses exÛticos (1800-1913). ','Litvak, Lily ','1™ ReimpresiÛn',1984,274);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (460,'8483321947','Diccionario Ilustrado LatÌn-EspaÒol-LatÌn','Ediciones Vox','21',2003,275);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (461,'978-92-75-32913-9','MetodologÌa de la investigaciÛn','Elia Pineda y Eva de Alvarado','3™',2008,276);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (462,'189830916 7','The Creative City: A Toolkit for Urban Innovators ',' Charles Landry','3',1998,277);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (463,'978-956-7524-05-1','La ComunicaciÛn de la Ciencia en Chile','Sergio Prenafeta Jenkin','Primera',2008,278);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (464,'956-8118-09-8','Selleccionadas muestra off de dramaturgia','Carrera, X.; Figueroa, C.','I',2003,279);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (465,'956-18-0544-8','La palabra comprometida Tomo II','Ictus','I',2005,280);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (466,'956-18-0543-X','La palabra comprometida Tomo I','Ictus','I',2005,280);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (467,'956-303-017-6','AntologÌa crÌtica de la dramaturgia anarquista en Chile','Pereira P., Sergio','I',2005,281);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (468,'956-211-120-2','Teatro chileno','Benavente, David','I',2005,282);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (469,'956-7159-62-9','AntologÌa Subjetiva','DÌaz, Jorge','I',1996,283);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (470,'956-261-018-7','Teatro y dictadura','Andrade, Elba; Fuentes, Walter.','I',1994,284);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (471,'1-930744-08-0','Espacio urbano, violencia y comunicaciÛn en AmÈrica Latina ','Mabel MoraÒa(ed)','2002',2002,285);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (472,'8483101424','SalÛn de belleza','Mario Bellatin','2000',2000,286);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (473,'980-317-175-5 ','CiudadanÌas del miedo','Susana Rotker','2000',2000,287);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (474,'1205-7533',' 1983. Catalogue of the living BIVALVIA of the eastern Pacific Ocean: Bering Strait to C','Bernard,F.R.','61',1983,288);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (475,'13:978-84-8174-950-2','EpidemiologÌa y BioestadÌstica: secretos','Nordness, Robert','primera',2006,289);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (476,'968-880-875-1','Principios d MicroeconomÌa','Case, Karl E. y Fair, Ray C.','octava',2008,56);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (477,'0025-3154 ',' The provision of oxygen to developing eggs by female shore crabs (Carcinus maenas) ','wheatly M.G.','61',1981,290);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (478,'978-0-674-53891-7 ','Looking at Cities','Allan Jacobs','1',1985,291);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (479,'84-344-2148-8','La Regulacin Economica de los Servicios Publicos (2 Ejemplares)','Miguel Angel Lasheras','ultima disponible',1999,292);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (480,'84-306-0477-4','La cultura: todo lo que hay que saber','Dietrich Schwanitz','1™',2004,293);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (481,' 84-335-2501-8','El Capitalismo y la moderna teorÌa social','Giddens, Anthony','2',1988,294);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (482,'978-956-8114-75-6','Dramaturgia chilena contempor·nea. 7 authors.','Griffero, RamÛn. Editor y prologuista','1™',2007,295);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (483,'9788445815618','Actividades de la vida diaria','Moruro Mirales Pedro y romero Dulce maria','1™ edition',2005,296);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (484,'84-8432-603-9','Arte poÈtica. Seis conferencias','Borges, Jorge Luis','1™',2005,297);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (485,'956-8425-06-3','Miradas lastimeras no quiero','Radrig·n, Flavia','1™',2006,298);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (486,'956-8425-10-1','Ulises o no seguida de Frontera','Escobar Vila, Benito','1™',2006,298);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (487,'ISBN: 9788481749465 ','INTERRELACIONES NANDA, NIC Y NOC. DiagÛsticos enfermeros, resultados e intervenciones ',' Johnson, M. / Bulechek, G.M. / Butcher, H. / Maas, M.L. / McCloskey Dochterman, J. / Moorh','2™ ediciÛn',2006,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (488,'9788877548603','A TALE OF TWO CITIES (15 COPIAS)','CHARLES DICKENS','READERS',2008,299);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (489,'9781405077033','The Great Gatsby (15 copias)','F. Scott Fitzgerald ','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (490,'9781405076821','GREAT EXPECTATIONS ','CHARLES DICKENS','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (491,'978140500230026000','MOBY DICK (15 COPIAS)','HERMAN MELVILLE ','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (492,'9781405077033','The Great Gatsby ','F. Scott Fitzgerald ','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (493,'978140500230026000','MIDDLE MARCH (15 COPIAS)','GEORGE ELIOT','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (494,'9781405080620','SENSE AND SENSIBILITY (15 COPIAS)','JANE AUSTEN','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (495,'9781405077095','WUTHERING HEIGHTS (15 COPIAS)','EMILY BRONTEE','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (496,'9781405074544','EMMA (15 COPIAS)','JANE AUSTEN','Readers',2008,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (497,'9781405080057','Teaching Reading Skills in a Foreign Language','Christine Nuttall','Paperback ',2005,300);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (498,'9780521281546','Communicative Language Teaching ','William Littlewood','paperback',2000,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (499,'9780521799607','Laughing Matters','Peter Medgyes ','Paperback ',2005,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (500,'9780521793773','Motivational Strategies in the language classroom ','Zoltan Dˆrnyei','paperback',2004,54);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (501,'470712376','Organic Synthesis: The Disconnection Approach','Stuart Warren y  Paul Wyatt','Segunda',2008,84);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (502,'978-1-904455-43-1','Acanthamoeba: Biology and Pathogenesis ','Naveed Khan University of Nottingham, UK','1∫ ediciÛn',2009,301);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (503,'8420540897','DIRECCION DE EMPRESAS INTERNACIONALES','PLA','1',2004,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (504,'9702607639','Direccion de Marketing','Kotler','12',2006,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (505,'838502784','Applied Biopharmaceutics and Pharmacokinetics','Leon Shargel,Andrew B.C. Yu ','4',1999,302);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (506,'9681669088','La etica protestante y espÌritu del capitalsmo','Weber, Max','Segunda',1975,303);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (507,'9681660269','TRATADO LATINOAMERICANO DE SOCIOLOGIA DEL TRABAJO','Enrique De la Garza Toledo','primera',2002,303);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (508,'1-4051-0800-2','International Trade and Agriculture','Won W. Koo; P. Lynn Kennedy','Primera',2005,86);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (509,'na','Veterinary Clinical Pathology. An integrated undergraduate course','Ceron J y col.','1™',2008,304);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (510,'978-956-284-530-4','NIIF vs PCGA en Chile','Valenzuela Acevedo, Marcelo','Primera',2007,305);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (511,'8481747874','Clasificacion de intervenciones de Enfermeria','Mc Closkey - Bulechek','Cuarta',2004,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (512,'8448605411','Planes de cuidados y documentaciÛn clÌnica en enfermerÌa','Carpenito-Moyet','Cuarta',2005,306);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (513,'8481747882','Clasificacion de resultados de Enfermeria','Moorhead y Johnson','Tercera',2005,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (514,'8480862017',' Modelos y teorÌas en EnfermerÌa  ','Marriner - Raile','Sexta',2007,307);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (515,'8481746401','Diagnosticos enfermeros, resulatados e intervenciones: Interrelacin Nanda ','Johnson','⁄ltima',2004,308);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (516,'84-486-0230-7','Fundamentos de EnfermerÌa. Conceptos, proceso y pr·ctica','B·rbara Kozier','5∞ ediciÛn',1990,309);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (517,'444507566','Data analysis methods in physical oceanography','Emery, W. J., & R. E. Thomson','2da',2001,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (518,'970-686-476-8','AdministraciÛn moderna de personal','JoaquÌn Rodriguez Valencia','7™',2007,310);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (519,'970-686-031-2','AdministraciÛn de producciÛn y operaciones','NormanGaither/Greg Frazier','4™',2000,311);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (520,'970-686-229-3','IntroducciÛn a la administraciÛn con un enfoque de sistemas','JoaquÌn Rodriguez Valencia','4™',2003,312);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (521,'970-686-753-8','TeorÌa y diseÒo organizacional','Richard L. Daft','9™',2007,313);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (522,'970-686-463-6','Liderazgo: Teoria, AplicaciÛn y Desarrollo de Habilidades','Robert N. Lussier y Christopher Achua','2™',2005,314);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (523,'970-686-466-0','DirecciÛn moderna de organizaciones','JoaquÌn Rodriguez Valencia','1™',2006,315);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (524,'970-686-500-4','Introduccion a la administracion','Richard L. Daft','4™',2006,316);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (525,'970.686.813.5','AdministraciÛn: Un enfoque basado en competencias','Don Hellriegel, Susam Jackson et al.','11™',2008,317);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (526,'970-686-836-4','AdministraciÛn y control de calidad','James R.Evans/William M. Lindsay','7™',2008,311);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (527,'970-686-623-X','GestiÛn y conocimiento en organizaciones que aprenden','Eduardo Soto/ Alons Sauquet ','1™',2006,318);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (528,'970-686-814-3','AdministraciÛn de operaciones: Bienes, Servicios y Cadenas de valor','David Collier/ James Evans','2™',2008,319);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (529,'978-0-9688543-1-0','Environmental Psychology: Principles and Practice ','Robert Gifford ','4th ediciÁon',2007,320);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (530,'92/1/131811-4','State of the Worldís Cities Report 2006/7 ','Naciones Unidas -Habitat','1',2006,321);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (531,'9502304659','Armando Discepolo Obra dram·tica II','Pelletieri, Osvaldo','1™',1996,322);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (532,'9502303539','Armando Discepolo Obra dram·tica','Pelletieri, Osvaldo','1™',1996,322);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (533,'950-05-0864-8','Teatro Latinoamericano de los 70','Pelletieri, Osvaldo','1™',1987,323);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (534,'950-556-349-3','Obra dram·tica','Discepolo, Armando','1™',1997,324);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (535,'950-05-1536-9','la Nona','Cossa, Roberto','1∫',1990,325);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (536,'958-699-017-6','Introduccion a la ingenierÌa','Pablo Grech','1™ edition',2001,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (537,'978-1-55581-380-2','Diagnostic Medical Parasitology (solilcitar 3 ejemplares)','Lynne Shore GarcÌa, LGS & Associates','5th Edition',2006,326);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (538,'978-1-55581-154-9','Practical Guide to Diagnostic Parasitology (solicitar 3 ejemplares)','Lynne Shore GarcÌa','1∫',1999,326);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (539,'978-1-55581-147-1','The Microsporidia and Microsporidiosis','Murray Wittner','1∫',1999,326);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (540,'978-84-8489-295-3','Teatro y poder en la Època de Carlos II. Fiestas en torno a...','FarrÈ, Judith (ed.)','1™',2007,327);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (541,'978-84-7635-717-0','CrÌtica del conocimiento litarario','Bobes, Carmen','1∫',2008,328);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (542,'978-987-500-114-5','Reensamblar lo social','Latour, Bruno','primera',2008,329);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (543,'13-978-970-10-6106-0','AdministraciÛn Financiera Internacional','Cheol S. Eun y Bruce G. Resnick','4ta.',2007,330);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (544,'8474327873','LA ESPERANZA DE PANDORA','Latour, Bruno','primera',2001,331);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (545,'9789871220854','NUNCA FUIMOS MODERNOS. ENSAYOS DE ANTROPOLOGÌA SIM…TRICA','Latour, Bruno','PRIMERA',2007,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (546,'0-521-83641-7','Designing Economic Mechanisms','Leonid Huwicz y Stanley Reiter','1a Edicion',2006,332);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (547,'9789871283576','AntropologÌa de la imagen','Hans Belting','Irrelevante',2007,70);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (548,'999-999-999-9','Obras reunidas','Alfonso Alcalde','I ',2007,333);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (549,'201180758','Digital image Processing','R.C. Gonzalez; R.E. Woods','Second ',2002,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (550,'956-282-780-1','Teatro en Chile','Luis Pradenas','1™',2006,334);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (551,'956-14-0689-6','T…CNICAS ARGUMENTATIVAS','MÛnica PÈrez y Olly Vega','2™',2007,335);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (552,'321414527','Microeconomics','Jeffrey Perloff','4',2006,336);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (553,'9681859081','La ConsultorÌa de Empresas','Romero Samuel','3',2000,104);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (554,'9682444241','Manual de Instalaciones a Gas','Lesur Luis','˙ltima',1998,112);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (555,'978-956-7173-27-3','Las especies arbÛreas de los bosques templados de Chile y Argentina.AutoecologÌa de','Claudio Donoso','primera',2006,337);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (556,'9788480047128','AntropologÌa del parentesco y de la familia ','Parkin, Robert / Stone, Linda','Primera',2007,338);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (557,'0 7506 57170','Urban design street and square','Cliff Moughtin','3',2003,339);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (558,'0-87420-903-x','remaking the urban waterfront','Urban land Institute','1 ediciÛn',2004,340);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (559,'84-486-0484-9','Manual de DiagnÛsticos de EnfermerÌa (ediciÛn 11 o 10)','Carpenito Lynda ','11',2007,341);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (560,'0','AUTOAPRENDIZAJE DE LA ELECTROCARDIOGRAFÕA','FASCE HENRY, EDUARDO','2™',2003,342);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (561,'956-220-214-3','MANUAL DE URGENCIAS M…DICAS','CUBILLOS, LORENZO','3™',2002,343);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (562,'844581759','Atlas de AnatomÌa Humana','Netter, F.H.','4™',2007,344);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (563,'987-98701-4-X','Vigilar y Castigar','Michel Foucault','primera',1976,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (564,'968230118','Historia de la Sexualidad.  Tres Volumenes','Michel Foucault','1976 primera ediciÛn',2005,228);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (565,'978-956-8637-00-2','AuditorÌa tributaria','Vicente Salort S.','Primera',2007,345);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (566,'950 - 641 - 123 - 9','Desarrollo del Talento Humano: Basado en Competencias','Alles, Martha A.','1™',2005,346);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (567,'950-641 - 317 - 7','DirecciÛn EstratÈgica de Recursos Humanos: GestiÛn por Competencias','Alles, Martha A. ','1™ - 6™ reimpresiÛn',2005,346);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (568,'950-641-244-8','Recursos Humanos Champions','Ulrich, Dave','1∫ - 5™ reimpresiÛn',2004,347);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (569,'84-205-3673-3','La GestiÛn EstratÈgica de los Recursos Humanos','Valle Cabrera, RamÛn J. (coord)','segunda',2004,348);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (570,'84-205-4570-8','GestiÛn por Competencias.  Un modelo estratÈgico para la direcciÛn de Recursos Humanos','Javier Fern·ndez LÛpez','Primera ',2005,349);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (571,'970 - 26 - 0641 - 1','AdministraciÛn de Recursos Humanos','R. Wayne Mondy y Robert M. Noe','Novena',2005,350);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (572,'84-7738-892-0','Como se comenta una obra de teatro.','GarcÌa Barrientos, JosÈ','1™',2001,33);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (573,'UKICGEB/bsf-id5920','Integrated food safety and veterinary public health','s. Buncic','1',2006,35);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (574,'84-7738-478-6','Historia breve de la poÈtica (VersiÛn Luis Alburquerque)','Dolezel, Lubomir','1™',1997,33);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (575,'8437503175','Teatro Chileno Contempor·neo','AntologÌa','Primera',1992,351);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (576,'8430625348','El teatro hispanoamericano','G·lvez Acero, Marina','Primera',1988,352);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (577,'987-584-052-1','Hacer ciudad la construcciÛn de las metrÛpolis','C·tedra Arq. Enrique GarcÌa Espil','1 ediciÛn',2006,353);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (578,'978-84-8019-657-4','FUNDAMENTOS DE LAS TECNICAS DE EVALUACION MUSCULO ESQUELETICAS','PALMER, M. LYNN','1™',2002,354);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (579,'978-84-8019-830-1','RPG. PRINCIPIOS DE REEDUCACION POSTURAL GLOBAL','SOUCHARD, PHILLIPPE E.','3™',2005,354);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (580,'8480885947','MANUAL DE CONSULTORÕA','TOM LAMBERT','2 ED',2001,355);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (581,'0','RobÛtica, Control, DetecciÛn, VisiÛn e Inteligencia','Fu, K.S., R.C. Gonzalez y C.S.G. Lee','3',1990,17);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (582,'9789702607724','RobÛtica','John J. Craig','Tercera',2006,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (583,'8483222957','Redes Neuronales, Autom·tica y RobÛtica ','Edgar Nelson S·nchez Camperos','1',2006,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (584,'0','Modeling and Control of Robot Manipulators','Sciavicco, L., B. Siciliano','2',1996,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (585,'8497322940','Fundamentos de los Computadores','Pedro de Miguel Anasagasti','11',2006,356);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (586,'8483222965','TeleoperaciÛn y TelerobÛtica','Jes˙s M. GÛmez de Gabriel','1',2006,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (587,'8420535745','Robots y Sistemas Sensoriales','F torres; S.T. Puente y otros','2',2002,22);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (588,'8420529931','OrganizaciÛn y Arquitectura de Computadores','William Stallings','5',2006,202);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (589,'0','Fundamentos de RobÛtica','Barrientos A., L.F. PeÒin, C. Balaguer y R. Aracil','2',1997,134);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (590,'?','Transiciones de la Familia (REVISAR EDICIONES POSTERIORES A 2000)','Falicov; C.','?',1991,357);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (591,'848174427-1','EnfermerÌa oncolÛgica','Otto, S.E.','3™',1999,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (592,'844581082-0','500 cuestiones que plantea el cuidado del enfermo renal','Andreu, L','2 ™ ed. ',2005,344);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (593,'844581159-2','Manual de NefrologÌa ClÌnica','Botella, J','1 ™ ed. ',2002,344);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (594,'848174578-2','Manual de nefrologÌa clÌnica','Lorenzo, V','2 ™ ed. ',2002,34);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (595,'844581124-2','Manual de Di·lisis','Daugirdas John','2 ™ ed. ',2003,358);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (596,'970-686-492-x','Fisica Moderna','R.Serway /C.J.Moses/C:A Moyer','tercera',2005,359);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (597,'844581187-X','EpidemiologÌa ClÌnica: Aspectos Fundamentales','Fletcher R.H. ; Fletcher S.W.; Wagner E.H.','Segunda',2003,296);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (598,'0-13-091836-9','AntropologÌa','EMBER Carol, Ember M., Peregrine P.','1',2004,360);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (599,'84-460-0234-5','ArqueologÌa, teorÌas, mÈtodos y pract','RENFREW Colin, BAHN Paul','segunda',1998,130);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (600,'956-244-071-0','Ambiente, bosques y gestiÛn forestal ','Pablo Camus Gayan','1',2006,334);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (601,'84-7754-126-4','CÛmo se hace la historia oral','FOLGUERA Pilar','1',1994,361);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (602,'956-8303-02-2','Historia de los Antiguos Mapuches del','Jose BENGOA','1',2003,362);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (603,'970-613-147-7','FÌsica general ','M·ximo, Antonio y Alvarenga, Beatriz','˙ltima',2006,1);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (604,'9701046544','Finanzas Corporativas','Stephen Ross y Westerfiel Randolph','7a.',2005,330);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (605,'8448146212','Principios de Finanzas Corporativas','Brealey, David y Stewart Myers','8a. ',2006,330);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (606,'84-481-3527-X','Oleohidr·ulica','Serrano Nicol·s, Antonio','1™',2002,363);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (607,'T I :970-26-0511-3 ,TII:970-26-0512-1','Fisica Universitaria ,tomos I y II','Sears_Zemansky-Yong_Freedman','11',2004,364);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (608,'8481747874','Clasificacion de Intervenciones de En','Joanne McCloskey Dochterman','4™',2005,365);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (609,'8481747068','Diagnosticos Enfermeros 2003-2004 ','by NANDA','˙ltima',2003,365);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (610,'8481747882','Clasificacion de Resultados de Enferm','Sue Moorhead & Marion Johnson','3™',2005,366);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (611,'0-393-73106-5','The urban design handbook Techniques ','Urban Design associates (Ray Gindroz)','1',2003,367);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (612,'0-631-23503-5','Designing Cities Critical readings in','Alexander R. Cuthbert','1',2003,368);
insert into books (id, isbn, title, authors, edition, publication_year, publisher_id) values (613,'?','Diccionario de terminos contables fin','Salort S. Vicente','1™',2005,345);

SET IDENTITY_INSERT books  OFF
GO



-- select * from borrowers;

SET IDENTITY_INSERT borrowers  ON
GO

insert into borrowers (id, full_name, identity_document, email, phone_number) values (1,'Mariano Alvarez','22426046-6','mariano.alvarez@uach.cl','987856901');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (2,'pilar andrea uribe sepulveda','12990822-k','pilar.uribe@uach.cl','63 2 221262');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (3,'Claudia Contreras','12747153-3','claudia.contreras@uach.cl','1262');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (4,'Cristian Olivares RodrÌguez','15468444-1','cristian.olivares@uach.cl','940892499');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (5,'Cristian Alejandro Olivares RodrÌguez','15468444-1','cristian.olivares@uach.cl','940892499');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (6,'Felipe Munita Jord·n','13829058-1','felipe.munita@uach.cl','632221425');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (7,'Alicia Zambrano Diaz','13325550-8','alicia.zambrano@uach.cl','2293200');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (8,'JosÈ GarcÈs Vargas','14696692-6','josegarces@uach.cl','632293816');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (9,'Claudio Christian Araya Sassi','10475352-3','claudio.araya01@uach.cl','632221438');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (10,'Consuelo TriviÒos Inostroza','20959058-1','consuelo.trivinos@alumnos.uach.cl','67616469');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (11,'Eliana Sanchez Montoya','9713692-0','esanchez@uach.cl','632293257');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (12,'Marcela VerÛnica Apablaza Santis','17326921-8','marcela.apablaza@uach.cl','63-2293719');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (13,'Luis Valenzuela','15959579-K','luis.valenzuela@uach.cl','1180');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (14,'Rodrigo Alexis Arias Inostroza','10813810-6','rodrigo.arias@uach.cl','2293337');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (15,'Patricio Christian Godoy MartÌnez','9884966-1','patricio.godoy@uach.cl','214377');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (16,'Valentina Javiera Vera Maldonado','20601789-9','valentina.vera02@alumnos.uach.cl','958884893');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (17,'Daniela Makarena Uribe C·rdenas','19138872-0','daniela.uribe02@alumnos.uach.cl','979525469');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (18,'Rodrigo Alexis Arias Inostroza','10813810-6','rodrigo.arias@uach.cl','22293337');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (19,'Luis Valenzuela','15595579-1','luis.valenzuela@uach.cl','1160');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (20,'Claudia Contreras Contreras','12747153-3','claudia.contreras@uach.cl','2293190');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (21,'Carlos Guillermo Fischer Becerra','8014083-5','cfischer@uach.cl','632-221447');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (22,'Rodrigo Alexis Arias Inostroza','10813810-6','rodrigo.arias@uach.cl','632293337');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (23,'Carlos Fischer Becerra','8014083-5','cfischer@uach.cl','632 221447');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (24,'Felipe Andres Martinez Corona','16806523-k','felipe.martinez@uach.cl','981939955');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (25,'Eduardo Silva Rodriguez','15379365-4','eduardo.silva@uach.cl','63-2444347');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (26,'Francisco Javier Arriagada Soto','17397609-7','francisco.arriagada@uach.cl','-2221315');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (27,'Rodrigo Alexis Arias Inostroza','10813810-6','rodrigo.arias@uach.cl','63229337');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (28,'Marcelo Arancibia','10873897-9','marceloarancibia@uach.cl','632293178');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (29,'Felipe Andres Martinez Corona','16806523-k','felipe.martinez@uach.cl','3180');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (30,'Felipe Andres Martinez Corona','16806523-k','felipe.martinez@uach.cl','6322293180');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (31,'ANDRES NOVA REYES','12081832-5','andres.nova@uach.cl','2221532');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (32,'EstefanÌa PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','2293222');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (33,'Marcela VerÛnica Apablaza Santis','17326921-8','marcela.apablaza@uach.cl','632293719');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (34,'CÈsar Eduardo Ulloa Leal','14143234-6','cesar.ulloa@uach.cl','63 2223111');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (35,'Alberto Galaz Ruiz','11669812-9','alberto.galaz@uach.cl','992294164');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (36,'Felipe Martinez Corona','16806523-k','felipe.martinez@uach.cl','3180');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (37,'ANDRES NOVA REYES','12081832-5','andres.nova@uach.cl','632221532');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (38,'CARLOS ANDRES NOVA REYES','12081832-5','andres.nova@uach.cl','632221532');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (39,'Mario Flores Flores','15112210-8','mario.flores@uach.cl','2293521');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (40,'EstefanÌa PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','63-2221425');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (41,'Alejandro Flores Z.','13131142-7','alejandro.flores@uach.cl','632221376');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (42,'Alejandro Flores Z.','13131142-7','alejandro.flores@uach.cl','63221376');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (43,'Alejandro Flores Z.','13131142-7','alejandro.flores@uach.cl','632221563');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (44,'Ester Fecci PÈrez','7197019-1','efecci@uach.cl','3414');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (45,'AndrÈ Rabello Mestre','26410131-k','andre.rabello@uach.cl','632221240');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (46,'Felipe Otondo','12246372-9','felipe.otondo@uach.cl','1415');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (47,'Reda Abd Elhamid Ashuur','23351062-9','reda.ashuur@uach.cl','632221274');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (48,'EDUARDO NU—EZ CASTELLANOS','25172512-8','eduardo.nunez@uach.cl','632444379');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (49,'Jessica MarÌa Cossart Debailleul','23887195-6','jessica.cossart@uach.cl','632221274');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (50,'Roberto Matamala Elorz','6216755-6','matamala@uach.cl','632293182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (51,'tirza barria catalan','13163357-2','tirzabarria@uach.cl','632221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (52,'Ivan Maureira Butler','12212962-4','ivan.maureira@uach.cl','1724');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (53,'EstefanÌa Lidia PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','63-2221425');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (54,'ANDREA BAEZ MONTENEGRO','10429571-1','abaez@uach.cl','3227');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (55,'Javiera del Pilar Bahamonde Azcuy','15934587-4','javiera.bahamonde@uach.cl','3268');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (56,'Joseline Soledad Tapia Zamora','13645095-6','joseline.tapia@uach.cl','&#8203;2293526');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (57,'Joseline Soledad Tapia Zamora','13645095-6','joseline.tapia@uach.cl','2293526');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (58,'Eduardo AndrÈs Silva RodrÌguez','15379365-4','eduardo.silva@uach.cl','4347');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (59,'Marcela Alejandra Coloma Castro','13853359-k','marcela.coloma@uach.cl','2221292');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (60,'Leonardo Vargas Puente','5137249-2','lvargas@uach.cl','1071');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (61,'Rodrigo AnsdrÈs LÛpez MuÒoz','12066684-3','rodrigo.lopez@uach.cl','632444321');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (62,'Alfio Yori Fern·ndez','10756428-4','ayori@uach.cl','2221010');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (63,'Rodolfo Rojas MuÒoz','12491721-2','rodolforojas@uach.cl','672526958');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (64,'Susana Valle Toledo','12005623-9','susanavalle@uach.cl','632221052');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (65,'CLAUDIA BARRERA BERROCAL','9378843-5','claudiabarrera@uach.cl','632221330');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (66,'tirza barria catalan','13163357-2','tirzabarria@uach.cl','2221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (67,'Rodrigo AcuÒa L.','12264312-3','rodrigoacuna@uach.cl','632-293070');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (68,'Rodrigo Manuel Vega San MartÌn','15382583-1','rmvega@uach.cl','221208');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (69,'Cristian Mauricio Mondaca Marino','14102239-3','cristianmondaca@uach.cl','1162');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (70,'Ximena Valenzuela','11591143-0','ximena.valenzuela@uach.cl','672526958');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (71,'GUILLERMO MAURICIO NOVA CASTILLO','10949499-2','gnova@uach.cl','2211158');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (72,'LEONARDO PACHECO CARO','14485668-6','leonardopacheco@uach.cl','632221980');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (73,'LUIS MIGUEL CARTER LEAL','13965025-5','luiscarter@uach.cl','2221172');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (74,'Marianne Werner Becker','13521774-3','marianne.werner@uach.cl','293110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (75,'Ximena Valenzuela M','11591143-0','ximena.valenzuela@uach.cl','672526958');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (76,'Alfredo Nicol·s Erlwein VicuÒa','9617927-8','aerlwein@uach.cl','632221051');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (77,'Loreto Damm Muloz','9298009-k','ldamm@uach.cl','2211158');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (78,'Jeannette M¸ller Concha','11425976-4','jeannettemuller@uach.cl','293188');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (79,'Patricio Christian Godoy MartÌnez','9884966-1','patricio.godoy@uach.cl','632206076');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (80,'Ricardo Ignacio Puebla Bonilla','17703580-7','ricardo.puebla@alumnos.uach.cl','966039190');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (81,'Javier Alejandro Parada Silva','13523551-2','javier.parada@uach.cl','1619');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (82,'Roberto Matamala','6216755-6','matamala@uach.cl','632293182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (83,'Roberto Matamala','6216755-6','matamala@uach.cl','3182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (84,'BenjamÌn Uberti','24638392-8','benjamin.uberti@uach.cl','632221606');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (85,'Nicolas Ansoleaga PÈrez','16209585-4','nicolas.ansoleaga@uach.cl','2221576');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (86,'Nicol·s Ansoleaga PÈrez','16209585-4','nicolas.ansoleaga@uach.cl','2221576');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (87,'Karen Moreno Fuentealba','13010453-3','karenmoreno@uach.cl','632221448');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (88,'Alejandro Jerez Mora','12722981-3','alejandrojerez@uach.cl','632293257');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (89,'Claudia Contreras Contreras','12747153-3','claudia.contreras@uach.cl','3190');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (90,'Miguel Angel Flores Cardenas','16111891-5','miguel.flores@uach.cl','56632221282');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (91,'Emil Osorio Schmied','10746155-8','emilosorio@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (92,'Felipe Otondo','12246372-9','felipe.otondo@uach.cl','2221415');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (93,'David Andres Fernandez','24432027-9','dandres@uach.cl','3049');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (94,'Debbie Guerra Mladonado','8723197-6','dguerra@uach.cl','2293034');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (95,'AndrÈs Horn Morgenstern','15261376-8','andres.horn@uach.cl','632293464');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (96,'Andres Horn Morgenstern','15261376-8','andres.horn@uach.cl','632293464');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (97,'Laura Bˆhm Stoffel','6904222-8','lbohm@uach.cl','632 221729');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (98,'tirza barria','13163357-2','tirzabarria@uach.cl','2221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (99,'Emil Osorio Schmied','10746155-8','emilosorio@uach.cl','2221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (100,'Giovanna Iubini Vidal','15294540-k','giovanna.yubini@docentes.uach.cl','3222');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (101,'Alexandre Corgne','23865379-7','alexandre.corgne@uach.cl','3563');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (102,'isabel margarita santibanez cavieres','13698283-4','galeriareplica@uach.cl','221447');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (103,'isabel margairta santibanez cavieres','13698283-4','galeriareplica@uach.cl','221447');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (104,'javiera fernanda fritis santibaÒez','20020526-k','javiera.fritis@alumnos.uach.cl','95293158');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (105,'Ananda Muller Pereira','24081105-7','ananda.muller@uach.cl','2221075');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (106,'MARIO PINO QUIVIRA','6386009-3','mariopino@uach.cl','1587');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (107,'GaÎlle Julie Plissart','24756248-6','gaelle.plissart@uach.cl','212431');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (108,'PatricioTorres Hevia','2894225-7','ptorres@uach.cl','1284');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (109,'David AndrÈs Fern·ndez','24432027-9','dandres@uach.cl','2221913');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (110,'Paula Villagra','13104257-4','paula.villagra@uach.cl','2293787');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (111,'EDUARDO ANDRES CASTILLO RAMIREZ','10805939-7','eduardo.castillo@uach.cl','2293759');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (112,'EDUARDO ANDRES CASTILLO RAMIREZ','10805939-7','eduardo.castillo@uach.cl','2');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (113,'Mauro Esteban Gonz·lez Cangas','9888548-k','maurogonzalez@uach.cl','221228');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (114,'Maria Julia Calvo Gil','5732206-3','mcalvo2@uach.cl','221280');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (115,'Jasper Moernaut','24590987-k','jasper.moernaut@uach.cl','293526');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (116,'SONIA PUGA ROJAS','5045207-7','spuga@uach.cl','1450');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (117,'Jose Antonio Alonso DÌaz','11496044-6','jalonso@uach.cl','2221329');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (118,'Karen Moreno Fuentelaba','13010453-3','karenmoreno@uach.cl','2221448');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (119,'ROBERTO MATAMALA ELORZ','6216755-6','matamala@uach.cl','229 3182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (120,'Marcelo Arancibia Herrera','10873897-9','marceloarancibia@uach.cl','2293178');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (121,'Sergio Rojas Hoppe','8754635-7','srojas@uach.cl','1156');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (122,'David Andres Fernandez','24432027-9','dandres@uach.cl','213813');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (123,'Vladimir Eleodoro Barraza Jeraldo','8094533-7','vbarraza@uach.cl','2213813');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (124,'Diana Movilla Quesada','24207408-4','diana.movilla@uach.cl','2293985');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (125,'Gonzalo Andres Tampier Brockhaus','14119273-6','gonzalo.tampier@uach.cl','1036');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (126,'VÌctor Rodolfo Gerding Salas','7004146-4','vgerding@uach.cl','222 1234');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (127,'Vladimir Eleodoro Barraza Jeraldo','8094533-7','vbarraza@uach.cl','213813');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (128,'Marcelo Arancibia Herrera','10873897-9','marceloarancibia@uach.cl','2219294');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (129,'EstefanÌa PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','221425');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (130,'EstefanÌa Lidia PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','2293103');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (131,'Rodrigo Manuel Vega SM','15382583-1','rmvega@uach.cl','221208');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (132,'Marcelo Arancibia Herrera','10873897-9','marceloarancibia@uach.cl','293178');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (133,'rene franjola tepper','4876432-0','rfranjol@uach.cl','1284');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (134,'debbie guerra maldonado','8723197-6','dguerra@uach.cl','293533');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (135,'David Inostroza','13410122-9','davidinostroza@uach.cl','293106');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (136,'tirza barria catalan','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (137,'Eliana S·nchez Montoya','9713692-0','esanchez@uach.cl','293834');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (138,'Dra. Claudia Barrera B.','9378843-5','claudiabarrera@uach.cl','221282');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (139,'Karen Moreno Fuentealba','13010453-3','karenmoreno@uach.cl','22 1448');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (140,'Dra. Marlis T‰ger Frey','8156054-4','mtager@uach.cl','229570');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (141,'JosÈ GarcÈs Vargas','14696692-6','jgarces@docentes.uach.cl','293816');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (142,'Pablo moore ross','1076228-6','pablo.moore@uach.cl','263731');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (143,'laura rodrÌguez negrete','9898664-2','lrodriguez@uach.cl','293462');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (144,'Rodrigo Eduardo GÛmez Mura','12493854-6','rodrigo.gomez@uach.cl','221447');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (145,'Fredy Marcelo Riadi Amar','6575205-0','friadi@uach.cl','221958');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (146,'Laura Yazmin RodrÌguez Negrete','9898664-2','lrodriguez@uach.cl','293462');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (147,'Javiera Maira Moya','12489165-5','javiera.maira@uach.cl','293581');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (148,'barria catalan tirza aseneth','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (149,'Enrique Paredes Herbach','7554574-6','eparedes@uach.cl','221062');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (150,'Catalina Alamo Palma','15434067-k','catalina.alamo@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (151,'Dra. Loreto Podest· LÛpez','7818666-6','cenaia@uach.cl','293392');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (152,'tirza barria catalan','13163357-2','tirzabarria@uach.cl','22');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (153,'Kong Shun Ah-Hen','14603738-0','kshun@uach.cl','293216');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (154,'Tirza Barria','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (155,'TIRZA BARRI CATALAN','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (156,'Tirza Barria Catalan','13163357-2','tirzbarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (157,'Tirza Barria Catalan','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (158,'Tirza Barria C','13163357-2','tirzabarria@uach.cl','221110');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (159,'Marcela Mendez Concha','5503426-5','mmendez@uach.cl','221981');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (160,'ELISA CORDERO JAHR','9149631-3','elisacordero@uach.cl','293464');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (161,'JUAN PATRICIO REYES CANCINO','15849589-9','jpreyes@uach.cl','221862');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (162,'JAVIERA MAIRA MOYA','12.489.165','javiera.maira@uach.cl','293436');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (163,'JUANA ROMERO ZAMBRANO','5953841-1','jromero@uach.cl','221423');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (164,'Frank Schanack','22821170-2','frank.schanack@uach.cl','293467');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (165,'Susana Valle Toledo','12005623-9','susanavalle@uach.cl','221052');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (166,'Laura Yazmin Rodriguez Negrete','9898664-2','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (167,'Ximena Carolina Lizana Campos','10944286-0','carolina.lizana@uach.cl','221662');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (168,'Marcela Mendez Concha','5503426-5','mmendez@uach.cl','1981');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (169,'Ilona Concha Grabinger','4682722-8','conchagrabinger@uach.cl','221795');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (170,'Julio Jorge Santamarina Viapiana','6073390-2','jsantama@uach.cl','221069');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (171,'francisco javier ibarra soto','13521719-0','fibarra@uach.cl','221112');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (172,'Roberto Matamala Elorz','6216755-6','matamala@uach.cl','29 3182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (173,'Francisco Ibarra Soto','13521719-0','fibarra@uach.cl','221112');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (174,'JAVIERAMAIRA MOYA','12489165-5','javiera.maira@docentes.uach.cl','293581');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (175,'Jorge Videla Godoy','6796962-6','jvidela@uach.cl','221671');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (176,'Sergio Uribe Espinoza','10976662-3','sergiouribe@uach.cl','293743');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (177,'Daniel Alomar','5521973-7','dalomar@uach.cl','221653');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (178,'olga barbosa','13240706-1','olga.barbosa@docentes.uach.cl','1240');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (179,'Dr. Tomas Baader M.','7003416-6','psiquiat@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (180,'Nelson AndrÈs Aburto Almonacid','13738223-7','nelsonaburto@uach.cl','221152');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (181,'Roberto Matamala Elorz','6216755-6','matamala@uach.cl','293182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (182,'JAVIERA MAIRA MOYA','12489165-5','javiera.maira@docentes.uach.cl','293436');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (183,'Sergio Rojas Hoppe','8754635-7','srojas@uach.cl','221565');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (184,'JAVIERA MAIRA MOYA','12489165-5','javiera.maira@docentes.uach.cl','293464');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (185,'Patricio Torres Hevia','2894225-7','ptorres@uach.cl ','221284');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (186,'GastÛn vergara D','8050663-5','gastonvergara@uach.cl','221202');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (187,'Walter S·ez Caldera','4125763-6','wsaez@uach.cl','221183');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (188,'sergio guzman caracotch','8207620-4','sguzman@uach.cl','221693');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (189,'Ruben Alejandro Seguel Vidal','15311430-7','ruben.seguel@docentes.uach.cl','221294');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (190,'Dr. Hernan Benitez Bulicic','4812966-8','neurolog@uach.cl','221930');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (191,'Hernan Benitez Bulicic','4812966-8','neurolog@uach.cl','221930');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (192,'Dra. Diana Mantero B.','9995763-8','psiquiat@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (193,'Diana Mantero','9995763-8','psiquiat@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (194,'Diana Mantero Barruti','9995763-8','psiquiat@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (195,'Dr. Hern·n BenÌtez Bulicic','4812966-8','psiquiat@uach.cl','221327');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (196,'Manuel Ignacio Montolio Cartes','9255771-5','manuelmontolio@uach.cl','293181');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (197,'Gabriel Arcadio Vallejos Contreras','12235599-3','gabrielvallejos@uach.cl','293132');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (198,'Lorena LÛpez Torres','10666009-3','lorena.lopez@docentes.uach.cl','293181');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (199,'Manuel Eduardo Contreras Seitz','10049222-9','manuelcontreras@uach.cl','293656');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (200,'Francisco MarÌn Herrada','5220771-1','fmarin@uach.cl','221139');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (201,'laura Yazmin Rodriguez negrete','9898664-2','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (202,'Julio Carvajal Rivera','6569205-8','jcarvaja@uach.cl','293756');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (203,'Roberto Matamala Elorz','6216755-6','matamala@uach.cl','2');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (204,'EStefanÌa Lidia PeÒa Steel','11491585-8','estefania.pena@docentes.uach.cl','293181');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (205,'carlos molinet','8196188-3','cmolinet@uach.cl','277126');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (206,'Sergio Rojas Hoppe','8754635-7','srojas@uach.cl','22 11 56');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (207,'carlos molinet flores','8196188-3','cmolinet@uach.cl','2176');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (208,'Laura Rodriguez','9898664-2','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (209,'Teodoro Kausel Kroll','4600560-0','tkausel@uach.cl','221543');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (210,'Juan Carlos Skewes Vodanovic','6086935-9','jskewes@uach.cl','221954');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (211,'Daniela Isabel Urrutia Garcia','13454600-k','diurrutia@uach.cl','293693');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (212,'Patricia TriviÒo Vargas','8655263-9','patriciatrivino@uach.cl','221135');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (213,'Alexia Guerra','13610096-3','alexiaguerra@uach.cl','221478');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (214,'Gabriel Arcadio Vallejos Contreras','12235599-3','gabrielvallejos@uach.cl','221293');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (215,'Dr. Patricio Torres Hevia','2894225-7','ptorres@uach.cl','1284');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (216,'Rodrigo BolaÒos','14650929-0','rodrigobolanos@uach.cl','214349');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (217,'Alejandro Jerez/ Annemarie Nielsen/ Humberto Dˆlz/ Guido Ruiz/','12722981-3','alejandrojerez@uach.cl','293257');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (218,'Clara Olmedo','21584516-8','claraolmedo@uach.cl','293034');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (219,'Clara Olmedo Reynoso','21584516-8','claraolmedo@uach.cl','293034');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (220,'Rodrigo EcheverrÌa Pezoa','10754224-8','rodrigoecheverria@uach.cl','293554');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (221,'Fernando Wittwer Menge','4846755-5','fwittwer@uach.cl','1073');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (222,'Juan Osvaldo Albornoz Rpbertson','5406015-7','jalborno@uach.cl','221440');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (223,'Ricardo Ayala Valenzuela','13130430-7','ricardoayala@uach.cl','221131');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (224,'Jose Garces Vargas','14696692-6','josegarces@uach.cl','293816');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (225,'Jorge Alejandro riveros Sudy','6920182-2','jriveros@uach.cl','293525');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (226,'laura yazmin RodrÌguez Negrete','9898664-2','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (227,'Misael Fuentes Paredes','7990860-6','misaelfuentes@uach.cl','221031');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (228,'Patricio Fernando Torres Hevia','2894225-7','ptorres@uach.cl','221284');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (229,'Roberto Matamala Elorz','6216755-6','matamala@uach.cl','3182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (230,'Gustavo Blanco Wells','9106528-2','gblanco@uach.cl','221547');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (231,'Fredy Riadi Amar','6575205-0','friadi@uach.cl','221958');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (232,'Gustavo Emilio Blanco Wells','9106528-2','gblanco@uach.cl','221547');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (233,'Dr. Teodoro Kausel Kroll','4600560-0','tkausel@uach.cl','221543');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (234,'Jorge Arancibia MuÒoz','6483267-0','jarancibia@uach.cl','221818');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (235,'Rodrigo Alberto EcheverrÌa Pezoa','10754224-8','rodrigoecheverria@uach.cl','293554');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (236,'Guillermo C·rdenas GÛmez','5700430-4','guillermocardenas@uach.cl','221680');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (237,'Mauro E. Gonzalez','9888548-k','maurogonzalez@uach.cl','221228');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (238,'Debbie E. Guerra Maldonado','8723197-6','dguerra@uach.cl','293533');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (239,'Laura Rodriguez Negrete','9898664-2','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (240,'Juan Albornoz Robertson','5406015-7','jalborno@uach.cl','221440');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (241,'Horacio Sanhueza B.','6097692-9','hsanhuez@uach.cl','3072');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (242,'Horacio Sanhueza B.','6097692-9','hsanhuez@uach.cl','3072');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (243,'Roberto Matamala Elorz','6.216.755-','matamala@uach.cl','29 3182');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (244,'Rafael Tamayo castro','5435660-9','rtamayo@uach.cl','221221');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (245,'Robert Martinez Gonzalez','8698333-8','robertmartinez@uach.cl','293727');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (246,'ESTER FECCI P…REZ','7197019-1','efecci@uach.cl','221477');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (247,'Jorge Arancibia MuÒoz','6483267-0','jarancibia@uach.cl','221818');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (248,'Lorenzo Villa Zapata','12700384-K','lorenzovilla@uach.cl','293257');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (249,'MarÌa Eugenia Solari Alberti','No disponible','msolari@uach.cl','293033');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (250,'MarÌa Eugenia Solari Alberti','No disponible','msolari@uach.cl','3033');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (251,'Charlotte Lovengreen','No disponible','clovengr@uach.cl','221069');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (252,'Fredy Riadi','No disponible','friadi@uach.cl','221401');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (253,'Fredy Riadi Amar','No disponible','friadi@uach.cl','221401');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (254,'Misael Fuentes Paredes','No disponible','misaelfuentes@uach.cl','1031');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (255,'Joaquin Castellano ,Jorge Videla','No disponible','jcastell@uach.cl  ,jvidela@uach.cl','221671 , 221849');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (256,'Beate Messing G.','No disponible','messingbeate@uach.cl','221131');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (257,'Beate Messing Grube','No disponible','bmessing@uach.cl','221131');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (258,'Laura Rodriguez Negrete','No disponible','lrodriguez@uach.cl','221943');
insert into borrowers (id, full_name, identity_document, email, phone_number) values (259,'Juan Albornoz Robertson','No disponible','-','-');

SET IDENTITY_INSERT borrowers  OFF
GO

-- select * from profiles;

SET IDENTITY_INSERT profiles ON;
INSERT INTO profiles (id, name, status, created_at) VALUES (1, 'Administrador sistema', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (2, 'Administrador', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (3, 'Moderador', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (4, 'Usuario Avanzado', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (5, 'Usuario Estándar', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (6, 'Editor', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (7, 'Consulta', 1, GETDATE());
INSERT INTO profiles (id, name, status, created_at) VALUES (8, 'Invitado', 1, GETDATE());
SET IDENTITY_INSERT profiles OFF;
GO


-- select * from users;
SET IDENTITY_INSERT users ON;
INSERT INTO users (id, name, last_name, email, password, profile_id, created_at, status) VALUES (1, 'Abel', 'Palomino', 'abelpalomino@mail.com','admin123', 1, GETDATE(), 1);
SET IDENTITY_INSERT users OFF;
GO

-- select * from loans;

-- select * from loan_details;

SET IDENTITY_INSERT loans  ON
GO

insert into loans (id, due_date, loan_status, borrower_id, user_id) values (1, dateadd(hour, 4,getdate()), 1, 1, 1);
insert into loan_details (loan_id, book_id, is_returned) values (1, 2, 1);
insert into loan_details (loan_id, book_id, is_returned) values (1, 7, 1);
insert into loan_details (loan_id, book_id, is_returned) values (1, 5, 1);


insert into loans (id, due_date, loan_status, borrower_id, user_id) values (2, dateadd(hour, 4,getdate()), 1, 4, 1);
insert into loan_details (loan_id, book_id, is_returned) values (2, 11, 1);
insert into loan_details (loan_id, book_id, is_returned) values (2, 33, 1);
insert into loan_details (loan_id, book_id, is_returned) values (2, 51, 1);
insert into loan_details (loan_id, book_id, is_returned) values (2, 16, 1);
insert into loan_details (loan_id, book_id, is_returned) values (2, 19, 1);

insert into loans (id, borrower_id, user_id) values (3, 8, 1);
insert into loan_details (loan_id, book_id) values (3, 2);
insert into loan_details (loan_id, book_id) values (3, 51);

insert into loans (id, borrower_id, user_id) values (4, 6, 1);
insert into loan_details (loan_id, book_id) values (4, 7);
insert into loan_details (loan_id, book_id) values (4, 16);
insert into loan_details (loan_id, book_id) values (4, 5);
insert into loan_details (loan_id, book_id) values (4, 33);

SET IDENTITY_INSERT loans  OFF
GO

