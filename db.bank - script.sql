/*
	Skrypt generujący bazę danych BANK_v4_test
		zmiana w stosunku do v3 (dodana data urodzenia do pracowników i klientów)
	Format daty w skrypcie: YYYY-MM-DD
	!!! UWAGA !!! to testowa baza z dodanym stanowiskiem "tester" i pracownikiem
			"Malwiriusza Testowniczek" w celu pokazania wartości NULL
*/

CREATE DATABASE BANK
GO
USE BANK
GO
CREATE TABLE Miasta
	(
		 ID_miasto INT CONSTRAINT PK_miasto PRIMARY KEY
		,kod NVARCHAR(6)
		,nazwa NVARCHAR(30)
	);	
CREATE TABLE Oddzialy
	(
		 ID_oddzialu INT CONSTRAINT PK_oddzial PRIMARY KEY
		,nazwa NVARCHAR(30)
		,adres NVARCHAR(50)
		,ID_miasta INT CONSTRAINT FK_ID_miasto REFERENCES Miasta(ID_miasto)
	);
CREATE TABLE Dzialy
	(
		 ID_dzialu INT CONSTRAINT PK_dzial PRIMARY KEY
		,nazwa NVARCHAR(30)
		,adres NVARCHAR(50) 
	);

CREATE TABLE Stanowiska
    (
		 ID_stanowiska INT CONSTRAINT PK_stanowisko PRIMARY KEY
		,nazwa NVARCHAR(25)
		,placaOd NUMERIC (7,2)
		,placaDo NUMERIC (7,2)
	);

CREATE TABLE Pracownicy
    (
		 ID_pracownika INT CONSTRAINT PK_pracownik PRIMARY KEY
		,ID_oddzialu INT CONSTRAINT FK_ID_oddzial REFERENCES Oddzialy(ID_oddzialu)
		,imie NVARCHAR(20)
		,nazwisko NVARCHAR(25)
		,telefon INT
		,mail NVARCHAR(50)
		,ID_dzialu INT CONSTRAINT FK_ID_dzial REFERENCES Dzialy(ID_dzialu)
		,ID_stanowiska INT CONSTRAINT FK_stanowisko REFERENCES Stanowiska(ID_stanowiska)
		,ID_przelozonego INT CONSTRAINT FK_ID_przelozony REFERENCES Pracownicy(ID_pracownika)
		,dataUrodzenia DATE
		,dataZatrudnienia DATE
		,dataKoniecZatrudnienia DATE
		,pensja NUMERIC (7,2)
		,dodatki NUMERIC (7,2)
	);
CREATE TABLE Klienci
    (
		 ID_klienta INT CONSTRAINT PK_klient PRIMARY KEY
		,ID_oddzialu INT CONSTRAINT FK_ID_oddzial_Klienci REFERENCES Oddzialy(ID_oddzialu)
		,ID_pracownika INT CONSTRAINT FK_ID_pracownik_Klienci REFERENCES Pracownicy(ID_pracownika)
		,imie NVARCHAR(20)
		,nazwisko NVARCHAR(25)
		,telefon INT
		,mail NVARCHAR(50)
		,dataUrodzenia DATE
		,dataZalozeniaKonta DATE
		,dataZamknieciaKonta DATE
	);
CREATE TABLE TypOperacji
    (
		 ID_typuOperacji INT CONSTRAINT PK_typOperacji PRIMARY KEY
		,nazwa NVARCHAR(50)
		,typ NVARCHAR(20)
	);		
CREATE TABLE Operacje
    (
		 ID_operacji INT CONSTRAINT PK_operacja PRIMARY KEY
		,dataOperacji DATETIME
		,ID_klienta INT CONSTRAINT FK_ID_klient REFERENCES Klienci(ID_klienta)
		,ID_typOperacji INT CONSTRAINT FK_ID_typOperacji REFERENCES TypOperacji(ID_typuOperacji)
		,kwotaOperacji INT
		,saldoPoOperacji INT
	);		
		
-- Miasta
INSERT INTO Miasta VALUES (10,'30-698','Kraków');
INSERT INTO Miasta VALUES (20,'63-820','Łódź');

