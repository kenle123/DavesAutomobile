CREATE TABLE Customer
(
    custID        varchar(20) NOT NULL,
    cFirstName    varchar(50) NOT NULL,
    cLastName     varchar(60) NOT NULL,
    cDOB          varchar(15) NOT NULL,
    cPhone        varchar(20),
    cEmailAddress varchar(30),
    cHasRecord    varchar(20),
    cType         varchar(20),
    CONSTRAINT custID_pk PRIMARY KEY (custID)
);

CREATE TABLE ZipLocation
(
    zipCode     varchar(20) NOT NULL,
    city        varchar(30) NOT NULL,
    state       varchar(30) NOT NULL,
    CONSTRAINT zipCode_pk PRIMARY KEY (zipCode)
);

CREATE TABLE Address
(
    zipCode     varchar(20) NOT NULL,
    custID      varchar(20) NOT NULL,
    aType       varchar(20) NOT NULL,
    aStreet     varchar(20) NOT NULL,
    aCountry    varchar(20) NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (custID, aType, aStreet, aCountry),
    CONSTRAINT zipCode_fk FOREIGN KEY (zipCode) REFERENCES ZipLocation(zipCode),
    CONSTRAINT custID_fk2  FOREIGN KEY (custID) REFERENCES Customer(custID)
);

CREATE TABLE CurrentCustomer
(
    currID      varchar(20) NOT NULL,
    dateJoined  varchar(20) NOT NULL,
    CONSTRAINT currID_pk PRIMARY KEY (currID),
    CONSTRAINT currID_fk FOREIGN KEY (currID) REFERENCES Customer(custID)
);

CREATE TABLE Prospective
(
    custID          varchar(20) NOT NULL,
    currID          varchar(20) NOT NULL,
    deadProspect    varchar(20) NOT NULL,
    CONSTRAINT custID_pk_pro PRIMARY KEY (custID),
    CONSTRAINT custID_fk_pro FOREIGN KEY (custID) REFERENCES Customer(custID),
    CONSTRAINT currID_fk_pro FOREIGN KEY (currID) REFERENCES CurrentCustomer(currID)
);

CREATE TABLE Contact
(
    custID                  varchar(20) NOT NULL,
    dateLastContactOccured  varchar(15) NOT NULL,
    CONSTRAINT custID_pk_Contact PRIMARY KEY (custID, dateLastContactOccured),
    CONSTRAINT custID_fk_Contact FOREIGN KEY (custID) REFERENCES Prospective(custID)
);

CREATE TABLE Steady
(
    steadyID      varchar(20) NOT NULL,
    loyaltyPoint  varchar(5) NOT NULL,
    CONSTRAINT steadyID_pk_Steady PRIMARY KEY (steadyID),
    CONSTRAINT steadyID_fk_Steady FOREIGN KEY (steadyID) REFERENCES CurrentCustomer(currID)
);

CREATE TABLE Premier
(
    premierID               varchar(20) NOT NULl,
    monthlyInstallment      varchar(20) NOT NULL,
    CONSTRAINT premierID_pk_Premier PRIMARY KEY (premierID),
    CONSTRAINT premierID_fk_Premier FOREIGN KEY (premierID) REFERENCES CurrentCustomer(currID)
);

CREATE TABLE MaintenancePackage
(
    mpID        varchar(20) NOT NULL,
    pMileage    varchar(10) NOT NULL,
    pMake       varchar(15) NOT NULL,
    pModel      varchar(25) NOT NULL,
    pCost       varchar(10) NOT NULL,
    CONSTRAINT mpID_pk PRIMARY KEY (mpID)
);

CREATE TABLE Vehicle
(
    currID                  varchar(20) NOT NULL,
    VIN                     varchar(20) NOT NULL,
    estimateMilesPerYear    varchar(10) NOT NULL,
    mileage                 varchar(10) NOT NULL,
    make                    varchar(30) NOT NULL,
    model                   varchar(20) NOT NULL,
    vYear                   varchar(20) NOT NULL,
    dateLastRepaired        varchar(15),
    dateNextService         varchar(15),
    IsRegistered            varchar(3) NOT NULL,
    mpID                    varchar(20) NOT NULL,
    CONSTRAINT vehicle_pk PRIMARY KEY (VIN, currID),
    CONSTRAINT vehicle_fk1 FOREIGN KEY (currID) REFERENCES CurrentCustomer(currID),
    CONSTRAINT vehicle_fk2 FOREIGN KEY (mpID) REFERENCES MaintenancePackage(mpID)
);

CREATE TABLE Email
(
    VIN         varchar(20) NOT NULL,
    steadyID    varchar(20) NOT NULL,
    subject     varchar(50) NOT NULL,
    dateSent    varchar(15) NOT NULL,
    CONSTRAINT email_pk PRIMARY KEY (VIN, steadyID, dateSent),
    CONSTRAINT currID_fk_Email FOREIGN KEY (steadyID) REFERENCES Steady (steadyID),
    CONSTRAINT VIN_fk_Email FOREIGN KEY (VIN) REFERENCES Vehicle (VIN)
);

CREATE TABLE Employee
(
    empID       varchar(20) NOT NULL,
    eFirstName  varchar(20) NOT NULL,
    eLastName   varchar(20) NOT NULL,
    eDOB        varchar(15) NOT NULL,
    eType       varchar(20) NOT NULL,
    ePhone      varchar(20) NOT NULL,
    eEmail      varchar(30),
    CONSTRAINT empID_pk PRIMARY KEY (empID)
);

CREATE TABLE ServiceTech
(
    sTechID   varchar(20) NOT NULL,
    CONSTRAINT empID_fk_SerivceTech FOREIGN KEY (sTechID) REFERENCES Employee (empID),
    CONSTRAINT empID_pk_ServiceTech PRIMARY KEY (sTechID)
);

CREATE TABLE Mechanic
(
    mechID varchar (20) NOT NULL,
    CONSTRAINT empID_fk_Mechanic FOREIGN KEY (mechID) REFERENCES Employee (empID),
    CONSTRAINT empID_pk_Mechanic PRIMARY KEY (mechID)
);

