/*
   Sunday, May 10, 20209:37:16 PM
   User: 
   Server: ESCANDON-LENOVO\SQLEXPRESS
   Database: Lab1Test
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Movie
	(
	Title varchar(64) NULL,
	Genre varchar(32) NULL,
	ReleaseDate date NULL,
	Price decimal(6, 2) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Movie SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Movie', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Movie', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Movie', 'Object', 'CONTROL') as Contr_Per 