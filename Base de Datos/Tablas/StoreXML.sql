DECLARE @docId xml
 
SELECT @docId = DI
FROM OPENROWSET (BULK 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\TipoDocumentoIdentidad.xml', SINGLE_BLOB) AS DocID(DI)
    
SELECT @docId
    
DECLARE @hdoc int
    
EXEC sp_xml_preparedocument @hdoc OUTPUT, @docId
SELECT *
FROM OPENXML (@hdoc, '/TipoDocIdentidad/TipoDocId' , 1)
WITH(
    codigoDoc VARCHAR(100),
	descripcion VARCHAR(100)
    )
    
EXEC sp_xml_removedocument @hdoc