-- Phillip Escandon
--Escandon@bu.com

-- Dummy Data for Sensor_DB



--  Add camera data
BEGIN TRANSACTION AddCamera;
EXECUTE AddCamera 50,'Thailand';
COMMIT TRANSACTION AddCamera;

BEGIN TRANSACTION AddCamera;
EXECUTE AddCamera 51,'Jordan';
COMMIT TRANSACTION AddCamera;

BEGIN TRANSACTION AddCamera;
EXECUTE AddCamera 52,'Jordan';
COMMIT TRANSACTION AddCamera;

BEGIN TRANSACTION AddCamera;
EXECUTE AddCamera 53,'Jordan';
COMMIT TRANSACTION AddCamera;

select * from Camera


-- Add Sensor Family Data
BEGIN TRANSACTION AddSensorFamily
EXECUTE AddSensorFamily 50,1,0,0,0
COMMIT TRANSACTION AddSensorFamily

BEGIN TRANSACTION AddSensorFamily
EXECUTE AddSensorFamily 51,1,0,0,0
COMMIT TRANSACTION AddSensorFamily

select * from SensorFamily


-- Add Integration Test Data
BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 1.1,'Controls - Gyro Drift','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 1.2,'Controls - Resolver Offsets','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 1.3,'Controls - Gyro Gain','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 1.4,'Controls - Quiescent Noise','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.1,'LineOfSight X Axis Jitter','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.2,'LineOfSight Y Axis Jitter','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.3,'LineOfSight Z Axis Jitter','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest


BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.4,'LineOfSight X Axis Smear','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.5,'LineOfSight Y Axis Smear','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 2.6,'LineOfSight Z Axis Smear','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest


BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 3.1,'Thermal Hot','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 3.2,'Thermal Cold','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 3.3,'Thermal Ambient','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest


BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 4.1,'Auxillary - Roll','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 4.2,'Auxillary - Pitch','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 5.1,'Imaging EO Focus','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

BEGIN TRANSACTION AddIntegrationTest
EXECUTE AddIntegrationTest 5.1,'Imaging IR Focus','IntegrationSharePoint';
COMMIT TRANSACTION AddIntegrationTest

select * from IntegrationTest,Camera

-- Add Integration Status
BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 50,1.1,1
COMMIT TRANSACTION AddIntegrationStatus

BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 50,1.2,0
COMMIT TRANSACTION AddIntegrationStatus

BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 50,1.3,0
COMMIT TRANSACTION AddIntegrationStatus

BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 51,1.1,0
COMMIT TRANSACTION AddIntegrationStatus

BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 51,1.2,0
COMMIT TRANSACTION AddIntegrationStatus

BEGIN TRANSACTION AddIntegrationStatus
EXECUTE AddIntegrationStatus 51,1.3,0
COMMIT TRANSACTION AddIntegrationStatus

--select * from CameraIntegrationStatus	
--select * from CameraIntegrationStatus	
--where CameraSensorID = 51


-- Add Configuration Data

BEGIN TRANSACTION AddConfigurationFile
EXECUTE AddConfigurationFile 50, 4.56, 5.67, 6.789, 1.2345;
COMMIT TRANSACTION AddConfigurationFile

BEGIN TRANSACTION AddConfigurationFile
EXECUTE AddConfigurationFile 51, 1.56, 8.67, 2.789, 5.2345;
COMMIT TRANSACTION AddConfigurationFile





-- Add Errorlog data
BEGIN TRANSACTION AddErrorLog
EXECUTE AddErrorLog 50,'20200608_Sensor50.log';
COMMIT TRANSACTION AddErrorLog
-- Add Boot Log Data
BEGIN TRANSACTION AddBootlog
EXECUTE AddBootLog 50,1527061771,
					'20200608_Sensor50.log',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND F15S',
					'TSY|223 1527061771 BitMaintLog.c 640 CS_addMaintLogEnt';
COMMIT TRANSACTION AddBootLog






-- For this particular ErrorLog 
-- Add ErrorLog data
-- Add BootLog data
-- Add SBITLog data
-- Add Planlog data
-- ErrorLog (1 of 4)
BEGIN TRANSACTION AddErrorLog
EXECUTE AddErrorLog 51,'20200608_Sensor51.log';
COMMIT TRANSACTION AddErrorLog
--Boot Log (2 of 4)
BEGIN TRANSACTION AddBootlog
EXECUTE AddBootLog 51,1527061864,
					'20200608_Sensor51.log',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND F15S',
					'TSY|223 1527061771 BitMaintLog.c 640 CS_addMaintLogEnt';
COMMIT TRANSACTION AddBootLog

--SBIT Log (3 of 4)
BEGIN TRANSACTION SBITLog
EXECUTE AddSBITLog 51,1527061869, 
					'20200608_Sensor51.log',
					'RFRelay',
					1,
					'TR_Medium AS node name = GMP  TID = RFRelay, BIT status = PASS BitMgr.c 450 bitProcBitDevStatChng';
