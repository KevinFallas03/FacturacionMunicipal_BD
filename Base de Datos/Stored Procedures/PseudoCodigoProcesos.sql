-- PSEUDOCODIGO PARA PROCESAR PAGOS

		/*
		Extraer en una variable table los pagos del dia, @PagosHoy

		-- en algun lado un 
		declare @PagosHoy table (id int identity Primary Key, NumFinca int, IdTipoRecibo int)

		INSERT @PagosHoy (NumFinca, IdTipoRecibo)
		select ph.value('@NumFinca', 'INT')
			, ph.value('idTipoRecibo', 'INT')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PagoRecibo') AS t(ph)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		
		EXEC SP_PROCESACAMBIOVALORPROPIEDAD ... se le envia la tabla con la info

		EXEC SP_PROCESAPAGOS ... (se le envia @PagosHoy) --ES ATOMICO, se usa transact

		EXEC SP_PROCESACONSUMO ... se le envia la tabla con la info

		EXEC SP_ProcesaCortes ... se le envia la tabla con la info

		EXEC SP_ProcesaReconexion ... se le envia la tabla con la info

		EXEC_SP_GeneraRecibos*/


		
		*/