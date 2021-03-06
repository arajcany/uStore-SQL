SET NOCOUNT ON

DECLARE @dbFolderName as varchar(50)
DECLARE @dbNamePrefix as varchar(50)
DECLARE @dbDate as varchar(50)
DECLARE @dbNameSuffix as varchar(50)
DECLARE @dbNameExension as varchar(50)
DECLARE @dbBackupName as varchar(1024)


SET @dbFolderName = N'D:\DB_Backups\'
SET @dbDate = replace(replace(replace(convert(varchar(20), GETDATE(), 120), ' ', '_'), ':', ''), '-', '') --data and time stamp
SET @dbNameSuffix = ''
SET @dbNameExension = N'.bak'



--BACKUP DATABASE [uStore]
SET @dbNamePrefix = '_[uStore]_'
SET @dbBackupName =  @dbFolderName + @dbDate + @dbNamePrefix + @dbNameSuffix + @dbNameExension
BACKUP DATABASE [uStore]
TO  DISK = @dbBackupName
WITH NOFORMAT, NOINIT,  NAME = N'uStore-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10


--BACKUP DATABASE [XMPDB2]
SET @dbNamePrefix = '_[XMPDB2]_'
SET @dbBackupName =  @dbFolderName + @dbDate + @dbNamePrefix + @dbNameSuffix + @dbNameExension
BACKUP DATABASE [XMPDB2]
TO  DISK = @dbBackupName
WITH NOFORMAT, NOINIT,  NAME = N'XMPDB2-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10



--BACKUP DATABASE [XMPDBASSETS]
SET @dbNamePrefix = '_[XMPDBASSETS]_'
SET @dbBackupName =  @dbFolderName + @dbDate + @dbNamePrefix + @dbNameSuffix + @dbNameExension
BACKUP DATABASE [XMPDBASSETS]
TO  DISK = @dbBackupName
WITH NOFORMAT, NOINIT,  NAME = N'XMPDBASSETS-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10



--BACKUP DATABASE [XMPDBHDS]
SET @dbNamePrefix = '_[XMPDBHDS]_'
SET @dbBackupName =  @dbFolderName + @dbDate + @dbNamePrefix + @dbNameSuffix + @dbNameExension
BACKUP DATABASE [XMPDBHDS]
TO  DISK = @dbBackupName
WITH NOFORMAT, NOINIT,  NAME = N'XMPDBHDS-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10



--BACKUP DATABASE [XMPDBTRACKING]
SET @dbNamePrefix = '_[XMPDBTRACKING]_'
SET @dbBackupName =  @dbFolderName + @dbDate + @dbNamePrefix + @dbNameSuffix + @dbNameExension
BACKUP DATABASE [XMPDBTRACKING]
TO  DISK = @dbBackupName
WITH NOFORMAT, NOINIT,  NAME = N'XMPDBTRACKING-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