CREATE TABLE MaintenanceVisitOrder
(
    sTechID         varchar(20) NOT NULL,
    VIN             varchar(20) NOT NULL,
    dateOfService   varchar(15) NOT NULL,
    orderID         varchar(20) NOT NULL,
    total           varchar(20) NOT NULL,
    currID          varchar(20) NOT NULL,
    CONSTRAINT orderID_pk_MaintenanceVisitOrder PRIMARY KEY (orderID),
    CONSTRAINT empID_fk_MaintenanceVisitOrder FOREIGN KEY (sTechID) REFERENCES ServiceTech (sTechID),
    CONSTRAINT VIN_fk_MaintenanceVisitOrder FOREIGN KEY (VIN) REFERENCES Vehicle (VIN),
    CONSTRAINT currID_fk_MaintenanceVisitOrder FOREIGN KEY (currID) REFERENCES Vehicle (currID)
);

CREATE TABLE Skill
(
    sName           varchar(30) NOT NULL,
    sDescription    varchar(100),
    CONSTRAINT sName_pk PRIMARY KEY (sName)
);

CREATE TABLE MaintenanceItem
(
    sName               varchar(30) NOT NULL,
    mpID                varchar(20),
    iName               varchar(30),
    iDescription        varchar(50),
    iPrice              varchar(10),
    maintenanceItemID   varchar(20) NOT NULL,
    CONSTRAINT MaintenanceItemID_pk PRIMARY KEY (maintenanceItemID),
    CONSTRAINT sName_fk_MaintenanceItem FOREIGN KEY (sName) REFERENCES Skill (sName),
    CONSTRAINT mpID_fk_MaintenanceItem FOREIGN KEY (mpID) REFERENCES MaintenancePackage (mpID)
);

CREATE TABLE Mentorship
(
    MenteeID    varchar(20) NOT NULL,
    mechID      varchar(20) NOT NULL,
    startDate   varchar(15) NOT NULL,
    endDate     varchar(15),
    sName       varchar(30) NOT NULL,
    CONSTRAINt MentorShip_pk PRIMARY KEY (MenteeID, mechID,startDate),
    CONSTRAINT MenteeID_FK_Mentor FOREIGN KEY (MenteeID) REFERENCES Mechanic (mechID),
    CONSTRAINT empID_FK_MentorShip FOREIGN KEY (mechID) REFERENCES Mechanic (mechID),
    CONSTRAINT sName_FK_MentorShip FOREIGN KEY (sName) REFERENCES Skill(sName)
);

CREATE TABLE Mechanic_Skill
(
    mechID  varchar(20) NOT NULL,
    sName   varchar(30) NOT NULL,
    level   varchar(1) NOT NULL,
    CONSTRAINT MechanicSkill_pk PRIMARY KEY (mechID,sName),
    CONSTRAINT empID_fk_Mechanic_Skill FOREIGN KEY (mechID) REFERENCES Mechanic (mechID),
    CONSTRAINT sName_fk_Mechanic_Skill FOREIGN KEY (sName) REFERENCES Skill (sName)
);

CREATE TABLE MaintenanceVisitOrder_MaintenanceItem
(
    orderID             varchar(20) NOT NULL,
    maintenanceItemID   varchar(20) NOT NULL,
    mechID              varchar(20) NOT NULL,
    sName               varchar(30) NOT NULL,
    CONSTRAINT MaintenanceVisitOrder_MainteanceItem_PK PRIMARY KEY (orderID, maintenanceItemID),
    CONSTRAINT orderID_fk_MVM FOREIGN KEY (orderID) REFERENCES MaintenanceVisitOrder(orderID),
    CONSTRAINT empID_fk_MVM FOREIGN KEY (mechID) REFERENCES Mechanic(mechID),
    CONSTRAINT sName_fk_MVM FOREIGN KEY (sName)  REFERENCES Skill(sName),
    CONSTRAINT MaintenanceItemID_fk_MVM FOREIGN KEY (maintenanceItemID) 
    REFERENCES MaintenanceItem (maintenanceItemID)      
);

--Customer Values
INSERT INTO Customer(custID,cFirstName, cLastName, cDOB, cPhone, cEmailAddress, cHasRecord, cType) values
('00001', 'Eric', 'Aguirre' ,'1982-08-09', '562-310-3498', 'reachMe@yahoo.com', 'No', 'Individual'),
('00002', 'Bugs', 'Bunny', '1940-07-27', '456-890-6666', 'sillyRabbit@Warner.com', 'Yes', 'Individual'),
('00003', 'Inspector', 'Gadget', '1982-12-04', '789-444-4444', 'Inspect@Gadet.com', 'No', 'Individual'),
('00004', 'Bruce', 'Wayne', '1939-02-08', '256-808-2345', 'BatMan@Bats.Wayne', 'No', 'Individual'),
('00005', 'Rodger', 'Goodell', '1959-02-19', '678-345-7980', 'RodgerNFL@NFL.com', 'Yes', 'Corporation'),
('00006', 'Steve', 'Jobs', '1955-02-24', '888-888-8888', 'Jobs@Corperation.Apple', 'No', 'Corporation'),
('00007', 'Mike', 'Trout', '1991-08-07', '345-567-1111', 'BigFish@Me.com', 'Yes', 'Individual'),
('00008', 'Luke', 'Skywalker', '1951-09-25', '222-678-2222', 'Light@Force.com', 'Yes', 'Individual'),
('00009', 'Luke', 'Bryan', '1976-07-17', '245-828-3532', 'Counrty@Music.com','Yes', 'Corporation'),
('00010', 'Tony', 'Stark', '1963-03-22', '123-345-6789', 'Tony@Stark.StarkIndust', 'No', 'Corporation'),
('00011', 'Harrison', 'Ford', '1942-07-13','456-123-6789', 'Harrison@Ford.com','Yes', 'Individual'),
('00012', 'Kobe', 'Bryant', '1978-08-23','332-112-2244', 'TheReal@Kobe.com', 'No', 'Individual'),
('00013', 'Blake','Shelton','1976-06-18','000-120-3409','TheBlake@Shell.com', 'No', 'Individual'),
('00014', 'Steve', 'Rodgers', '1918-07-04','666-441-9922', 'TheSteve@Rodger.America', 'No', 'Individual'),
('00015', 'Enrique', 'Iglesias', '1975-05-08','667-442-9222', 'Iglesisas@Enrique.com', 'No', 'Individual'),
('00016', 'Micky', 'Mouse', '1928-11-18', '776-244-2299', 'Micky@Mouse.Disney', 'Yes', 'Corporation'),
('00017', 'Bill', 'Gates', '1955-10-28', '111-349-7812', 'Bill@Gates.Windows', 'No', 'Corporation'),
('00018', 'Corry', 'Perry', '1985-05-16','881-633-4554', 'Corry@me.com', 'No', 'Individual'),
('00019', 'Taylor', 'Swift','1989-12-13', '812-777-1111', 'Taylor@Swift.com', 'Yes', 'Individual'),
('00020', 'Ronald', 'McDonald', '2000-03-28', '555-676-3399', 'Ron@McDonald.Corp', 'Yes', 'Corporation'),
('00021', 'Luis', 'Fonsi', '1978-04-15','444-001-0234', 'Fonsi@gmail.com', 'No', 'Individual'),
('00022', 'Ken', 'Le', '1969-04-20','123-456-7890', 'SugoiDesuNe@gmail.com', 'Yes', 'Individual');