-- Działy  
INSERT INTO Dzialy VALUES (10,'Zarządzanie','Zawodzie 12');
INSERT INTO Dzialy VALUES (20,'Księgowość','Kalwaryjska 25');
INSERT INTO Dzialy VALUES (30,'Finanse','Konopnickiej 30');
INSERT INTO Dzialy VALUES (40,'Obsługa klientów','Słoneczna 15');
INSERT INTO Dzialy VALUES (50,'Obsługa klientów biznesowych','Focha 20');
INSERT INTO Dzialy VALUES (60,'Logistyka','Nowa 33');
INSERT INTO Dzialy VALUES (70,'Informatyka','Legionów Polskich 14');

INSERT INTO Dzialy VALUES (80,'Zarządzanie','Lublińska 15');
INSERT INTO Dzialy VALUES (90,'Księgowość','Nowowiejska 11');
INSERT INTO Dzialy VALUES (100,'Kadry','Poniatowskiego 3');


-- Stanowiska
INSERT INTO Stanowiska VALUES (10,'prezes',10000.00,15000.00);
INSERT INTO Stanowiska VALUES (20,'wiceprezes',8000.00,10000.00);
INSERT INTO Stanowiska VALUES (30,'menedżer',7000.00,8000.00);
INSERT INTO Stanowiska VALUES (40,'lider',6000.00,7000.00);
INSERT INTO Stanowiska VALUES (50,'asystent',5000.00,6000.00);
INSERT INTO Stanowiska VALUES (60,'referent',4000.00,5000.00);
INSERT INTO Stanowiska VALUES (70,'praktykant',3000.00,4000.00);
INSERT INTO Stanowiska VALUES (80,'główny księgowy',7500.00,9000.00);
INSERT INTO Stanowiska VALUES (90,'tester',3500.00,4500.00);


-- Oddziały
INSERT INTO Oddzialy VALUES (10,'I Oddział X Banku','Ul. Czarno-biała 10', 10);
INSERT INTO Oddzialy VALUES (20,'II Oddział X Banku','Ul. Kolorowa 20', 20);



-- Typy operacji
INSERT INTO TypOperacji VALUES (10,'Wpłata własna','Wpłata/Uznanie');
INSERT INTO TypOperacji VALUES (20,'Wypłata z bankomatu','Wypłata/Obciążenie');
INSERT INTO TypOperacji VALUES (30,'Wypłata w kasie','Wypłata/Obciążenie');
INSERT INTO TypOperacji VALUES (40,'Przelew zewnętrzny','Wpłata/Uznanie');
INSERT INTO TypOperacji VALUES (50,'Przelew zwykły','Wypłata/Obciążenie');
INSERT INTO TypOperacji VALUES (60,'Płatność kartą','Wypłata/Obciążenie');
INSERT INTO TypOperacji VALUES (70,'Przelew rachunek oszczędzam','Wypłata/Obciążenie');

-- Pracownicy Kraków 
INSERT INTO Pracownicy
VALUES 
(10,10,'Piotr','Aktoriusz',773937,'paktoriusz@przyklad.pl',NULL ,10,NULL,'1960-01-01','1970-01-21',NULL ,11501.00,2151.50),

(20,10,'Jan','Fejsbuczak',739371,'jfejsbuczak@przyklad.pl',NULL ,20,10,'1960-02-02','1972-02-28',NULL ,9500.00,1450.44),
(30,10,'Aldona','Cisowiak',739372,'acisowiak@przyklad.pl',NULL,20,10,'1960-03-03','1973-06-14',NULL ,8600.99,1399.99),

(40,10,'Ilona','Murowanka',339371,'imurowanka@przyklad.pl',10,30,20,'1960-04-04','1974-04-01',NULL ,7800.00,1200.00),
(50,10,'Jacek','Profiliusz',633937,'jprofiliusz@przyklad.pl',20,30,20,'1960-05-05','1974-04-15',NULL ,7950.50,1250.00),
(60,10,'Lucjusz','Malfojczak',363393,'lmalfojczak@przyklad.pl',30,30,20,'1960-06-06','1972-05-15',NULL ,7950.50,1250.00),
(70,10,'Lidia','Jazowiak',339374,'ljazowiak@przyklad.pl',40,30,30,'1960-07-07','1982-07-25',NULL ,7750.50,1150.00),
(80,10,'Zuza','Oneciak',375636,'zoneciak@przyklad.pl',50,30,30,'1960-08-08','1977-11-20',NULL ,7890.30,1160.00),
(90,10,'Pola','Interiusz',339636,'pinteriusz@przyklad.pl',60,30,30,'1960-09-09','1980-08-17',NULL ,7550.50,1150.50),
(100,10,'Cyprian','Kiepściuch',633936,'ckiepsciuch@przyklad.pl',70,30,30,'1960-10-10','1981-10-19',NULL ,7550.50,1050.00),


