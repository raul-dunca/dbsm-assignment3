
--SET DEADLOCK_PRIORITY HIGH

BEGIN TRANSACTION
UPDATE Partners SET PaRevenue = 120 WHERE Paid=2;
WAITFOR DELAY '00:00:05';
UPDATE Teams SET lid = 2 WHERE tid=2;
COMMIT TRANSACTION


--BEGIN TRANSACTION
--UPDATE Teams SET lid = 2 WHERE tid=2;
--WAITFOR DELAY '00:00:05';
--UPDATE Partners SET PaRevenue = 7000 WHERE Paid=2;
--COMMIT TRANSACTION