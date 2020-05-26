using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Propietario
    {
        //Atributos de la clase
        private int idPropietario;
        private string nombre;
        private int tipoDocumento;
        private string valorDocumentoId;
        //estado para controlar los errores
        private int estadoError;


        //Constructores
        public Propietario() {} // mapeo

        public Propietario(int pIdPropietario) // primary key
        {
            this.IdPropietario = pIdPropietario;
        }

        public Propietario(int pIdPropietario, string pNombre, int pTipoDocumento, string pValorDocumentoId)
        {
            this.IdPropietario = pIdPropietario;
            this.Nombre = pNombre;
            this.TipoDocumento = pTipoDocumento;
            this.ValorDocumentoId = pValorDocumentoId;
        }

        //Getters and Setters
        public int IdPropietario { get => idPropietario; set => idPropietario = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public int TipoDocumento { get => tipoDocumento; set => tipoDocumento = value; }
        public string ValorDocumentoId { get => valorDocumentoId; set => valorDocumentoId = value; }
        public int EstadoError { get => estadoError; set => estadoError = value; }

        
    }
}