(110,10,'Piotr','Komputerik',593571,'pkomputerik@przyklad.pl',10,40,40,'1960-11-11','1980-05-01',NULL ,6100.00,1000.00),
(120,10,'Maria','Elmecka',184323,'melmecka@przyklad.pl',20,40,50,'1960-12-12','1979-06-03',NULL ,6200.00,900.00),
(130,10,'Dariusz','Drzewołaz',991674,'ddrzewolaz@przyklad.pl',30,40,60,'1961-01-01','1981-07-05',NULL ,6300.00,800.00),
(140,10,'Cecylia','Kobiecka',753485,'ckobiecka@przyklad.pl',40,40,70,'1961-02-02','1976-01-07',NULL ,6400.00,700.00),
(150,10,'Leopold','Banko',842685,'lbanko@przyklad.pl',50,40,80,'1961-03-03','1974-02-09',NULL ,6500.00,600.00),
(160,10,'Zofia','Otwarty',369874,'zotwarty@przyklad.pl',60,40,90,'1961-04-04','1978-03-11',NULL ,6600.00,500.00),
(170,10,'Adam','Euforik',546546,'aeurofik@przyklad.pl',70,40,100,'1961-05-05','1983-04-01',NULL ,6700.00,400.00),
 

(210,10,'Michał','Komórczak',105101,'mkomorczak@przyklad.pl',10,50,110,'1961-06-06','1976-11-02',NULL ,5190.00,950.00),
(220,10,'Mirosława','Ekspresik',205102,'mekspresik@przyklad.pl',20,50,120,'1961-07-07','1982-01-16',NULL ,5240.00,650.00),
(230,10,'Dariusz','Googlarz',305103,'dgooglarz@przyklad.pl',30,50,130,'1961-08-08','1988-08-02',NULL ,5390.00,660.00),
(240,10,'Milena','Zgłoska',405104,'mzgloska@przyklad.pl',40,50,140,'1961-09-09','1984-03-03',NULL ,5430.00,550.00),
(250,10,'Łukasz','Więcej',505105,'lwiecej@przyklad.pl',50,50,150,'1962-01-01','1987-10-07',NULL ,5720.00,550.00),
(260,10,'Karol','Widział',605106,'kwidzial@przyklad.pl',60,50,160,'1962-02-02','1980-04-14',NULL ,5480.00,450.00),
(270,10,'Arnold','Vipowiak',705107,'avipowiak@przyklad.pl',70,50,170,'1962-03-03','1977-12-17',NULL ,5990.00,450.00),


