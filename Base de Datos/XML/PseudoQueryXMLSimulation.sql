
--- SCRIPT DE SIMULACION PARA LA TAREA PROGRAMADA

-- precondición, los nodos para la fecha de operación en el XML vienen en orden ascendente.

Declare @propietarios table 
(
   sec int identity(1,1) primary key, 
   TipoDocId int, 
   Nombre varchar(100)
)

declare @FechaOperacion date

-- se extraen fechas operación
Declare @FechasAProcesar table 
(
   sec int identity(1,1) primary key, 
   fecha date
) 
insert @FechasAProcesar (fecha)
select <nombre campo fecha de nodo fechaoperacion del archivo XML>
from <extracion del nodo fecha operacion del archivo XML>

-- Variables para controlar la iteración
declare @Lo1 int, @Hi1 int, @Lo2 int, @Hi2 int
declare @minfecha datetime, @maxfecha datetime, 

-- variables que almacenan valor constante para controlar emision masiva de recibos

Declare @IdCCobro_ConsumoAgua=1, @IdCCobro_PatenteCantina=7   -- Son ids con valores solo de ejemplo
-- iterando de la fecha más antigua a la menos antigua

Select @minfecha=min(F.fecha), @maxfecha=max(F.fecha)  -- min y max son funciones agregadas
from @FechasAProcesar F

select @Lo1=F.sec
from @FechasAProcesar F
where F.Fecha=@minfecha

select @Hi1=F.sec
from @FechasAProcesar F
where F.Fecha=@maxfecha


-- iteramos por fecha
while @Lo1<=@Hi1
Begin
    Select @FechaOperacion=F.Fecha from @FechasAProcesar F where sec=@Lo1

 -- procesar nodos propietario
    delete @propietarios  
    insert @propietarios (TipoDocId, Nombre, ValorDocId)
    select <nombre campo TipoDocId de nodo Propietario del archivo XML>, <nombre ValorDocId fecha de nodo Propietario del archivo XML>,
          <nombre campo ValorDocId de nodo Propietario)del archivo XML>
    from <extracion de nodo propietarios del archivo XML>
    where <fechaoperacion en nodo fecha=@FechaOperacion>

   -- iteramos en propietarios
    Select @Lo2=min(sec), @Hi2=max(sec)
    from @propietarios
    while @Lo2<=@Hi2
    Begin
       insert dbo.propietarios (TipoDocId, Nombre, ValorDocId, FechaInsercion)
       Select P.TipoDocId, P.Nombre, P.ValorDocId, @FechaOperacion from @Propietarios P where sec=@Lo1
       Set @Lo2=@Lo2+1
    end

 -- procesar nodos PropietarioxCCobro
    delete @propietariosxCCobro  
    insert @propietariosxCCobro (IdCCobro, ValorDocIdPropietario)
    select <nombre campo TipoDocId de nodo PropietarioxCCobro del archivo XML>, <nombre ValorDocId fecha de nodo Propietario del archivo XML>,
          <nombre campo ValorDocId de nodo PropietarioxCCobro )del archivo XML>
    from <extracion de nodo PropietarioxCCobro del archivo XML>
    where <fechaoperacion en nodo fecha=@FechaOperacion>

   -- iteramos en PropietarioxCCobro
    Select @Lo1=min(fecha), @Hi1=max(fecha)
    from @propietariosxCCobro

    while @Lo2<=@Hi2
    Begin
       insert dbo.PropietarioxCCobro (IdCCobro, IdPropietario, FechaInsercion)
       Select P.IdCCobro, Pr.Id, @FechaOperacion 
       from @propietariosxCCobro Pr dbo.Propieatarios Pr 
       where sec=@Lo1 and P.ValorDocId=P.ValorDocId    -- el id del propietario se mapea a traves del ValorDocid
       Set @Lo2=@Lo2+1
    end

    -- iteramos en PropietariosJuridicos
    -- ....
    -- iteramos en Usuarios
    -- ....
    -- iteramos en Usuarios x Propiedad
    -- ....

   -- proceso masivo consumo agua
   If exists (Select 1 from dbo.CCobro where A.Id=@IdCCobro_ConsumoAgua and A.DiaRecibo=datepart(d, @FechaOperacion))
   Begin
      -- codigo de generacion de recibos de agua
   end 

   -- proceso masivo cobro de patentes de cantinas, 
   If exists (Select 1 from dbo.CCobro where A.Id=@IdCCobro_PatenteCantina and A.DiaRecibo=datepart(d, @FechaOperacion))
   Begin
      -- codigo de generacion de recibos de patentes de cantinda
   end

   -- proceso masivo cobro de recoleccion de basura
   ....
   -- ....

   -- el proceso de emision de recibos puede ser mas generico, con codigo mas mantenible
	

	Set @Lo1=Lo1+1
end