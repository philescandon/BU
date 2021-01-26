-- Phillip Escandon
--Escandon@bu.com

-- Procedures for Sensor_DB



-- -------------------------  Procedures ------------
-- AddCamera
drop procedure AddCamera

CREATE PROCEDURE AddCamera
	@SensorID int,
	@Customer VARCHAR(25)
AS
BEGIN
	INSERT INTO Camera(
		SensorID,
		Customer)
	VALUES(
		@SensorID,
		@Customer);
END;



-- AddSensorFamily
drop procedure AddSensorFamily	
CREATE PROCEDURE AddSensorFamily 
	@SensorID INT, 
	@Is_DB110 bit, 
	@Is_MS110 bit, 
	@Is_MS177 bit, 
	@Is_TACSAR bit     
AS
BEGIN
	INSERT INTO SensorFamily(SensorID,Is_DB110,Is_MS110,Is_MS177,Is_TACSAR)
	VALUES(@SensorID,@Is_DB110,@Is_MS110,@Is_MS177,@Is_TACSAR);
END;




-- AddIntegrationStatus
drop procedure AddIntegrationStatus

CREATE PROCEDURE AddIntegrationStatus
	@CameraSensorID int,
	@IntegrationTestID decimal(3,1),
	@Is_Complete bit
AS
BEGIN	
	insert into CameraIntegrationStatus(
						CameraSensorID,
						IntegrationTestID,
						IS_Complete)
	values(@CameraSensorID,
			@IntegrationTestID,
			@Is_Complete);
END;





-- AddIntegrationTest
drop procedure AddIntegrationTest

CREATE PROCEDURE AddIntegrationTest 
	@TestID decimal(3,1) ,
	@TestName VARCHAR(30),
	@DataLocation VARCHAR(255)
AS
BEGIN
	INSERT INTO IntegrationTest(TestID,
								TestName,
								DataLocation)
	VALUES(@TestID,
			@TestName, 
			@DataLocation);
END;




-- AddConfigurationFile
CREATE PROCEDURE AddConfigurationFile 
	@SensorID INT , 
	@RollResDevicePub_offset decimal(12,6) , 
	@RollResConfig_offset decimal(12,6) ,
	@PitchRes_Devicepub_offset decimal(12,6) , 
	@PitchREsConfig_offset decimal(12,6)
AS
BEGIN
	INSERT INTO ConfigurationFile(SensorID,RollResConfig_offset,RollResDevicepub_offset,PitchRes_Devicepub_offset,PitchResConfig_offset)
	VALUES(@SensorID,@RollResDevicePub_offset,@RollResConfig_offset,@PitchRes_Devicepub_offset,@PitchREsConfig_offset);
END;


-- AddErrorLog
CREATE PROCEDURE AddErrorLog 
	@SensorID INT, 
	@LogFileName varchar(50) 
AS
BEGIN
	INSERT INTO ErrorLog(SensorID,LogFileName)
	VALUES(@SensorID,@LogFileName);
END;

-- AddBootLog
CREATE PROCEDURE AddBootLog 
	@SensorID INT , 
	@EpochTime int , 
	@LogFileName varchar(50) , 
	@RMSVersion varchar(255) , 
	@SCUVersion varchar(255),
	@GEDIVersion varchar(255),
	@AIBVersion varchar(255),
	@LogMessage varchar(255)
AS
BEGIN
	INSERT INTO BootLog(SensorID,
					EpochTime,
					LogFileName,
					RMSVersion,
					SCUVersion,
					GEDIVersion,
					AIBVersion,
					LogMessage)
	VALUES(@SensorID,
		@EpochTime,
		@LogFileName,
		@RMSVersion,
		@SCUVersion,
		@GEDIVersion,
		@AIBVersion,
		@LogMessage);
END;




-- Add SBIT LOG
CREATE PROCEDURE AddSBITLog 
	@SensorID INT,
	@EpochTime int , 
	@LogFileName varchar(50) , 
	@Test varchar(25) , 
	@BitStatus BIT,
	@LogMessage varchar(255)
AS
BEGIN
	INSERT INTO SBITLog(SensorID,
				EpochTime,
				LogFileName,
				Test,
				BitStatus,
				LogMessage)
	VALUES(@SensorID,
			@EpochTime,
			@LogFileName,
			@Test,
			@BitStatus,
			@LogMessage);
END;




-- AddPlanLog
CREATE PROCEDURE AddPlanLog 
	@SensorID INT,  
	@PlanID varchar(50) ,
	@EpochTime int , 
	@LogFileName varchar(50) , 
	@Tasks decimal(3,0),
	@Datalink BIT
AS
BEGIN
	INSERT INTO PlanLog(SensorID,PlanID,EpochTime,LogFileName,Tasks,Datalink)
	VALUES(@SensorID,@PlanID,@EpochTime,@LogFileName,@Tasks,@Datalink );
END;









-- UPDATE TRIGGERS

CREATE TRIGGER IntegrationStatusChangeTrigger
ON CameraIntegrationStatus
AFTER UPDATE
AS
BEGIN
    DECLARE @CameraSensorID int =  (SELECT CameraSensorID FROM DELETED); 
	DECLARE @OldStatus bit = (SELECT IS_Complete FROM DELETED);
	DECLARE @NewStatus bit = (SELECT IS_Complete FROM INSERTED);
IF (@OldStatus <> @NewStatus)
	INSERT INTO IntegrationStatusUpdate(SensorID,NewStatus,OldStatus,ChangeDate)
	VALUES(
		(SELECT @CameraSensorID FROM INSERTED),
		@NewStatus,
		@OldStatus,
		GETDATE());
END;

-- TESTING THE TRIGGER
--Select * from CameraIntegrationStatus

--UPDATE CameraIntegrationStatus
--SET IS_Complete = 1
--WHERE CameraSensorID = 50 AND IntegrationTestID = 1.2

--Select * from CameraIntegrationStatus
select * from IntegrationStatusUpdate





-- ConfigFileUpdateTrigger
DROP TRIGGER ConfigFileUpdateTrigger
CREATE TRIGGER ConfigFileUpdateTrigger
ON ConfigurationFile
AFTER UPDATE
AS
BEGIN
	    DECLARE @CameraSensorID int =  (SELECT SensorID FROM DELETED); 
		DECLARE @NewRollResDevicepub_offset decimal(12,6) = (SELECT RollResDevicepub_offset FROM INSERTED);
		DECLARE @OldRollResDevicepub_offset decimal(12,6) = (SELECT RollResDevicepub_offset FROM DELETED);

IF (@NewRollResDevicepub_offset <> @OldRollResDevicepub_offset)
	INSERT INTO ConfigurationFileUpdate( CameraSensorID,
										NewRollResDevicepub_offset, 
										OldRollResDevicepub_offset,
										ChangeDate)

	VALUES (
			(SELECT @CameraSensorID FROM INSERTED),
			@NewRollResDevicepub_offset,
			@OldRollResDevicepub_offset,
			GETDATE()
					);
END;



-- Testing the trigger
--select * from ConfigurationFileUpdate

--UPDATE ConfigurationFile
--SET RollResDevicepub_offset = 9.1234
--WHERE SensorID = 50;

select * from ConfigurationFileUpdate


























