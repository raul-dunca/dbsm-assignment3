
--SET DEADLOCK_PRIORITY Low

BEGIN TRANSACTION
UPDATE Teams SET lid = 1 WHERE tid=2;
WAITFOR DELAY '00:00:05';
UPDATE Partners SET PaRevenue = 700 WHERE Paid=2;
COMMIT TRANSACTION



--SELECT * FROM Teams SELECT * FROM Partners