--ZipLocation Values
INSERT INTO ZipLocation(zipCode, City, State) values
('90808', 'Long Beach', 'California'),
('85001','Phoenix' , 'Arizona'),
('85388', 'Suprise', 'Arizona'),
('92801', 'Anaheim', 'California'),
('11561', 'Long Beach', 'New York'),
('89109', 'Las Vegas', 'Nevada'),
('48127' , 'Detroit' , 'Michigan'),
('73301', 'Austin', 'Texas'),
('98101', 'Seattle', 'Washington'),
('87501', 'Santa Fe','New Mexico');

--Address Values
INSERT INTO Address(zipCode, custID, aType, aStreet, aCountry) values
('90808', '00001', 'Mailing Address','1234 Random Lane', 'USA'),
('85001', '00002', 'Mailing Address', '3333 Ee what up doc?', 'USA'),
('11561', '00003', 'Mailing Address', '2222 Penny', 'USA'),
('73301', '00004', 'Mailing Address', ' 8888 Gotham Way', 'USA'),
('89109', '00005', 'Mailing Address', '1234 Win Big', 'USA'),
('89109', '00005', 'Billing Address', '1267 Lost It', 'USA'),
('89109', '00005', 'Vehicle Pick Up', '2222 Lucky', 'USA'),
('89109', '00005', 'Vehicle Delivery','2268 Unlucky', 'USA'),
('92801', '00006', 'Mailing Address', '8811 Apple', 'USA'),
('92801', '00006', 'Vehicle Pick Up','8821 Iphone','USA'),
('92801', '00006', 'Billing Address', '8822 Ipod', 'USA'),
('92801', '00006', 'Vehicle Delivery', '8832 Air', 'USA'),
('90808', '00007', 'Mailing Address', '3344 UpStream', 'USA'),
('98101', '00008', 'Mailing Address', '6783 Tatooine', 'USA'),
('87501', '00009', 'Billing Address', '3256 Nash','USA'),
('87501', '00009', 'Mailing Address', '3357 My Kinda Night','USA'),
('85001', '00009', 'Vehicle Delivery', '3201 Suns','USA'),
('85001', '00009', 'Vehicle Pick Up', '3102 Devils','USA'),
('85388', '00010', 'Billing Address', '5555 Iron', 'USA'),
('85388', '00010', 'Vehicle Pick Up', '5522 War Machine', 'USA'),
('48127', '00010', 'Vehicle Delivery', '5321 Tigers', 'USA'),
('48127', '00010', 'Mailing Address', '5321 Tigers', 'USA'),
('87501', '00011', 'Mailing Address','2254 Falcon', 'USA'),
('73301', '00012', 'Mailing Address', '2337 Laker Way', 'USA'),
('98101', '00013', 'Mailing Address','2438 Hony Bee','USA'),
('98101', '00014', 'Mailing Address','2438 Ranom Lane','USA'),
('48127', '00015', 'Mailing Address', '2539 Balindo', 'USA'),
('90808', '00016', 'Billing Address', '2679 Pluto','USA'),
('90808', '00016', 'Mailing Address', '2679 Walt','USA'),
('90808', '00016', 'Vehicle Delivery', '2679 Steamboat','USA'),
('90808', '00016', 'Vehicle Pick Up', '2670 Minnie','USA'),
('11561', '00017', 'Vehicle Delivery','2671 Window','USA'),
('11561', '00017', 'Billing Address','7126 XBOX','USA'),
('11561', '00017', 'Vehicle Pick Up','2671 Window','USA'),
('11561', '00017', 'Mailing Address','7127 XBOX','USA'),
('48127', '00018', 'Mailing Address','7237 Ducks Way','USA'),
('11561', '00019', 'Mailing Address', '0000 Mean','USA'),
('90808', '00020', 'Vehicle Pick Up','0012 Lees','USA'),
('90808', '00020', 'Billing Address','0013 Lees','USA'),
('90808', '00020', 'Mailing Address','1111 Wees','USA'),
('90808', '00020', 'Vehicle Delivery','3344 Keys','USA'),
('11561', '00021', 'Mailing Address','3345 Despacito','USA');

--CurrentCustomer Values
INSERT INTO CurrentCustomer(currID, dateJoined) values
('00001', '2000-09-12'),
('00002', '2017-02-22'),
('00003', '2012-02-02'),
('00005', '2017-11-02'),
('00007', '2000-09-12'),
('00009', '2017-03-29'),
('00010', '1999-09-09'),
('00011', '2017-01-16'),
('00013', '2017-07-07'),
('00015', '2017-04-26'),
('00016', '1966-08-11'),
('00018', '2017-10-31'),
('00021', '2017-06-03'),
('00022', '2000-01-01');

