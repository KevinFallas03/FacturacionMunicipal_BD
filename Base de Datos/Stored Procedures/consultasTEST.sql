/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [sec]
  FROM [FacturacionMunicipal].[dbo].[IdRecibosPorPagar]


SELECT * 
FROM Recibo AS R 
INNER JOIN Propiedad P ON P.ID = R.IdPropiedad
WHERE R.ID = 1503

USE FacturacionMunicipal
GO
SELECT R.ID, CC.Nombre, R.Monto
FROM Recibo AS R
INNER JOIN IdRecibosPorPagar RP ON R.id = RP.sec
INNER JOIN CCobro AS CC ON R.IdCCobro = CC.ID


SELECT R.ID FROM [Recibo] R 
INNER JOIN IdRecibosPorPagar RP ON RP.sec = R.ID
WHERE 1 = RP.sec

Select RP.sec, P.ID, P.Direccion
from IdRecibosPorPagar as RP
inner join Recibo as R ON R.ID=Rp.sec
inner join Propiedad P ON P.ID=R.IdPropiedad