(310,10,'Milena','Akcja',106310,'makcja@przyklad.pl',10,60,110,'1962-04-04','1980-04-14',NULL ,4250.10,450.00),
(320,10,'Makary','Zerownik',106320,'mzerownik@przyklad.pl',10,60,110,'1962-05-05','1972-11-26',NULL ,4260.20,450.00),
(330,10,'Eugeniusz','Reniczak',106330,'ereniczak@przyklad.pl',10,60,110,'1962-06-06','1987-12-22',NULL ,4260.50,450.00),
(340,10,'Piotr','Masterarz',206340,'pmasterarz@przyklad.pl',20,60,120,'1962-07-07','1981-04-04',NULL ,4250.10,470.00),
(350,10,'Aniela','Slejczuk',206350,'aslejczuk@przyklad.pl',20,60,120,'1962-08-08','1981-11-17',NULL ,4300.00,470.00),
(360,10,'Eugenia','Portalik',206360,'eportalik@przyklad.pl',20,60,120,'1962-09-09','1979-11-04','2000-12-12' ,4300.00,470.00),
(370,10,'Olek','Ofisiak',306370,'oofisiak@przyklad.pl',30,60,130,'1963-01-01','1984-04-05',NULL ,4250.00,410.00),
(380,10,'Bartek','Amazonik',306380,'bamazonik@przyklad.pl',30,60,130,'1963-02-02','1985-01-10',NULL ,4250.00,410.00),
(390,10,'Grzegorz','Wyboruk',306390,'gwyboruk@przyklad.pl',30,60,130,'1963-03-03','1980-02-03',NULL ,4250.00,450.00),
(400,10,'Adam','Seoczuk',406400,'aseoczuk@przyklad.pl',40,60,140,'1963-04-04','1977-05-15',NULL ,4500.00,500.00),
(410,10,'Leokadia','Takowiak',406410,'ltakowiak@przyklad.pl',40,60,140,'1963-05-05','1978-09-09',NULL ,4300.00,470.00),
(420,10,'Sergiusz','Bezpłatny',406420,'sbezplatny@przyklad.pl',40,60,140,'1963-06-06','1976-09-08',NULL ,4351.10,400.00),
(430,10,'Emilia','Najpierwsza',506430,'enajpierwsza@przyklad.pl',50,60,150,'1963-06-06','1986-11-12',NULL ,4200.00,450.00),
(440,10,'Waldemar','Niezawodny',506440,'wniezawodny@przyklad.pl',50,60,150,'1963-07-07','1973-06-14',NULL ,4700.00,400.00),
(450,10,'Walenty','Ugięty',606450,'wugiety@przyklad.pl',60,60,160,'1963-08-08','1987-07-17',NULL ,4200.00,450.00),
(460,10,'Barbara','Niezbędna',706460,'bniezbedna@przyklad.pl',70,60,170,'1963-09-09','1980-07-18',NULL ,4480.00,460.00),

(500,10,'Lucjusz','Szukaj',207500,'lszukaj@przyklad.pl',20,70,120,'1964-01-01','1990-02-11',NULL ,3000.00,100.00),
(510,10,'Mira','Polaros',307510,'mpolaros@przyklad.pl',30,70,130,'1964-02-02','1989-10-16',NULL ,3100.00,150.00),
(520,10,'Kaja','Naturalna',407520,'knaturalna@przyklad.pl',40,70,140,'1964-03-03','1988-09-02',NULL ,3100.00,150.00),
(530,10,'Maria','Komputerik',793578857,'mkomputerik@przyklad.pl',10,70,150,'1960-11-11','1980-05-01',NULL ,6100.00,1000.00),
(540,10,'Julian','Zdziwiony',507530,'jzdziwiony@przyklad.pl',50,70,150,'1967-04-04','1987-05-21',NULL ,4300.00,200.00);


-- Pracownicy Łódź 
INSERT INTO Pracownicy
VALUES 
(550,20,'Ludwik','Fąfara',4696288,'lfafara@przyklad.pl',NULL ,10,NULL,'1964-05-05','1999-01-11',NULL ,11500.00,2150.50),

(560,20,'Rosa','Ekspres',8196451,'rekspres@przyklad.pl',NULL ,20,540,'1964-06-06','2000-03-28',NULL ,9500.00,1450.44),

(570,20,'Danuta','Ośmienisz',81618456,'dosmienisz@przyklad.pl',20 ,80,540,'1964-07-07','1994-10-14',NULL ,8500.00,1450.44),

(580,20,'Leokadia','Warczkiewicz',18465198,'lwarczkiewicz@przyklad.pl',100 ,30,550,'1964-08-08','1999-12-23',NULL ,7500.00,1250.00),
(590,NULL,'Malwiriusz','Testowniczek',846649039,'mtestowniczek@przyklad.pl',NULL ,NULL,NULL,NULL,NULL,NULL ,NULL,NULL);


-- Klienci
INSERT INTO Klienci
VALUES 
(10,10,310,'Gunar','Lukason',952683,'glukason@przyklad.pl','2000-01-01','2014-01-01',NULL),
(20,10,320,'John','Smith',2943587,'jsmith@przyklad.pl','2000-02-02','2015-02-28',NULL),
(30,10,330,'David','Jones',28945321,'david.jones@przyklad.pl','2000-03-03','2014-03-15',NULL),
(40,10,340,'Piotr','Robinsson',58931895,'paktoriusz@przyklad.pl','2001-04-04','2015-04-21',NULL),
(50,10,350,'Ryszard','White',14235461,'white_r@przyklad.pl','2001-05-05','2014-05-05',NULL),
(60,10,360,'Adam','Green',2356465,'adamgreen@przyklad.pl','2001-06-06','2015-06-22',NULL),
(70,10,370,'Karl','Bolt',976124895,'bolt1415@przyklad.pl','2002-07-07','2014-07-14',NULL),
(80,10,380,'Ellie','King',35495618,'elli_k@przyklad.pl','2002-08-08','2015-09-29',NULL),
(90,10,390,'Olivier','Young',5981988,'oyoung@przyklad.pl','2002-09-09','2014-10-04',NULL),
(100,10,400,'Petra','Davis',988185968,'davispta@przyklad.pl','2002-10-10','2015-11-16',NULL);