COMMIT TRANSACTION AddSBITLog
-- Planlog (4 of 4 step)
BEGIN TRANSACTION AddPlanLog
EXECUTE AddPlanLog 50,
				   '1527061771_WEST40',
				   1530061844,
				   '20200608_Sensor51.log',
					4,
					0;
COMMIT TRANSACTION AddPlanLog

select * from ErrorLog
select * from Boot
select * from SBIT
select * from PlanLog



-- For this particular ErrorLog 
-- Add ErrorLog data
-- Add BootLog data
-- Add SBITLog data
-- Add Planlog data
-- ErrorLog (1 of 4)
BEGIN TRANSACTION AddErrorLog
EXECUTE AddErrorLog 50,'20180608West_Sensor50.log';
COMMIT TRANSACTION AddErrorLog
--Boot Log (2 of 4)
BEGIN TRANSACTION AddBootlog
EXECUTE AddBootLog 50,1532061901,
					'20180608West_Sensor50.log',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND F15S',
					'TSY|223 1527061771 BitMaintLog.c 640 CS_addMaintLogEnt';
COMMIT TRANSACTION AddBootLog

--SBIT Log (3 of 4)
BEGIN TRANSACTION SBITLog
EXECUTE AddSBITLog 50,1527061771, 
					'20200608_Sensor50.log',
					'Heartbeat',
					1,
					'TR_Medium AS node name = BackScan  TID = Heartbeat, BIT status = PASS BitMgr.c 441 bitProcBitDevStatChng';
COMMIT TRANSACTION AddSBITLog

-- Planlog (4 of 4 step)
BEGIN TRANSACTION AddPlanLog
EXECUTE AddPlanLog 50,
				   '1527061771_North40',
				   1528903771,
				   '20200608_Sensor50.log',
					4,
					0;
COMMIT TRANSACTION AddPlanLog



-- For this particular ErrorLog 
-- Add ErrorLog data
-- Add BootLog data
-- Add SBITLog data
-- Add Planlog data
-- ErrorLog (1 of 4)
BEGIN TRANSACTION AddErrorLog
EXECUTE AddErrorLog 51,'20190608South_Sensor51.log';
COMMIT TRANSACTION AddErrorLog

BEGIN TRANSACTION AddBootlog
EXECUTE AddBootLog 51,1567061553,
					'20190608South_Sensor51.log',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND F15S',
					'TSY|223 1527061771 BitMaintLog.c 640 CS_addMaintLogEnt';
COMMIT TRANSACTION AddBootLog

--SBIT Log (3 of 4)
BEGIN TRANSACTION SBITLog
EXECUTE AddSBITLog 51,1528501587, 
					'20190608South_Sensor51.log',
					'Heartbeat',
					1,
					'TR_Medium AS node name = BackScan  TID = Heartbeat, BIT status = PASS BitMgr.c 441 bitProcBitDevStatChng';
COMMIT TRANSACTION AddSBITLog

-- Planlog (4 of 4 step)
BEGIN TRANSACTION AddPlanLog
EXECUTE AddPlanLog 51,
				   '1527061771_North40',
				   1528503743,
				   '20190608South_Sensor51.log',
					45,
					0;
COMMIT TRANSACTION AddPlanLog




-- Add ErrorLog data
-- Add BootLog data
-- Add SBITLog data
-- Add Planlog data
-- ErrorLog (1 of 4)
BEGIN TRANSACTION AddErrorLog
EXECUTE AddErrorLog 51,'20190608East_Sensor51.log';
COMMIT TRANSACTION AddErrorLog

BEGIN TRANSACTION AddBootlog
EXECUTE AddBootLog 51,1569514553,
					'20190608East_Sensor51.log',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND',
					'17Dec14_184623_DB110_F15S_REL15.2_CAND F15S',
					'TSY|223 1527061771 BitMaintLog.c 640 CS_addMaintLogEnt';
COMMIT TRANSACTION AddBootLog

--SBIT Log (3 of 4)
BEGIN TRANSACTION SBITLog
EXECUTE AddSBITLog 51,1575301587, 
					'20190608East_Sensor51.log',
					'Heartbeat',
					1,
					'TR_Medium AS node name = BackScan  TID = Heartbeat, BIT status = PASS BitMgr.c 441 bitProcBitDevStatChng';
COMMIT TRANSACTION AddSBITLog

-- Planlog (4 of 4 step)
BEGIN TRANSACTION AddPlanLog
EXECUTE AddPlanLog 51,
				   '1527061771_North40',
				   1528503743,
				   '20190608East_Sensor51.log',
					32,
					0;
COMMIT TRANSACTION AddPlanLog



