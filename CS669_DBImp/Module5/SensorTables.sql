-- Phillip Escandon
--Escandon@bu.com

-- TABLES for Sensor_DB

--CREATE SENSOR_DB

-- TABLES
-- Production Tables
--1.  Camera
--2.  SensorFamily
--3. IntegrationTest
--4. CameraIntegrationStatus
--5. IntegrationTestSuite
--6. IntegrationUpdate
--7. Configuration 
--8. ConfigurationUpdate

--Sustainment Tables
--9. ErrorLog
--10. SBIT
--11. PLAN





DROP TABLE ErrorLog;
DROP TABLE BootLog;
DROP TABLE SBITLog;
DROP TABLE PlanLog;
DROP TABLE SensorFamily;

DROP TABLE ConfigurationFile;
DROP TABLE ConfigurationFileUpdate;

DROP TABLE IntegrationTest;
drop table CameraIntegrationStatus;
drop table IntegrationStatusUpdate;

DROP TABLE Camera;



use SENSOR_DB





-- Camera Table
-- LucidChart
-- Project ERD


CREATE TABLE Camera
(
    SensorID int NOT NULL PRIMARY KEY,
    Customer Varchar(25) NULL
);

select * from Camera

-- SensorFamily Table
-- LucidChart
-- Project ERD
CREATE TABLE SensorFamily
(
    SensorID int NOT NULL PRIMARY KEY,
    Is_DB110 bit default 0,
	Is_MS110 bit default 0,
	Is_MS177 bit default 0,
	Is_TACSAR bit default 0
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);
select * from SensorFamily




-- IntegrationTest Table
-- LucidChart
-- Project ERD
CREATE TABLE IntegrationTest
(
    TestID decimal(3,1) not null PRIMARY KEY,
	TestName Varchar(30) not null,
	DataLocation Varchar(255) null
);

select * from IntegrationTest

-- This is the joining table for Camera and Integration Tests
-- Expect Camera 50,51,52 to have Integration test 1,2,3,4...etc. which is many to many.  Need to 
-- correct this in my normalization.


-- CameraIntegrationStatus Table
-- LucidChart
-- Project ERD
-- Joining table for Camera and Integration Test

CREATE TABLE CameraIntegrationStatus
( CameraSensorID int not null,
  IntegrationTestID decimal(3,1) not null,
  IS_Complete bit not null default 0,
  foreign key(CameraSensorID) REFERENCES Camera(SensorID),
  foreign key(IntegrationTestID) REFERENCES IntegrationTest(TestID)
  );

select * from CameraIntegrationStatus



-- IntegrationStatusChange Table
-- LucidChart
-- Project ERD
-- History Table for Integration Status change
CREATE TABLE IntegrationStatusUpdate
(	SensorID int NOT NULL,
	NewStatus bit NOT NULL,
	OldStatus bit NOT NULL,
	ChangeDate DATE default getDate(),
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);



-- Configuration Table
-- LucidChart
-- Project ERD
CREATE TABLE ConfigurationFile
(
    SensorID int NOT NULL PRIMARY KEY,
    RollResDevicepub_offset decimal(12,6) NULL,
	RollResConfig_offset decimal(12,6) NULL,
	PitchRes_Devicepub_offset decimal(12,6) NULL,
	PitchResConfig_offset decimal(12,6),
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)

);



-- Configuration Table
-- LucidChart
-- Project ERD
drop table ConfigurationFileUpdate
CREATE TABLE ConfigurationFileUpdate
(
    CameraSensorID INT NOT NULL ,

    NewRollResDevicepub_offset decimal(12,6) NULL,
    OldRollResDevicepub_offset decimal(12,6) NULL,
	ChangeDate DATE default getDate(),
	FOREIGN KEY (CameraSensorID) REFERENCES Camera(SensorID)
);




-- ErrorLog Table
-- SensorID Primary Key and Foreign Key
-- FileName should be the primary key since it will be unique
CREATE TABLE ErrorLog
(
    SensorID INT NOT NULL,
    LogFileName Varchar(50) NOT NULL PRIMARY KEY,
	FOREIGN KEY (SensorID) REFERENCES Camera(SensorID)
);




-- Boot Table
-- FileName Primary Key, Foreign Key
CREATE TABLE BootLog
(
    SensorID INT NOT NULL,
    EpochTime int NULL,
    LogFileName Varchar(50) NOT NULL PRIMARY KEY,
	RMSVersion Varchar(255) NULL,
	SCUVersion Varchar(255) NULL,
	GEDIVersion Varchar(255) NULL,
	AIBVersion Varchar(255) NULL,
	LogMessage Varchar(255) NULL,
	FOREIGN KEY (LogFileName) REFERENCES ErrorLog(LogFileName)

);
--  Index the BootTime
CREATE INDEX BootTimeIdx
ON Boot(EpochTime);

drop table Boot



-- SBIT Table
-- FileName Foreign Key
CREATE TABLE SBITLog
(
    SensorID INT NOT NULL,
    EpochTime int NULL,
    LogFileName Varchar(50) NOT NULL PRIMARY KEY,
	Test Varchar(25) NOT NULL,
	BitStatus bit NOT NULL,
	LogMessage Varchar(255) NULL,
	FOREIGN KEY (LogFileName) REFERENCES ErrorLog(LogFileName)
);




CREATE INDEX SBITTimeIdx
ON SBIT(EpochTime);

CREATE INDEX SBITStatusIdx
ON SBIT(Status);




-- PlanLog Table
-- FileName Foreign Key
-- HAD to change the name as 'Plan' is a keyword

CREATE TABLE PlanLog
(
    SensorID Decimal(3) NOT NULL,
    PlanID	Varchar(50),
    EpochTime int NULL,
    LogFileName Varchar(50) NOT NULL,
	Tasks int NULL,
	Datalink bit NULL,
	FOREIGN KEY (LogFileName) REFERENCES ErrorLog(LogFileName)

);

CREATE INDEX PlanLogTimeIdx
ON PlanLog(EpochTime);