--Prospective Values
INSERT INTO Prospective(custID, currID, deadProspect) values
('00004','00007', 'False'),
('00006','00022', 'False'),
('00008','00002', 'True'),
('00012','00011', 'True'),
('00014','00005', 'False'),
('00017','00003', 'True'),
('00019','00016', 'True'),
('00020','00013', 'True');

--Contact Values
INSERT INTO Contact(custID, dateLastContactOccured) values
('00004','2002-02-12'),
('00006','2010-01-14'),
('00008','1997-06-12'),
('00012','1999-11-21'),
('00014','1978-08-02'),
('00017','2016-11-18'),
('00019','1971-12-04'),
('00020','2017-01-09');

--Steady Values
INSERT INTO Steady(steadyID, loyaltyPoint) values
('00001', '34'),
('00003', '21'),
('00007', '09'),
('00010', '87'),
('00016', '56'),
('00018', '42'),
('00022', '12');

--Premier Values
INSERT INTO Premier(premierID, monthlyInstallment) values
('00002', '50'),
('00005', '21'),
('00009', '45'),
('00011', '98'),
('00013', '56'),
('00015', '77'),
('00021', '62');

--MaintenancePackage Values
INSERT INTO MaintenancePackage(mpID, pMileage, pMake, pModel, pCost) values
('mp001','45000','Toyota','Corolla', '1520'),
('mp002','51000', 'Toyota', 'Prius', '155'),
('mp003','42000', 'Toyota', 'Highlander', '300'),
('mp004','18000', 'Toyota', 'Corolla', '105'),
('mp005','29000', 'Toyota', 'Camry', '150'),
('mp006', '43000', 'Toyota', 'Camry', '350'),
('mp007','44400', 'Toyota', 'Yaris', '580 '),
('mp008', '29000', 'Toyota', 'Tundra', '1000');

--Vehicle Values
Insert INTO Vehicle(currID, estimateMilesPerYear, mileage, make, model, vYear, dateLastRepaired, VIN, dateNextService, isRegistered, mpID) values
('00001','5000', '45000', 'Toyota', 'Corolla', '2009', '2015-03-25', '1FMNE31S52HB35239', '2017-12-29', 'Yes', 'mp001'),
('00002','4000', '51000', 'Toyota', 'Prius', '2009', '2016-01-05', '1G6DB5EG9A0173843', '2018-01-01', 'No', 'mp002'),
('00003','6000', '42000', 'Toyota', 'Highlander', '2010', '2016-01-27','1FDWX36P14EE98855', '2018-01-15', 'Yes', 'mp003'),
('00005','9000', '90000', 'Toyota', 'Corolla', '2007', '2016-05-04', '1N4BL11E86N336383', '2018-04-12', 'Yes', 'mp005'),
('00007','7800', '43000', 'Toyota', 'Camry', '2001', '2016-06-23', '3FA6P0D96ER128156', '2018-05-15', 'Yes', 'mp007'),
('00009','7400', '58000', 'Toyota', 'Tundra', '2004', '2016-10-26','2HHFD5F78AH269633', '2018-06-21', 'Yes', 'mp002'),
('00010','1900', '29000', 'Toyota', 'Tundra', '2010', '2016-11-01', '1B4GP25R72B896525', '2018-08-08', 'No', 'mp003'),
('00011','2300', '26000', 'Toyota', 'Corolla', '2011', '2016-11-02', '1MECM53U0LA660758', '2018-08-16', 'Yes', 'mp007'),
('00013','4000', '50000', 'Toyota', 'Mirai', '2007', '2017-02-01', '1FMYU02B02KA26770', '2018-08-31', 'Yes', 'mp008'),
('00015','1800', '60000', 'Toyota', 'Sienna', '1999', '2017-03-03','1GDHC33K8RJ779563', '2018-09-11', 'Yes', 'mp001'),
('00016','2700', '69000', 'Toyota', 'Sienna', '1997', '2017-03-20','WDBUF72X97B136692', '2018-09-27', 'No', 'mp002'),
('00018','5200', '83000', 'Toyota', 'Prius Prime', '1996', '2017-06-08','1GBDC14K3PZ124865', '2018-11-07', 'Yes', 'mp007'),
('00021','2100', '60000', 'Toyota', 'Sequoia', '1993', '2017-09-11', '1GNSKBE0XDR351823', '2018-12-31', 'Yes', 'mp004'),
('00022','3100', '39000', 'Toyota', 'Sequoia', '1992', '2017-11-11', '1B3BG26P2GX636796', '2019-01-02', 'Yes', 'mp002');

--Email Values
INSERT INTO Email(VIN, steadyID, dateSent, subject) values
('1FMNE31S52HB35239','00001','2015-02-13','Oil Change'),
('1FDWX36P14EE98855','00003','2015-12-31','Filter Change'),
('3FA6P0D96ER128156','00007','2016-06-21','Rotation of Tires'),
('1B4GP25R72B896525','00010','2016-10-23','Transmission Oil'),
('WDBUF72X97B136692','00016','2017-02-12','Air cleaner change'),
('1GBDC14K3PZ124865','00018','2017-05-23','Transmission Fluid'),
('1B3BG26P2GX636796','00022','2017-11-05','AC Condenser');

