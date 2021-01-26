-- Phillip Escandon
-- Escandon@bu.edu

use SENSOR_DB


select RollResConfig_offset 
from ConfigurationFile


select AVG(RollResConfig_offset) 
from ConfigurationFile



SELECT SensorID,
Customer
FROM Camera
JOIN
ORDER BY Customer



select SensorID,TestID, IS_Complete,TestName 
from Camera
join CameraIntegrationStatus on CameraIntegrationStatus.CameraSensorID = Camera.SensorID
join IntegrationTest on IntegrationTest.TestID = CameraIntegrationStatus.IntegrationTestID




select Customer, Camera.SensorID,TestName, IS_Complete,ErrorLog.LogFileName,SBIT.BitStatus,SBIT.LogMessage 
from Camera
join CameraIntegrationStatus on CameraIntegrationStatus.CameraSensorID = Camera.SensorID
join IntegrationTest on IntegrationTest.TestID = CameraIntegrationStatus.IntegrationTestID
join ErrorLog on Errorlog.SensorID = Camera.SensorID
join SBIT on SBIT.LogFileName = Errorlog.LogFileName
where Camera.Customer = 'Thailand'


select Customer, Camera.SensorID,TestName, IS_Complete,ErrorLog.LogFileName,SBIT.BitStatus,SBIT.LogMessage 
from Camera
join CameraIntegrationStatus on CameraIntegrationStatus.CameraSensorID = Camera.SensorID
join IntegrationTest on IntegrationTest.TestID = CameraIntegrationStatus.IntegrationTestID
join ErrorLog on Errorlog.SensorID = Camera.SensorID
join SBIT on SBIT.LogFileName = Errorlog.LogFileName
where Camera.Customer = 'Jordan'
