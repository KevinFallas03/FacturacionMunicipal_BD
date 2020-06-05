--parte 1

		-- procesar nodos propietarios juridicos
		delete @PropJuridico 
		insert @PropJuridico(sec, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		select --ID VALUE
		 pd.value('@Nombre', 'VARCHAR(100)')
		, pd.value('@DocidRepresentante', 'VARCHAR(100)')
		, pd.value('@TipDocIdRepresentante', 'INT')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Propiedad') AS t(pd)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		--iteramos en propietarios juridicos
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropJuridico
		while @Lo2<=@Hi2
		Begin
		   insert dbo.PropietarioJuridico(ID, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		   Select Pj.sec, Pj.NombrePersonaResponsable, Pj.IdTipoDocumento, Pj.ValorDocumento ,Pj.EstaBorrado from @PropJuridico Pj where sec=@Lo1
		   Set @Lo2=@Lo2+1
		end

		-- procesar nodos PropietarioxPropiedad
		delete @PropiedadVsPropietario
		insert @PropiedadVsPropietario (IdPropiedad, IdPropietario, EstaBorrado)
		select pp.value('@NumFinca', 'INT')
		, pp.value('@identificacion', 'INT')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario') AS t(pp)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		--iteramos en PropiedadXPropietario
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropiedadVsPropietario
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Prop_Prop(IdPropiedad, IdPropietario, EstaBorrado)
		   Select PP.IdPropiedad, PP.IdPropietario, PP.EstaBorrado from @PropiedadVsPropietario PP where sec=@Lo1
		   Set @Lo2=@Lo2+1
		end

		--procesar nodos CCobroVsPropiedad
		delete @PropiedadesxCCobro 
		insert @PropiedadesxCCobro (IdCCobro, IdPropiedad, FechaInic, FechaFin)-- revisar ultimo atributo 
		select pc.value('@idcobro','INT') --buscar el id de ese valor
		, pc.value('@NumFinca', 'INT') --buscar el id de ese valor
		, @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') as FechaInic --posible error
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/ConceptoCobroVersusPropiedad') AS t(pc)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

	   -- iteramos en CCobroVsPropiedad
		Select @Lo1=@minfecha, @Hi1=@maxfecha -- revisar asignacion de fechas
		from @PropiedadesxCCobro

		while @Lo2<=@Hi2
		Begin
		   insert dbo.CCobro_PNP(IdCCobbro, IdPropiedad, FechaInic)
		   Select PC.IdCCobro, PC.IdPropiedad, @FechaOperacion 
		   from @PropiedadesxCCobro PC
		   where sec=@Lo1 and PC.IdCCobro=PC.IdCCobro   --REVISAR -- el id del propietario se mapea a traves del ValorDocid
		   Set @Lo2=@Lo2+1
		end

		--parte 2

		--insertamos Usuarios x Propiedad
		delete @UsuarioVersusPropiedad
		insert @UsuarioVersusPropiedad (IdPropiedad, IdUsuario, EstaBorrado)
		select pp.value('@NumFinca', 'INT') --REVISAR, encontrar la ID de ese valor
		, pp.value('@nombreUsuario', 'VARCHAR(100)') --Revisar, ""
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario') AS t(pp)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		
		-- iteramos en Usuarios x Propiedad
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @UsuarioVersusPropiedad
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Usuario_Prop(IdPropiedad, IdUsuario, EstaBorrado)
		   Select UP.IdPropiedad, UP.IdUsuario, UP.EstaBorrado from @UsuarioVersusPropiedad UP where sec=@Lo1
		   Set @Lo2=@Lo2+1
		end

		Set @Lo1= @Lo1+1

		

		