--Employee Values
INSERT INTO Employee(empID, eFirstName, eLastName,eDOB, eType, ePhone, eEmail) values
('emp01', 'Katy', 'Perry', '1984-10-25','Mechanic','211-002-3331', 'Katy@Dave.Corp'),
('emp02', 'David', 'Beckham','1975-05-02', 'Mechanic', '212-002-3331', 'Beckham@Dave.Corp'),
('emp03', 'Gordon', 'Ramsay', '1966-11-08','Mechanic','213-003-3332', 'Ramsay@Dave.Corp'),
('emp04', 'Jared','Goff','1994-10-14','Mechanic','214-004-3333', 'Jared@Dave.Corp'),
('emp05','Jack','Black', '1969-08-28','Mechanic', '215-005-3334', 'Jack@Dave.Corp'),
('emp06','Faith','Hill','1967-09-21','Mechanic','216-006-3335', 'Hill@Dave.Corp'),
('emp07','Tim','McGraw','1967-05-01', 'Mechanic', '217-007-3336', 'McGraw@Dave.Corp'),
('emp08','Russell','Wilson','1988-11-29','Mechanic', '218-008-3337', 'Wilson@Dave.Corp'),
('emp09','Michael','Jordan','1963-02-17','Mechanic','219-009-3338', 'Jordan@Dave.Corp'),
('emp10','Donald','Duck','1934-05-05','Mechanic','219-010-3338', 'Duck@Dave.Corp'),
('emp11','Ash','Ketchum','1969-06-09','Mechanic','420-420-6969', 'GucciGang@Dave.Corp'),
('emp12','Minnie','Mouse','1928-11-18','Service Tech','219-020-3338', 'Minnie@Dave.Corp'),
('emp13','Barney','The Dinosaur','1992-04-08','Service Tech', '223-021-3338', 'Barney@Dave.Corp'),
('emp14','Star','Lord','1976-01-01','Service Tech','224-022-3339', 'Lord@Dave.Corp'),
('emp15','Keith','Urban','1967-10-26','Service Tech','225-023-3340', 'Keith@Dave.Corp'),
('emp16','Oprah','Winfrey','1954-01-29','Service Tech','226-024-3341', 'Winfrey@Dave.Corp'),
('emp17', 'Carrie','Underwood','1983-03-10','Service Tech','227-025-3342', 'Underwood@Dave.Corp'),
('emp18','Steve','Nash','1974-02-07','Service Tech','454-026-4233', 'Nash@Dave.Corp'),
('emp19','Albert','Einstein','1879-03-14','Service Tech','455-027-4234', 'Einstein@Dave.Corp'),
('emp20','Jon','Pardi','1985-05-20','Service Tech','456-028-4345', 'Pardi@Dave.Corp'),
('emp21','Barrack','Obama','1961-04-04','Service Tech','475-029-4446', 'Obama@Dave.Corp'),
('emp22','Taeyeon','Bae', '1989-03-09', 'Service Tech','592-583-5739','Sarangheyo@Dave.Corp');

--ServiceTech Values
INSERT INTO ServiceTech(sTechID) values
('emp01'),
('emp02'),
('emp03'),
('emp04'),
('emp06'),
('emp09'),
('emp12'),
('emp13'),
('emp16'),
('emp19'),
('emp21'),
('emp22');

--Mechanic Values
INSERT INTO Mechanic(mechID) values
('emp02'),
('emp03'),
('emp05'),
('emp07'),
('emp08'),
('emp10'),
('emp11'),
('emp14'),
('emp15'),
('emp17'),
('emp18'),
('emp20');

--MaintenanceVisitOrder Values
INSERT INTO MaintenanceVisitOrder(sTechID,VIN,dateOfService,orderID, total, currID) values
('emp01', '1FMNE31S52HB35239', '2015-04-11', 'ord01', '234', '00001'),
('emp06', '1FMNE31S52HB35239', '2015-07-11', 'ord02', '423', '00001'),
('emp09', '1FMNE31S52HB35239', '2015-09-16', 'ord03', '567', '00001'),
('emp04', '1G6DB5EG9A0173843', '2016-10-30', 'ord04', '343', '00002'),
('emp06', '1G6DB5EG9A0173843', '2016-12-31', 'ord05', '841', '00002'),
('emp09', '1FDWX36P14EE98855', '1999-06-13', 'ord06', '138', '00003'),
('emp06', '1N4BL11E86N336383', '2000-07-23', 'ord07', '643', '00005'),
('emp04', '3FA6P0D96ER128156', '2017-08-24', 'ord08', '422', '00007'),
('emp06', '3FA6P0D96ER128156', '2017-09-24', 'ord09', '498', '00007'),
('emp22', '3FA6P0D96ER128156', '2017-10-16', 'ord10', '942', '00007'),
('emp01', '2HHFD5F78AH269633', '2016-02-23', 'ord11', '647', '00009'),
('emp13', '2HHFD5F78AH269633', '2016-09-03', 'ord12', '128', '00009'),
('emp21', '2HHFD5F78AH269633', '2017-08-12', 'ord13', '376', '00009'),
('emp22', '1B4GP25R72B896525', '2004-11-16', 'ord14', '123', '00010'),
('emp16', '1MECM53U0LA660758', '2005-02-17', 'ord15', '543', '00011'),
('emp09', '1FMYU02B02KA26770', '2015-03-18', 'ord16', '262', '00013'),
('emp19', '1FMYU02B02KA26770', '2015-09-02', 'ord17', '194', '00013'),
('emp12', '1GDHC33K8RJ779563', '2007-05-23', 'ord18', '673', '00015'),
('emp19', 'WDBUF72X97B136692', '2008-08-25', 'ord19', '242', '00016'),
('emp21', '1GBDC14K3PZ124865', '2009-09-26', 'ord20', '754', '00018'),
('emp01', '1GBDC14K3PZ124865', '2016-03-12', 'ord21', '213', '00018'),
('emp13', '1GNSKBE0XDR351823', '1997-03-11', 'ord22', '88' , '00021'),
('emp13', '1B3BG26P2GX636796', '2012-12-13', 'ord23', '353', '00022');

--Skill Values
INSERT INTO Skill(sName, sDescription) values
('A/C Repair', 'Knowledge on how to repair A/C of a car'),
('Battery Installation', 'Knowledge on how to install new batteries'),
('Brake Repair', 'Knowledge of how to repair brakes'),
('Engine Repair', 'Knowledge on how to repair engines'),
('Engine Tune-Up', 'Knowledge on tuning up engines'),
('Oil Change', 'Knowledge on how to change oil'),
('Steering and Suspension Repair', 'Knowledge on how to repair suspension of cars'),
('Tire Repair', 'Knowledge on how to repair tires'),
('Tire Mounting and Rotation', 'Knowledge on how to rotate tires'),
('Transmission Service', 'Knowledge on how to service transmissions of a car'),
('Wheel Alignment', 'Knowledge on to align the wheels'),
('External Coating', 'Knowledge on car exteriors and painting them');

