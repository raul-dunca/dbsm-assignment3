Create OR ALTER PROCEDURE InsertDataProcedureNoRollBack
(
    
    @tName VARCHAR(40),
	@oid INT,
	@lid INT,
    @tCreated Date,
	
	@PaName VARCHAR(30),
	@PaRevenue INT,

	@Since Date

)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @PartnerID INT;
	DECLARE @TeamID INT;
        

        
		BEGIN TRANSACTION;
		BEGIN TRY
			IF(@tName IS NULL)
			BEGIN
				RAISERROR('Team name must be non null', 16, 1);
			END
			INSERT INTO Teams (tName,oid,lid,tCreated)
			VALUES (@tName,@oid,@lid,@tCreated);
			SET @TeamID = SCOPE_IDENTITY();
			COMMIT TRAN
			PRINT 'COMMIT Teams';
		END TRY
        BEGIN CATCH
			ROLLBACK TRAN
            Print 'Error inserting into Teams: ' + ERROR_MESSAGE();
			PRINT 'ROLLBACK Teams';
        END CATCH;

        
		BEGIN TRANSACTION;
		BEGIN TRY
			IF(@PaName IS NULL)
			BEGIN
				RAISERROR('Partner name must be non null', 16, 1);
			END

			IF(@PaRevenue <0)
			BEGIN
				RAISERROR('Partner Revenue must be >=0', 16, 1);
			END
		    INSERT INTO Partners(PaName,PaRevenue)
			VALUES (@PaName,@PaRevenue);
			SET @PartnerID = SCOPE_IDENTITY();
			COMMIT TRAN
			PRINT 'COMMIT Partners';
		END TRY
        BEGIN CATCH
			ROLLBACK TRAN;
            PRINT 'Error inserting into Partners: ' + ERROR_MESSAGE();
			PRINT 'ROLLBACK Partners';
        END CATCH;

        
		BEGIN TRANSACTION;
		BEGIN TRY
			IF(@Since >GETDATE())
			BEGIN
				RAISERROR('Partner Since must be lower than todays date', 16, 1);
		   END
		   INSERT INTO Is_Partner(tid,Paid,Since)
			VALUES (@TeamID,@PartnerID,@Since);
			COMMIT TRAN
			PRINT 'COMMIT IsPartner';
		END TRY
        BEGIN CATCH
			ROLLBACK TRAN;
            PRINT 'Error inserting into Is_Partner: ' + ERROR_MESSAGE();
			PRINT 'ROLLBACK IsPartner';
        END CATCH;

END

EXEC InsertDataProcedureNoRollBack  'a', 1, 1, '2020-01-02','a',1000,'2021-06-12'     --succes
EXEC InsertDataProcedureNoRollBack  'b', 1, 1, '2020-01-02','b',-1000,'2021-06-12'    --fail
EXEC InsertDataProcedureNoRollBack  'c', 1, 1, '2020-01-02','c',1000,'2025-06-12'    --fail

SELECT * FROM Teams
SELECT * FROM Partners
SELECT * FROM Is_Partner

DELETE FROM Partners WHERE Paid >5
DELETE FROM Is_Partner WHERE tid>6
DELETE FROM Teams WHERE tid>6
