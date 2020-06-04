USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spCargarDatosAdmin]    Script Date: 3/6/2020 20:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE spCargarDatosAdmin

AS
BEGIN
    SET NOCOUNT ON;

    -- VARIABLES --
    DECLARE @Usuario XML

    BEGIN TRY
        --Insercion de los tipos de documentos de identificacion
        SELECT @Usuario = U
        FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\Administradores.xml', Single_BLOB) AS Usuario(U)

        INSERT INTO Usuario (Nombre, Password, TipoUsuario, EstaBorrado)
        SELECT u.value('@user','VARCHAR(100)') AS Nombre
            , u.value('@password','VARCHAR(100)') AS Password
            , 'Administrador' AS TipoUsuario
            , 0 AS EstaBorrado
        FROM @Usuario.nodes('/Administrador/UsuarioAdmi') AS t(u); 

    END TRY

    BEGIN CATCH
        return @@ERROR * -1
    END CATCH
 END

 exec spCargarDatosAdmin