--MaintenanceItem Values
INSERT INTO MaintenanceItem(sName, mpID, iName, iDescription, iPrice, maintenanceItemID) values
('Engine Repair', 'mp001', 'Engine Rebuild', 'Rebuilding the engine to factory setting', '1500','323501'),
('Tire Mounting and Rotation', 'mp001', 'Tire Rotation', 'Rotating the tires every 5 months.', '20','323502'),
('Oil Change', 'mp002', 'Oil Change', 'Changing the engine oil.', '65','323503'),
('Wheel Alignment', 'mp002', 'Wheel Alignment', 'Aligning the wheels to proper fitments', '90', '323504'),
('A/C Repair', 'mp003', 'Air Filter', 'Changing the air filter under the hood.', '100','323505'),
('Brake Repair', 'mp003', 'Brake Inspection', 'Inspecting the brakes for worn.', '200','323506'),
('Steering and Suspension Repair', 'mp004', 'Power Steering', 'Inspecting the power steering control.', '75','323507'),
('Tire Repair', 'mp004', 'Tire Pressure', 'Inspecting the tire pressure of all 4 wheels.', '30','323508'),
('External Coating', NULL, 'Paint Waxing', 'Project the clear coating of the cars exterior.', '80','323509'),
('Transmission Service', 'mp005', 'Transmission Fluid', 'Refilling the transmission fluids', '150','323510'),
('Transmission Service', NULL, 'Coolant Rebuild', 'Rebuilding the coolant system of the car.', '650','323511'),
('Battery Installation', 'mp006', 'Battery Replacement', 'Replacing the battery of the car.', '350','323512'),
('A/C Repair', 'mp007', 'AC Condenser', 'Inspecting the Air Conditioner condenser', '200','323513'),
('Engine Repair', 'mp007', 'Spark Plug Replacement', 'replacing the spark plug', '380','323514'),
('Tire Repair', NULL, 'Tire Pressure', 'Inspecting the tire pressure of all 4 wheels.', '1000','323515'),
('Steering and Suspension Repair', 'mp008', 'Suspension Upgrade', 'Upgrading stock suspension springs.', '1000' ,'323516');

--Mentorship Values
INSERT INTO Mentorship(MenteeID, mechID, startDate, endDate, sName) values
('emp02','emp11', '12-15-2014', '5-18-2016', 'Engine Repair'),
('emp03','emp14', '8-08-2012', '7-20-2015', 'Transmission Service'), 
('emp05','emp15', '10-10-2016', NULL, 'Tire Repair'), 
('emp07','emp17', '11-15-2013', '6-20-2014', 'Battery Installation'),  
('emp08','emp18', '9-29-2013', '8-18-2014', 'Wheel Alignment'), 
('emp10','emp20', '4-20-2015', '4-19-2016', 'A/C Repair'),   
('emp14','emp03', '3-23-2017', NULL, 'Tire Mounting and Rotation'), 
('emp15','emp05', '5-18-2017', NULL, 'Engine Tune-Up'),  
('emp17','emp07', '1-29-2015', '2-27-2016', 'Oil Change'), 
('emp18','emp08', '3-7-2016', '7-28-2017', 'Brake Repair'),  
('emp20','emp11', '8-8-2016', '6-18-2017', 'Engine Repair');

--Mechanic_Skill Values
INSERT INTO Mechanic_Skill(mechID, sName, level) values
('emp11','Engine Repair', '5'),
('emp11','Transmission Service', '5'),
('emp14','Transmission Service', '1'),
('emp15','Tire Repair', '2'),
('emp17','Engine Repair', '2'),
('emp17','Wheel Alignment', '3'),
('emp17','Tire Repair', '5'),
('emp17','Battery Installation', '1'),
('emp18','Wheel Alignment', '4'),
('emp20','A/C Repair', '5'),
('emp03','Tire Mounting and Rotation', '3'),
('emp05','Engine Tune-Up', '4'),
('emp07','Oil Change', '1'),
('emp08','Brake Repair', '2'),
('emp11','Tire Repair', '3'),
('emp11','Wheel Alignment', '4'),
('emp20','Oil Change', '4'),
('emp20','Transmission Service', '3'),
('emp20','Tire Mounting and Rotation', '2'),
('emp20','Engine Repair', '4'),
('emp20','Tire Repair', '3'),
('emp20','Wheel Alignment', '5'),
('emp02','Engine Repair', '4'),
('emp07','Transmission Service', '2'),
('emp03','Battery Installation', '1');

--MaintenanceVisitOrder_MaintenanceItem Values
INSERT INTO MaintenanceVisitOrder_MaintenanceItem(orderID, maintenanceItemID, mechID, sName) values
('ord01', '323501', 'emp11', 'Engine Repair'),
('ord02', '323502', 'emp14', 'Tire Repair'),
('ord03', '323503', 'emp15', 'Oil Change'),
('ord04', '323504', 'emp17', 'Wheel Alignment'),
('ord05', '323505', 'emp18', 'A/C Repair'),
('ord06', '323506', 'emp20', 'Brake Repair'),
('ord07', '323507', 'emp02', 'Steering and Suspension Repair'),
('ord08', '323508', 'emp03', 'Tire Repair'),
('ord09', '323509', 'emp05', 'External Coating'),
('ord10', '323510', 'emp07', 'Transmission Service'),
('ord11', '323511', 'emp08', 'Transmission Service'),
('ord12', '323512', 'emp11', 'Battery Installation'),
('ord13', '323513', 'emp05', 'A/C Repair'),
('ord14', '323514', 'emp20', 'Engine Repair'),
('ord15', '323514', 'emp20', 'Engine Repair');