-- Operacje
-- Gunar Lukason
INSERT INTO Operacje
VALUES 
(1,'2014-01-01 10:12',10,10,10000,10000),
(2,'2014-03-11 14:24',10,20,200,9800),
(3,'2014-04-05 9:44',10,10,1000,10800),
(4,'2014-05-01 15:50',10,30,500,10300),
(5,'2014-06-01 8:12',10,50,350,9950),
(6,'2014-07-01 12:08',10,40,219,10169),
(7,'2014-08-01 14:37',10,20,150,10019),
(8,'2014-09-01 15:21',10,30,170,9849),
(9,'2014-10-01 9:14',10,10,140,9989),
(10,'2014-11-01 11:32',10,20,800,9189);

-- John Smith
INSERT INTO Operacje
VALUES 
(11,'2015-03-01 14:00',20,10,25000,25000),
(12,'2015-03-11 14:24',20,30,2000,23000),
(13,'2015-03-23 9:44',20,20,350,22650),
(14,'2015-05-07 12:58',20,40,2560,25210),
(15,'2015-06-17 10:21',20,50,235,24975),
(16,'2015-06-19 12:18',20,50,410,24565),
(17,'2015-07-12 12:12',20,20,150,24415),
(18,'2015-09-19 11:09',20,10,550,24965),
(19,'2015-10-10 19:14',20,20,140,24825),
(20,'2015-12-24 11:32',20,20,800,24025);

-- David Jones
INSERT INTO Operacje
VALUES 
(21,'2015-03-16 08:20',30,10,6250,6250),
(22,'2015-04-03 11:24',30,40,2530,8780),
(23,'2015-05-03 9:41',30,40,2530,11310),
(24,'2015-06-03 10:44',30,40,2530,13840),
(25,'2015-07-03 8:14',30,40,2530,16370),
(26,'2015-08-03 10:33',30,40,2530,18900),
(27,'2015-09-03 10:59',30,40,2530,21430),
(28,'2015-10-03 11:01',30,40,2530,23960),
(29,'2015-11-03 10:22',30,40,2530,26490),
(30,'2015-12-03 9:58',30,40,2530,29020);

-- Piotr Robinsson
INSERT INTO Operacje
VALUES 
(31,'2015-05-16 08:20',40,10,8760,8760),
(32,'2015-06-10 8:04',40,40,5532,14292),
(33,'2015-06-11 9:41',40,20,2500,11792),
(34,'2015-07-10 9:34',40,40,5532,17324),
(35,'2015-07-11 9:38',40,20,2500,14824),
(36,'2015-08-10 8:14',40,40,5932,20756),
(37,'2015-08-11 9:35',40,20,2500,18256),
(38,'2015-09-10 12:01',40,40,5932,24188),
(39,'2015-09-11 9:38',40,20,2500,21688),
(40,'2015-10-10 11:59',40,40,5932,27620),
(41,'2015-10-11 9:30',40,20,2500,25120),
(42,'2015-11-10 9:57',40,40,5932,31052),
(43,'2015-11-11 9:33',40,20,2500,28552),
(44,'2015-12-10 8:36',40,40,5932,34484),
(45,'2015-12-11 19:21',40,20,2500,31984);

