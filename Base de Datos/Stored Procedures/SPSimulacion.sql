 
-- ==========================================================================================
-- Autores:		<Kevin Fallas y Johel Mora>
-- Fecha de creacion: <03/06/2020>
-- Fecha de ultima modificacion <7/6/2020>
-- Descripcion:	<SP para hacer la simulacion de actividades de la municipalidad>
-- ==========================================================================================

	--	///		TABLAS VARIABLES	//
--- SCRIPT DE SIMULACION PARA LA TAREA PROGRAMADA

-- precondición, los nodos para la fecha de operación en el XML vienen en orden ascendente.

/****** Object:  StoredProcedure [dbo].[Simulacion]    Script Date: 11/27/2019 10:20:30 PM ******/
USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[Simulacion]
AS

BEGIN
	SET NOCOUNT ON 

	Declare @Propiedades table
	(
		sec int identity(1,1) primary key,
		NumFinca int,
		Valor money,
		Direccion varchar(150),
		EstaBorrado bit
	);

	Declare @Propietarios table 
	(
	   sec int identity(1,1) primary key, 
	   TipoDocId int, 
	   Nombre varchar(100),
	   ValorDocId varchar(100),
	   EstaBorrado bit
	);

	Declare @PropJuridico table
	(
		sec int identity(1,1) primary key,
		DocIdPersonaJuridica varchar(100),
		NombrePersonaResponsable varchar(100),
		IdTipoDocumento int,
		ValorDocumento varchar(100),
		EstaBorrado bit
	);

	Declare @PropiedadVsPropietario table
	(
		sec int identity(1,1) primary key, 
		IdPropiedad varchar(100),
		IdPropietario varchar(100),
		EstaBorrado bit
	);

	Declare @PropiedadesxCCobro table
	(
		sec int identity(1,1) primary key,
		IdCCobro int,
		IdPropiedad int, 
		FechaInic date,
		FechaFin date
	);
	
	Declare @Usuarios table
	(
		sec int identity(1,1) primary key,
		Nombre varchar(100),
		Password varchar(100),
		TipoUsuario varchar(100),
		FechaIngreso date,
		EstaBorrado bit
	);

	Declare @UsuarioVersusPropiedad table
	(
		sec int identity(1,1) primary key,
		IdPropiedad varchar(100),
		IdUsuario varchar(100),
		EstaBorrado bit
	);

	--Tabla para almacenar los cambios en un dia

	Declare @PropiedadCambio CambioValorPropiedadType;

	--Tabla variable para almacenar los pagos dia por dia
	Declare @PagosHoy PagosHoyType;

	--Tabla variable para almacenar los ap dia por dia
	Declare @APHoy APHoyType;

	--Tabla para los movimientos de consumo de agua
	Declare @MovConsumo MovConsumoType;

	--Fecha para las simulaciones
	Declare @FechaOperacion date;

	-- se extraen fechas operación
	Declare @FechasAProcesar table 
	(
	   sec int identity(1,1) primary key, 
	   fecha date
	);

	-- Variables para leer xml
	DECLARE @DocumentoXML xml 

	BEGIN TRY
		SELECT @DocumentoXML = DXML
		FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\Operaciones.xml', Single_BLOB) AS DocumentoXML(DXML)
		insert @FechasAProcesar (fecha)
		select f.value('@fecha', 'DATE')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia') AS t(f);
	END TRY
	BEGIN CATCH
		PRINT 'Hubo un error de cargar fechas'
		RETURN @@ERROR * -1;
	END CATCH


	--parte 3 
	
	-- variables que almacenan valor constante para controlar emision masiva de recibos

	--Declare @IdCCobro_ConsumoAgua=1, @IdCCobro_PatenteCantina=7   -- Son ids con valores solo de ejemplo

	-- Variables para controlar la iteración
	DECLARE @Lo1 int, 
			@Hi1 int, 
			@Lo2 int, 
			@Hi2 int;

	DECLARE @minfecha datetime, 
			@maxfecha datetime;

	DECLARE @fechaOperacionNodo date;

	-- iterando de la fecha más antigua a la menos antigua
	SELECT @minfecha=min(F.fecha), @maxfecha=max(F.fecha)  -- min y max son funciones agregadas
	FROM @FechasAProcesar F;

	SELECT @Lo1=F.sec
	FROM @FechasAProcesar F
	WHERE F.Fecha=@minfecha;

	SELECT @Hi1=F.sec
	FROM @FechasAProcesar F
	WHERE F.Fecha=@maxfecha;

	--parte4
	--iteramos por fecha
	WHILE @Lo1<=@Hi1
	BEGIN
		Select @FechaOperacion=F.Fecha 
		from @FechasAProcesar F 
		where sec=@Lo1;
		
		--DECLARE @fechaOperacionNodo date
		SET @fechaOperacionNodo = @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE');

		--delete @Propiedades -- ELIMINAR

		--procesar nodos propiedades MASIVO

		INSERT INTO Propiedad (NumFinca, Valor, Direccion, M3Acumulados, M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado)
		select pd.value('@NumFinca', 'INT')
		, pd.value('@Valor', 'MONEY')
		, pd.value('@Direccion', 'VARCHAR(150)')
		, 0 AS M3Acumulados
		, 0 AS M3AcumuladosUltimoRecibo
		, @FechaOperacion AS FechaIngreso
		, 0 AS EstaBorrado
		FROM @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/Propiedad') AS t(pd);
		

		-- procesar nodos propietario
		INSERT INTO Propietario (IdTipoDocumento, Nombre, ValorDocumento, FechaIngreso, EstaBorrado)
		select pt.value('@TipoDocIdentidad','INT')
		, pt.value('@Nombre', 'VARCHAR(100)')
		, pt.value('@identificacion', 'VARCHAR(100)')
		, @FechaOperacion AS FechaIngreso
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/Propietario') AS t(pt);
		
		--Propietarios Juridicos 
		--procesar nodos propietarios juridicos ITERATIVO -- considerar hacerlos masivos
		delete @PropJuridico 
		insert @PropJuridico(DocIdPersonaJuridica, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		select pd.value('@docidPersonaJuridica', 'VARCHAR(100)')
		, pd.value('@Nombre', 'VARCHAR(100)')
		, pd.value('@TipDocIdRepresentante', 'INT')
		, pd.value('@DocidRepresentante', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/PersonaJuridica') AS t(pd);

		--iteramos en propietarios juridico
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropJuridico
		while @Lo2<=@Hi2
		Begin
		   insert dbo.PropietarioJuridico(ID, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		   Select Pt.ID, Pj.NombrePersonaResponsable, Pj.IdTipoDocumento, Pj.ValorDocumento, Pj.EstaBorrado
		   from @PropJuridico Pj, dbo.Propietario Pt
		   where sec=@Lo2 and Pj.DocIdPersonaJuridica = Pt.ValorDocumento
		   Set @Lo2=@Lo2+1
		end;

		--Propietarios x Propiedades
		-- procesar nodos PropietarioxPropiedad
		delete @PropiedadVsPropietario
		insert @PropiedadVsPropietario (IdPropiedad, IdPropietario, EstaBorrado)
		select pp.value('@NumFinca', 'VARCHAR(100)')
		, pp.value('@identificacion', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/PropiedadVersusPropietario') AS t(pp);
		
		--iteramos en PropiedadVsPropietario
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropiedadVsPropietario
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Prop_Prop(IdPropiedad, IdPropietario, EstaBorrado)
		   Select Pd.ID, Pt.ID, Pp.EstaBorrado
		   from @PropiedadVsPropietario Pp, dbo.Propietario Pt, dbo.Propiedad Pd
		   where sec=@Lo2 and Pp.IdPropietario = Pt.ValorDocumento and Pp.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end;
	 
		--insertamos Usuarios insert MASIVO
		--delete @Usuarios
		INSERT INTO Usuario (Nombre, Password, TipoUsuario, FechaIngreso, EstaBorrado)-- rultimo atributo 
		select u.value('@Nombre','VARCHAR(100)')
		, u.value('@password', 'VARCHAR(100)')
		, 'Normal' AS TipoUsuario
		, @FechaOperacion AS FechaIngreso
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/Usuario') AS t(u);
		
		--CCobros x Propiedad
		--procesar nodos CCobroVsPropiedad
		delete @PropiedadesxCCobro 
		insert @PropiedadesxCCobro (IdCCobro, IdPropiedad, FechaInic)
		select pc.value('@idcobro','INT') 
		, pc.value('@NumFinca', 'INT') 
		, @FechaOperacion AS FechaInic
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/ConceptoCobroVersusPropiedad') AS t(pc);

		-- iteramos en PropiedadesxCCobro 
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropiedadesxCCobro 
		while @Lo2<=@Hi2
		Begin
		   insert dbo.CCobro_PNP(IdCCobbro, IdPropiedad, FechaInic)
		   Select PC.IdCCobro, Pd.ID, PC.FechaInic 
		   from @PropiedadesxCCobro PC, dbo.Propiedad Pd
		   where sec=@Lo2 and PC.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end;
		
		--Usuarios Versus Propiedad
		--procesamos nodos UsuarioVersusPropiedad
		delete @UsuarioVersusPropiedad
		insert @UsuarioVersusPropiedad (IdPropiedad, IdUsuario, EstaBorrado)
		select up.value('@NumFinca', 'VARCHAR(100)')
		, up.value('@nombreUsuario', 'VARCHAR(100)')
		, 0 as EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/UsuarioVersusPropiedad') AS t(up);
		
		-- iteramos en @UsuarioVersusPropiedad 
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @UsuarioVersusPropiedad 
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Usuario_Prop(IdPropiedad, IdUsuario, EstaBorrado)
		   Select Pd.ID, U.ID, Up.EstaBorrado
		   from @UsuarioVersusPropiedad Up, dbo.Usuario U, dbo.Propiedad Pd
		   where sec=@Lo2 and Up.IdUsuario = U.Nombre and Up.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end;

		--procesar los cambios en las propiedades por dia
		DELETE @PropiedadCambio
		INSERT INTO @PropiedadCambio (NumFinca, NuevoValor)
		select pc.value('@NumFinca', 'INT')
			, pc.value('@NuevoValor', 'MONEY')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/CambioPropiedad') AS t(pc)
		EXEC spProcesaCambioValorPropiedad @PropiedadCambio;

		--PAGO DE LOS RECIBOS  
		DELETE @PagosHoy
		INSERT INTO @PagosHoy(NumFinca,TipoRecibo,Fecha)
		SELECT c.value('@NumFinca', 'INT')
			, c.value('@TipoRecibo', 'INT')
			, @FechaOperacion AS FechaOperacion
		FROM @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/Pago') AS t(c)
		EXEC spProcesaPagos @PagosHoy;

		
		-- CREACION DE AP
		DELETE @APHoy
		INSERT INTO @APHoy(NumFinca,Plazo,Fecha)
		SELECT c.value('@NumFinca', 'INT')
			, c.value('@Plazo', 'INT')
			, @FechaOperacion AS FechaOperacion
		FROM @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/AP') AS t(c)
		
		
		-- Convertir en SP
		DECLARE @minid int, 
				@maxid int;

		SELECT	@minid = MIN(sec), @maxid = MAX(sec) 
		FROM @APHoy;

		WHILE @minid <= @maxid
		BEGIN
			DECLARE @pidP int, @pmontoO money, @pplazo int, @pcuota money, @pfecha date, @ptasaA decimal, @montoMoratorio money, @tasaMoratoria FLOAT
			SELECT @pidP = P.ID, @pplazo = A.Plazo, @pfecha = A.Fecha --Obtener ID de Propiedad, Plazo y Fecha
			FROM Propiedad AS P
			INNER JOIN @APHoy AS A ON A.NumFinca = P.NumFinca
			WHERE @minid = A.sec

			--Creación de Recibos Moratorios
			INSERT INTO Recibo(IdCCobro,Monto,Estado,IdPropiedad,FechaEmision,FechaMaximaPago) 
			SELECT 11, R.Monto*CC.TasaInteresMoratorio/365*ABS(DATEDIFF(DAY, R.FechaMaximaPago, @FechaOperacion)), 
			0, @pidP, @FechaOperacion, DATEADD(DAY,CC.QDiasVencimiento,@fechaOperacion)
			FROM CCobro AS CC
			INNER JOIN Recibo AS R ON R.IdCCobro = CC.ID
			WHERE Estado = 0 and IdPropiedad = 8 and R.FechaMaximaPago<@fechaOperacion;

			SELECT @pmontoO = SUM(Monto) 
			FROM Recibo 
			WHERE IdPropiedad = @pidP AND Estado = 0;

			SELECT @ptasaA = CAST (Valor AS decimal) 
			FROM ValoresConfiguracion 
			WHERE ID = 1;

			SELECT @pcuota = @pmontoO * (POWER(1 + @ptasaA/100, @pplazo)) / (POWER(1 + @ptasaA/100, @pplazo) - 1)/10;
			
			
			EXEC spCreateAP @IdP = @pidP, @MontoO = @pmontoO, @Plazo = @pplazo, @Cuota = @pcuota, @Fecha = @pfecha, @TasaA = @ptasaA
			SET @minid += 1;
		END;
		

		--procesa los movimientos en los consumos de las propiedades
		DELETE @MovConsumo
		INSERT INTO @MovConsumo(NumFinca, M3, TipoMov, Descripcion,Fecha)
		SELECT	mc.value('@NumFinca', 'INT')
			,	mc.value('@LecturaM3', 'INT')
			,	mc.value('@id', 'INT')
			,	mc.value('@descripcion', 'VARCHAR(50)')
			,	@FechaOperacion AS FechaOperacion
		FROM @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia[@fecha eq sql:variable("@FechaOperacion")]/TransConsumo') AS t(mc)
		EXEC spProcesaConsumo @MovConsumo;
		
		--Realiza las cortas de agua
		EXEC spCortaAgua @FechaActual = @FechaOperacion;
	
		--Reliza las reconexiones de agua
		EXEC spReconexionAgua @FechaActual = @FechaOperacion;

		--Genera los recibos
		EXEC spProcesaRecibos @FechaActual = @FechaOperacion;

		--Genera los recibos AP
		EXEC spGeneraReciboAP @FechaActual = @FechaOperacion;

		SET @Lo1 = @Lo1 + 1;
		
	END
END