select * from Customer;
select * from ZipLocation;
select * from Address;
select * from CurrentCustomer;
select * from Prospective;
select * from Contact;
select * from Steady;
select * from Premier;
select * from MaintenancePackage;
select * from Vehicle;
select * from Email;
select * from Employee;
select * from ServiceTech;
select * from Mechanic;
select * from MaintenanceVisitOrder;
select * from Skill;
select * from MaintenanceItem;
select * from Mentorship;
select * from Mechanic_Skill;
select * from MaintenanceVisitOrder_MaintenanceItem;

drop table MaintenanceVisitOrder_MaintenanceItem;
drop table Mechanic_Skill;
drop table Mentorship;
drop table MaintenanceItem;
drop table Skill;
drop table MaintenanceVisitOrder;
drop table Mechanic;
drop table ServiceTech;
drop table Employee;
drop table Email;
drop table Vehicle;
drop table MaintenancePackage;
drop table Premier;
drop table Steady;
drop table Contact;
drop table Prospective;
drop table CurrentCustomer;
drop table Address;
drop table ZipLocation;
drop table Customer;

--View #1
CREATE OR REPLACE VIEW Customer_v AS
SELECT cLastName, cFirstName, dateJoined, YEAR(curdate()) - YEAR(dateJoined) AS yearsWith,
Premier.premierID IS NOT NULL AS isPremier,
Steady.steadyID IS NOT NULL AS isSteady,
Prospective.custID IS NOT NULL AS isProspective
FROM Customer
LEFT OUTER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
LEFT OUTER JOIN Premier ON Customer.custID = Premier.premierID
LEFT OUTER JOIN Steady ON Customer.custID = Steady.steadyID
LEFT OUTER JOIN Prospective ON Customer.custID = Prospective.custID;
select * from Customer_v;

--View #2
CREATE OR REPLACE VIEW Customer_Addresses_v AS
SELECT Customer.custID, cFirstName, cLastName, aStreet, cType
FROM Customer
NATURAL JOIN Address
GROUP BY aStreet
ORDER BY Customer.custID ASC;
select * from Customer_Addresses_v;

--View #3
CREATE OR REPLACE VIEW Mechanic_Mentor_v AS
SELECT E.mechID as Mentee, M.mechID as Mentor,
X.eFirstName as MenteeFirstName, X.eLastName as MenteeLastName,
Y.eFirstName as MentorFirstName, Y.eLastName as MentorLastName
FROM Mechanic E 
INNER JOIN  
(Mentorship MS INNER JOIN Mechanic M ON MS.mechID = M.mechID)
ON E.mechID = MS.MenteeID
INNER JOIN Employee X ON X.empID = E.mechID
INNER JOIN Employee Y ON Y.empID = M.mechID
ORDER BY X.eFirstName, Y.eFirstName ASC;
select * from Mechanic_Mentor_v;

--View #4
CREATE OR REPLACE VIEW Premier_Profits_v AS
SELECT custID, cFirstName, cLastName, YEAR(dateJoined) AS yearJoined, 
(monthlyInstallment*12) as AnnualFee, total as TotalCost,
(monthlyInstallment*12) - total AS Profit
FROM Customer
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Premier ON Customer.custID = Premier.premierID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder MVO ON Vehicle.currID = MVO.currID;
WHERE YEAR(dateJoined) = '2015' OR YEAR(dateJoined) = '2016' OR YEAR(dateJoined) = '2017';
select * from Premier_Profits_v;

--View #5
CREATE OR REPLACE VIEW Prospective_resurrection_v AS
SELECT custID, cFirstName, cLastName, dateLastContactOccured, deadProspect FROM Customer
INNER JOIN Prospective USING (custID)
INNER JOIN Contact USING (custID)
WHERE (YEAR(CURDATE()) - YEAR(dateLastContactOccured) >= 1)
AND deadProspect = 'True';
select * from Prospective_resurrection_v;

--Query #1
SELECT  Customer.custID, cFirstName, cLastName, cPhone, cEmailAddress,
count(aType) > 1 AS isCorporate, count(aType) <= 1 AS isIndividual,
Premier.premierID IS NOT NULL AS isPremier,
Steady.steadyID IS NOT NULL AS isSteady,
Prospective.custID IS NOT NULL AS isProspective
FROM Customer
LEFT OUTER JOIN Address USING (custID)
LEFT OUTER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
LEFT OUTER JOIN Premier ON Customer.custID = Premier.premierID
LEFT OUTER JOIN Steady ON Customer.custID = Steady.steadyID
LEFT OUTER JOIN Prospective ON Customer.custID = Prospective.custID
GROUP BY Customer.custID, cFirstName, cLastName, cPhone, cEmailAddress, 
Premier.premierID, Steady.steadyID, Prospective.custID;

--Query #2
SELECT cFirstName, cLastName, custID, Vehicle.VIN, total
FROM Customer 
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder ON Customer.custID = MaintenanceVisitOrder.currID;

--Query #3
SELECT custID, cFirstName, cLastName, sum(total) as NetSpending
FROM Customer
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder ON Customer.custID = MaintenanceVisitOrder.currID
WHERE DATEDIFF(CURDATE(), dateLastRepaired) < 730
GROUP BY custID
ORDER BY NetSpending DESC
LIMIT 3;

--Query #4
SELECT empID, eFirstName, eLastName, eType, COUNT(sName) AS NumSkills
FROM Employee 
INNER JOIN Mechanic ON Employee.empID = Mechanic.mechID
INNER JOIN Mechanic_Skill ON Employee.empID = Mechanic_Skill.mechID
GROUP BY empID, eFirstName, eLastName HAVING COUNT(sName) >= 3;

--Query #5 
SELECT e1.empID, e1.eFirstName, e1.eLastName, e1.eType,
e2.empID, e2.eFirstName, e2.eLastName, e2.eType, 
COUNT(e1.sName) AS SkillsInCommon
FROM 
(
SELECT empID, sName, eFirstName, eLastName, eType
FROM Employee 
INNER JOIN Mechanic ON Employee.empID = Mechanic.mechID
INNER JOIN Mechanic_Skill ON Employee.empID = Mechanic_Skill.mechID
) 
AS e1 INNER JOIN
(
SELECT empID, sName, eFirstName, eLastName, eType
FROM Employee
INNER JOIN Mechanic ON Employee.empID = Mechanic.mechID
INNER JOIN Mechanic_Skill ON Employee.empID = Mechanic_Skill.mechID
) 
AS e2 
WHERE e1.empID > e2.empID AND e1.sName = e2.sName
GROUP BY e1.empID, e2.empID
HAVING COUNT(e1.sName) >= 3;
    
