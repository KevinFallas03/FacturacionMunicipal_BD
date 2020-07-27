USE [FacturacionMunicipal]
GO

CREATE OR ALTER PROC [dbo].[spCargarConfiguracion] 
AS 
BEGIN
	
	BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON
			BEGIN TRAN
				INSERT INTO Tipos (ID, Nombre)
				VALUES(1, 'varchar')
				INSERT INTO Tipos (ID, Nombre)
				VALUES(2, 'integer')
				INSERT INTO Tipos (ID, Nombre)
				VALUES(3, 'date')
				INSERT INTO Tipos (ID, Nombre)
				VALUES(4, 'money')
				INSERT INTO Tipos (ID, Nombre)
				VALUES(5, 'decimal')

				INSERT INTO ValoresConfiguracion(ID, IdTipos, Nombre, Valor, InsertAt, UpdateAt)
				VALUES(1, 5, 'TasaInteres AP', '12.5', '2017-10-01 12:05', '2017-10-01 12:05')
				INSERT INTO ValoresConfiguracion(ID, IdTipos, Nombre, Valor, InsertAt, UpdateAt)
				VALUES(2, 1, 'Nombre Gerente Firma Contratos', 'Pedro Perez Rojas', '2017-10-01 12:05', '2017-10-01 12:05')
				INSERT INTO ValoresConfiguracion(ID, IdTipos, Nombre, Valor, InsertAt, UpdateAt)
				VALUES(3, 1, 'Ruta para salvado de documentos', 'C:\documentos\contratos', '2017-10-01 12:05', '2017-10-01 12:05')
			COMMIT
		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50004,'Error: No se ha podido cargar configuracion',1;
		END CATCH

END