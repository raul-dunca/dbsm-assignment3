
BEGIN TRANSACTION
UPDATE Partners
SET PaRevenue=1 WHERE Paid=3
WAITFOR DELAY '00:00:05';
ROLLBACK TRANSACTION