--Query #6
SELECT MP.mpID AS PackageID, pCost, iName
FROM MaintenancePackage MP
NATURAL JOIN MaintenanceItem
GROUP BY iName
ORDER BY PackageID ASC;

--Query #7
select eFirstName, eLastName, Mechanic_Skill.sName,  
from Employee 
left outer join Mechanic on Employee.empID = Mechanic.mechID
left outer join Mechanic_Skill on Employee.empID = Mechanic_Skill.mechID
left outer join Skill on Mechanic_Skill.sName = Skill.sName
left outer join MaintenanceItem on Skill.sName = MaintenanceItem.sName;

--Query #8
SELECT custID, cFirstName, cLastName, loyaltyPoint as LoyaltyPoints
FROM Customer
INNER JOIN CurrentCustomer on Customer.custID = CurrentCustomer.currID
INNER JOIN Steady on Customer.custID = Steady.steadyID
ORDER BY LoyaltyPoints DESC;

--Query #9
SELECT custID, cFirstName, cLastName, (monthlyInstallment*12) - SUM(total) AS AmountPaidMinusServicesUsed
FROM Customer
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Premier ON Customer.custID = Premier.premierID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder ON Customer.custID = MaintenanceVisitOrder.currID
WHERE DATEDIFF(CURDATE(), dateOfService) < 365
GROUP BY custID, cFirstName, cLastName
ORDER BY AmountPaidMinusServicesUsed DESC;

--Query #10
SELECT custID, cFirstName, cLastName, sum(total) as NetProfit
FROM Customer
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Steady ON Customer.custID = Steady.steadyID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder ON Customer.custID = MaintenanceVisitOrder.currID
WHERE DATEDIFF(CURDATE(), dateLastRepaired) < 365
GROUP BY custID, cFirstName, cLastName
ORDER BY NetProfit DESC;

--Query #11
SELECT custID, cFirstName, cLastName, sum(total) as NetProfit
FROM Customer
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Premier ON Customer.custID = Premier.premierID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
INNER JOIN MaintenanceVisitOrder ON Customer.custID = MaintenanceVisitOrder.currID
WHERE DATEDIFF(CURDATE(), dateLastRepaired) < 365
GROUP BY custID, cFirstName, cLastName
ORDER BY NetProfit DESC
LIMIT 3;

--Query #12
SELECT make, model, YEAR(dateOfService) AS YEAR, 
COUNT(*) AS AverageNumberOfMaintenanceVisits
FROM Vehicle
INNER JOIN MaintenanceVisitOrder MVO ON Vehicle.currID = MVO.currID
WHERE DATEDIFF(CURDATE(), dateOfService) < 1095
GROUP BY Vehicle.VIN
ORDER BY AverageNumberOfMaintenanceVisits DESC
LIMIT 5;

--Query #13 
SELECT E.mechID as Mentee, M.mechID as Mentor,
X.eFirstName as MenteeFirstName, X.eLastName as MenteeLastName,
Y.eFirstName as MentorFirstName, Y.eLastName as MentorLastName,
sName as SkillName
FROM Mechanic E 
INNER JOIN  
(Mentorship MS INNER JOIN Mechanic M ON MS.mechID = M.mechID)
ON E.mechID = MS.MenteeID
INNER JOIN Employee X ON X.empID = E.mechID
INNER JOIN Employee Y ON Y.empID = M.mechID
WHERE count(M.mechID) > 1;

--Query #14
SELECT COUNT(mechID) AS NumEmployeesWithSkill, sName 
FROM Mechanic_Skill 
GROUP BY sName
ORDER BY NumEmployeesWithSkill ASC
LIMIT 3;

--Query #15
SELECT eFirstName, eLastName, empID 
FROM Employee 
INNER JOIN Mechanic ON Employee.empID = Mechanic.mechID 
NATURAL JOIN ServiceTech
WHERE mechID = sTechID;

--Query #16
SELECT mpID, pMileage, pMake, pModel 
FROM MaintenancePackage;

--Query #17
SELECT maintenanceItemID, iName, mpID
FROM MaintenanceItem 
WHERE mpID IS NULL;

--View #18A
CREATE OR REPLACE VIEW Vehicle_Reg_v AS
SELECT custID, cFirstName, cLastName, VIN, mileage, make, model, isRegistered
FROM Customer 
INNER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
INNER JOIN Vehicle ON Customer.custID = Vehicle.currID
WHERE isRegistered = 'No'
ORDER BY custID ASC; 
select * from Vehicle_Reg_v;

--View #18B
CREATE OR REPLACE VIEW Customer_hasRecord_v AS
SELECT custID, cFirstName, cLastName, cHasRecord 
FROM Customer
Where cHasRecord = 'Yes'
ORDER BY custID ASC;
select * from Customer_hasRecord_v;

--View #18C
CREATE OR REPLACE VIEW Customer_List_v AS
SELECT cLastName, cFirstName, make, model, mileage,
Premier.premierID IS NOT NULL AS isPremier,
Steady.steadyID IS NOT NULL AS isSteady,
Prospective.custID IS NOT NULL AS isProspective
FROM Customer
LEFT OUTER JOIN CurrentCustomer ON Customer.custID = CurrentCustomer.currID
LEFT OUTER JOIN Vehicle ON CurrentCustomer.currID = Vehicle.currID
LEFT OUTER JOIN Premier ON Customer.custID = Premier.premierID
LEFT OUTER JOIN Steady ON Customer.custID = Steady.steadyID
LEFT OUTER JOIN Prospective ON Customer.custID = Prospective.custID;
select * from Customer_List_v;

