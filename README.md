# FacturacionMunicipal_BD
## Facturación de servicios y recolección de impuestos en una municipalidad. 

###  Descripción 
La municipalidad ofrece servicios de proveer agua, recolectar basura, mantenimiento de
parques, y además recolecta impuestos a la propiedad y a las patentes. Los servicios se pagan
mensualmente. Los impuestos, aunque su valor se calcula anualmente, se pagan en 4 tractos
trimestrales: en marzo, junio, setiembre y diciembre.

Hay otros servicios que se pagan de manera no recurrente, por ejemplo: reconexión de agua,
cuotas de un arreglo de pago sobre una deuda con la municipalidad, y otros conceptos. Para el
cobro de estos servicios, un usuario de la municipalidad ingresa estos conceptos para que sean
pagados por un ciudadano específico.

Un propietario puede ser una persona física, o una persona jurídica, y puede ser dueño de una
o varias propiedades en el municipio, los cuales pagan los impuestos y servicios recurrentes. Si
un propietario es una persona jurídica, por ejemplo, una empresa, también existirá una persona
física que es el apoderado o representante de la persona jurídica.

Cada propiedad, tiene asociado un estado de cuenta, en el cual se pueden visualizar todos los
servicios e impuestos ya pagados, o aquellos que están pendientes de pago.
A través de un portal web portal web de la municipalidad, un usuario podrá consultar los
estados de cuenta de cada una de sus propiedades, aquellas de las que es dueño, o las
propiedades cuyo dueño son personas jurídicas donde el usuario es apoderado.

Para pagar, el usuario visita el portal, selecciona una propiedad, y luego el estado de cuenta,
que son los despliega los servicios pendientes de pago en orden cronológico del más viejo al
más nuevo. Cada ítem del estado de cuenta muestra, fecha del ‘recibo’, concepto (nombre del
servicio o impuesto), monto, fecha de vencimiento, y monto de los intereses moratorios. Los
intereses moratorios serán mayores a cero, si la fecha actual es mayor a la fecha de
vencimiento del ítem. Se muestra un total de todo lo pendiente, la cantidad de ítem pendientes
y el monto total de los intereses moratorios.

El usuario selecciona aquellos ítemes (que también podemos llamar recibos) que quiera pagar,
teniendo en cuenta que el sistema NO permitirá pagar un mes referido a un servicio, por
ejemplo, agua; si algunos de los meses anteriores al mes que se desea pagar está pendiente o
no está seleccionado. 

Todo servicio, tiene una fecha del “recibo” y una fecha vencimiento. Para cada servicio, se tiene
el día del mes que se pone al cobro, se tiene una cantidad de días para pagar antes de vencer,
y la tasa anual de intereses moratorios si el propietario paga después de la fecha de
vencimiento. Por ejemplo, para el servicio de agua, la fecha del recibo serán los 5 del mes, la
cantidad de días para que el recibo venza son 15, entonces el recibo se emite los 5 y debe
pagarse antes los 20 de cada mes. La fecha del recibo refiere al servicio del mes previo,
ejemplo: el “recibo” de agua del 5 de diciembre, es el recibo por el servicio de agua de
noviembre. Si el usuario pagó luego del 20 de diciembre, se cobran intereses moratorios.

Para el cobro de los intereses moratorios, se genera un nuevo recibo, ligado un concepto
llamados “Intereses Moratorios”, y en la descripción debe indicar, “Intereses Moratorios de
recibo por <Concepto de Cobro del recibo que generó los intereses moratorios> de fecha
<fecha del recibo que genera intereses moratorios>”.
  
El impuesto a la propiedad es de 0.5% del valor declarado de la propiedad. Los valores para
patentes, recolección de basura, mantenimiento de parques y reconexión de agua, son
atributos del tipo de servicio.

Hay 2 tipos de usuario, el usuario propietario, del cual ya hablamos y el usuario administrador,
que ingresa a un portal en el cual puede hacer crud de las entidades principales, las cuales
son:

- Propietarios
- Propiedades
- Asociación de propietarios con propiedades (Puede consultar las propiedades de un
propietario, o para una propiedad su propietarios)
- Usuarios
- Asociación de usuarios con propiedades. (Puede consultar las propiedades que puede
ver un usuario: o, para una propiedad, quiénes son sus usuarios)
- Servicios o impuestos.
- Un usuario administrador puede ver todas las propiedades y propietarios.

