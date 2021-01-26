-- Phillip Escandon
-- 
USE SENSOR_DB

DROP TABLE ErrorLog;
DROP TABLE Boot;
DROP TABLE SBIT;
DROP TABLE PlanLog;
DROP TABLE SensorFamily;
DROP TABLE ConfigurationFile;
DROP TABLE IntegrationTest;
DROP TABLE Subtests;
DROP TABLE Camera;

CREATE TABLE Camera
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    Customer Varchar(25) NULL
);


CREATE TABLE ErrorLog
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    FileName Varchar(50) NOT NULL,
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);



CREATE TABLE Boot
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    Time int NULL,
    FileName Varchar(50) NOT NULL,
	RMSVersion Varchar(255) NULL,
	SCUVersion Varchar(255) NULL,
	GEDIVersion Varchar(255) NULL,
	AIBVersion Varchar(255) NULL,
	Message Varchar(255) NULL,
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);

CREATE INDEX BootTimeIdx
ON Boot(Time);

CREATE TABLE SBIT
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    Time int NULL,
    FileName Varchar(50) NOT NULL,
	Test Varchar(25) NOT NULL,
	Status bit NOT NULL,
	Message Varchar(255) NULL,
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);

CREATE INDEX SBITTimeIdx
ON SBIT(Time);

CREATE INDEX SBITStatusIdx
ON SBIT(Status);


-- HAD to change the name as 'Plan' is a keyword
CREATE TABLE PlanLog
(
	PlanID	Varchar(50),
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    Time int NULL,
    FileName Varchar(50) NOT NULL,
	Tasks Decimal(3),
	Datalink bit NOT NULL,
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);

CREATE INDEX PlanLogTimeIdx
ON PlanLog(Time);


CREATE TABLE SensorFamily
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    Is_DB110 bit NOT NULL,
	Is_MS110 bit NOT NULL,
	Is_MS177 bit NOT NULL,
	Is_TACSAR bit NOT NULL
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);





CREATE TABLE ConfigurationFile
(
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
    RollResDevicepub_offset int NULL,
	RollResConfig_offset int NULL,
	PitchRes_Devicepub_offset decimal(12,2) NULL,
	PitchResConfig_offset Decimal(12,2),
	BS_nf1bm0 Decimal(12,2),
	BS_nf1bm1 Decimal(12,2),
	BS_nf1bm2 Decimal(12,2),
	BS_df1bm0 Decimal(12,2),
	BS_df1bm1 Decimal(12,2),
	BS_df1bm2 Decimal(12,2)
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);


CREATE TABLE IntegrationTest
(
    SensorID Decimal(3) NOT NULL,
    TestID int NOT NULL PRIMARY KEY,
	SubtestID Decimal(1,1) NOT NULL,
	Completion_Percentage INT NULL ,
	DataLocation Varchar(255) NULL
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);




CREATE TABLE Subtest
(
    TestID int NULL,
	SubtestID Decimal(1,1) NOT NULL,
    SensorID Decimal(3) NOT NULL PRIMARY KEY,
	Subtest_Status bit NOT NULL
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);

CREATE INDEX Subtest_StatusIdx
ON Subtest(Subtest_status);


--DROP TABLE Subtest;