-- Ryszard White 2014-05-05
INSERT INTO Operacje
VALUES 
(46,'2014-09-16 11:27',50,40,1860,1860),
(47,'2014-10-01 12:11',50,20,1000,860),
(48,'2014-10-15 10:11',50,20,800,60),
(49,'2014-11-01 9:17',50,40,1860,1920),
(50,'2014-11-03 11:11',50,20,500,1420),
(51,'2014-11-15 8:52',50,20,1200,220),
(52,'2014-12-01 15:01',50,40,1860,2080),
(53,'2014-12-05 20:25',50,20,700,1380),
(54,'2014-12-14 23:48',50,20,200,1180),
(55,'2015-01-01 14:31',50,40,1860,3040),
(56,'2015-01-09 15:21',50,20,600,2440),
(57,'2015-01-17 21:10',50,20,600,1840),
(58,'2015-02-01 8:31',50,40,1860,3700),
(59,'2015-03-01 11:07',50,40,1860,5560),
(60,'2015-03-17 16:04',50,20,1800,3760);

-- Karl Bolt 2014-07-14
INSERT INTO Operacje
VALUES 
(61,'2014-08-10 8:07',70,40,4200,4200),
(62,'2014-08-11 16:17',70,20,500,3700),
(63,'2014-08-11 16:47',70,60,240,3460),
(64,'2014-08-11 17:01',70,60,34,3426),
(65,'2014-08-11 19:34',70,60,64,3362),
(66,'2014-09-09 15:15',70,20,700,2662),
(67,'2014-09-09 16:21',70,60,420,2242),
(68,'2014-09-09 17:43',70,60,155,2087),
(69,'2014-09-10 8:27',70,40,4200,6287),
(70,'2014-09-10 17:05',70,20,900,5387),
(71,'2014-09-10 18:03',70,60,340,5047),
(72,'2014-09-10 18:51',70,60,430,4617);

-- Ellie King 2015-09-29
INSERT INTO Operacje
VALUES 
(73,'2016-01-09 10:10',80,40,3500,3500),
(74,'2016-01-11 16:17',80,30,3500,0),
(75,'2016-02-09 10:43',80,40,3500,3500),
(76,'2016-02-11 17:02',80,30,3500,0),
(77,'2016-03-09 10:53',80,40,3500,3500),
(78,'2016-03-11 16:56',80,30,3500,0),
(79,'2016-04-09 10:05',80,40,3500,3500),
(80,'2016-04-11 16:37',80,30,3500,0),
(81,'2016-05-09 10:43',80,40,3500,3500),
(82,'2016-05-11 16:59',80,30,3500,0),
(83,'2016-06-09 10:56',80,40,3500,3500),
(84,'2016-06-11 17:22',80,30,3500,0),
(85,'2016-07-09 9:49',80,40,3500,3500),
(86,'2016-07-11 16:16',80,30,3500,0),
(87,'2016-08-09 11:03',80,40,3500,3500),
(88,'2016-08-11 16:33',80,30,3500,0),
(89,'2016-09-09 10:27',80,40,3500,3500),
(90,'2016-09-11 17:05',80,30,3500,0),
(91,'2016-10-09 11:00',80,40,3500,3500),
(92,'2016-10-11 16:01',80,30,3500,0),
(93,'2016-11-09 10:55',80,40,3500,3500),
(94,'2016-11-11 15:59',80,30,3500,0),
(95,'2016-12-09 10:35',80,40,3500,3500),
(96,'2016-12-11 16:43',80,30,3500,0);



-- Olivier Young 14-10-04
INSERT INTO Operacje
VALUES 
(97,'2014-11-07 9:43',90,40,2950,2950),
(98,'2014-11-10 10:00',90,70,1000,1950),
(99,'2014-11-10 17:10',90,20,500,1450),
(100,'2014-11-20 17:02',90,20,500,950),
(101,'2014-11-30 16:53',90,20,500,450),
(102,'2014-12-07 9:45',90,40,2950,3400),
(103,'2014-12-10 10:00',90,70,1000,2400),
(104,'2014-12-10 17:05',90,20,500,1900),
(105,'2014-12-20 17:21',90,20,500,1400),
(106,'2014-12-30 16:59',90,20,500,900),
(107,'2015-01-07 10:02',90,40,2950,3850),
(108,'2015-01-10 10:00',90,70,1000,2850),
(109,'2015-01-10 17:15',90,20,500,2350),
(110,'2015-01-20 16:50',90,20,500,1850),
(111,'2015-01-30 16:59',90,20,500,1350),
(112,'2015-02-07 9:55',90,40,2950,4300),
(113,'2015-02-10 10:00',90,70,1000,3300),
(114,'2015-02-10 16:57',90,20,500,2800),
(115,'2015-02-20 16:59',90,20,500,2300),
(116,'2015-02-27 17:31',90,20,200,2100),
(117,'2015-02-22 17:04',90,20,500,1600),
(118,'2015-03-07 9:55',90,40,2950,4550),
(119,'2015-03-10 10:00',90,70,1000,3550),
(120,'2015-03-10 16:59',90,20,500,3050),
(121,'2015-03-20 17:14',90,20,500,2550),
(122,'2015-03-30 17:12',90,20,500,2050);

