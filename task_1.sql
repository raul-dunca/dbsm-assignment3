Create OR ALTER PROCEDURE InsertDataProcedure
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
	DECLARE @ErrorMessage NVARCHAR(MAX) = '';
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
		END TRY
        BEGIN CATCH
            SET @ErrorMessage += 'Error inserting into Teams: ' + ERROR_MESSAGE() + CHAR(13);
        END CATCH;

        
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
		END TRY
        BEGIN CATCH
            SET @ErrorMessage += 'Error inserting into Partners: ' + ERROR_MESSAGE() + CHAR(13);
        END CATCH;

        
		BEGIN TRY
			IF(@Since >GETDATE())
			BEGIN
				RAISERROR('Partner Since must be lower than todays date', 16, 1);
		   END
		   INSERT INTO Is_Partner(tid,Paid,Since)
			VALUES (@TeamID,@PartnerID,@Since);
		END TRY
        BEGIN CATCH
            SET @ErrorMessage += 'Error inserting into Is_Partner: ' + ERROR_MESSAGE() + CHAR(13);
        END CATCH;

		IF @ErrorMessage <> ''
        BEGIN
			ROLLBACK;
			PRINT @ErrorMessage;
			PRINT 'ROLLBACK all data'
		END
		ELSE
		BEGIN 
			COMMIT;
			PRINT 'COMMIT all data'
		END;
END

EXEC InsertDataProcedure  'Team', 1, 1, '2020-01-02','Partner',1000,'2021-06-12'   --succes
EXEC InsertDataProcedure  'Team1', 1, 1, '2020-01-02','Partner1',1000,'2025-06-12'            --fail

SELECT * FROM Teams
SELECT * FROM Partners
SELECT * FROM Is_Partner


DELETE FROM Teams WHERE tid>6
