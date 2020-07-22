USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerRecibosPedePropiedad]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].spObtenerRecibosdePropiedadConInteres 
@id int 
as 	
	BEGIN 
		BEGIN TRY

			SET NOCOUNT ON 
			SET XACT_ABORT ON

			DECLARE 
			@min int, 
			@max int, 
			@monto money, 
			@montointeres money, 
			@tasainteres float, 
			@fechaMax date, 
			@fechaOperacion date

			DECLARE @result table(
			ID int, 
			FechaEmision date, 
			Nombre varchar(100), 
			Monto money, 
			Montointeres money)

			SELECT @min = MIN(ID), @max = Max(ID) FROM Recibo AS R WHERE R.Estado=0 AND @id=R.IdPropiedad

			BEGIN TRANSACTION
			WHILE (@min<=@max)
			BEGIN
				SET @monto = (SELECT Monto FROM Recibo WHERE @min = ID)
				SET @tasainteres = (SELECT CC.TasaInteresMoratorio FROM CCobro AS CC
									INNER JOIN Recibo AS R ON R.IdCCobro = CC.ID 
									WHERE @min = R.ID)
				SET @fechaOperacion = GETDATE()
				SET @FechaMax = (SELECT FechaMaximaPago FROM Recibo R WHERE @min = R.ID)
				SET @montointeres =  (@monto*@tasainteres/365)*ABS(DATEDIFF(day, @FechaMax, @fechaOperacion))
		
				INSERT INTO @result
				SELECT R.ID, R.FechaEmision, CC.Nombre, R.Monto, @montointeres
				FROM Recibo AS R
				INNER JOIN CCobro AS CC ON R.IdCCobro = CC.ID
				WHERE R.Estado=0 AND @id=R.IdPropiedad and  @min = R.ID

				SELECT @min = MIN(ID) FROM Recibo AS R WHERE R.Estado=0 AND @id=R.IdPropiedad and ID>@min
			END
			SELECT ID, FechaEmision, Nombre, Monto, Montointeres
			FROM @result AS r
			ORDER BY r.FechaEmision DESC
			COMMIT
		END TRY
		BEGIN CATCH
		If @@TRANCOUNT > 0 
			ROLLBACK TRAN;
			THROW 60000,'Error: No se ha podido buscar Recibos',1;
		END CATCH
	END