-- Petra Davis 2015-11-16
INSERT INTO Operacje
VALUES 
(123,'2015-11-27 11:27',100,40,3520,3520),
(124,'2015-11-28 18:58',100,60,1234,2286),
(125,'2015-11-30 17:34',100,60,12,2274),
(126,'2015-12-02 19:02',100,60,54,2220),
(127,'2015-12-12 16:43',100,60,145,2075),
(128,'2015-12-19 15:56',100,60,77,1998),
(129,'2015-12-25 17:47',100,60,324,1674),
(130,'2015-12-27 10:58',100,40,3520,5194),
(131,'2015-12-29 17:44',100,60,65,5129),
(132,'2015-12-31 14:21',100,60,14,5115),
(133,'2016-01-05 20:00',100,60,16,5099),
(134,'2016-01-07 18:33',100,60,10,5089),
(135,'2016-01-15 17:26',100,60,149,4940),
(136,'2016-01-26 15:53',100,60,556,4384),
(137,'2016-01-27 10:27',100,40,3520,7904),
(138,'2016-01-27 17:25',100,60,61,7843),
(139,'2016-02-07 16:53',100,60,16,7827),
(140,'2016-02-12 16:21',100,60,732,7095),
(141,'2016-02-20 19:53',100,60,273,6822),
(142,'2016-02-27 11:02',100,40,3520,10342),
(143,'2016-03-02 15:35',100,60,5,10337),
(144,'2016-03-10 16:38',100,60,74,10263),
(145,'2016-03-14 17:04',100,60,83,10180),
(146,'2016-03-24 19:11',100,60,49,10131),
(147,'2016-03-27 10:45',100,40,3520,13651),
(148,'2016-04-02 17:35',100,60,37,13614),
(149,'2016-04-10 17:33',100,60,284,13330),
(150,'2016-04-14 15:42',100,60,4,13326),
(151,'2016-04-24 18:47',100,60,9375,3951),
(152,'2016-04-14 17:28',100,60,55,3896),
(153,'2016-04-24 19:05',100,60,34,3862),
(154,'2016-04-27 10:52',100,40,3520,7382),
(155,'2016-05-04 17:45',100,60,378,7004),
(156,'2016-05-06 15:33',100,60,377,6627),
(157,'2016-05-17 15:12',100,60,25,6602),
(158,'2016-05-24 19:47',100,60,46,6556),
(159,'2016-05-25 16:38',100,60,19,6537),
(160,'2016-05-27 10:32',100,40,3520,10057),
(161,'2016-06-06 14:25',100,60,999,9058),
(162,'2016-06-11 16:33',100,60,219,8839),
(163,'2016-06-15 17:13',100,60,53,8786),
(164,'2016-06-21 17:44',100,60,89,8697),
(165,'2016-06-24 15:35',100,60,47,8650),
(166,'2016-06-27 11:00',100,40,3520,12170),
(167,'2016-07-27 10:50',100,40,3520,15690),
(168,'2016-08-06 14:25',100,60,574,15116),
(169,'2016-08-16 17:34',100,60,463,14652),
(170,'2016-08-26 16:36',100,60,252,14401),
(171,'2016-08-27 11:05',100,40,3520,17921),
(172,'2016-09-02 13:52',100,60,69,17852),
(173,'2016-09-11 18:21',100,60,94,17758),
(174,'2016-09-14 15:55',100,60,159,17955),
(175,'2016-09-18 15:37',100,60,219,17380),
(176,'2016-09-21 16:36',100,60,19,17361),
(177,'2016-09-27 10:11',100,40,3520,20881),
(178,'2016-10-27 11:29',100,40,3520,24401),
(179,'2016-11-27 10:17',100,40,3520,27921),
(180,'2016-12-27 09:44',100,40,3520,31441);


