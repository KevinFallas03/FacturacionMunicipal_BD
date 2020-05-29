using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class PropietarioJuridico : Propietario
    {
        private string personaResponsable;
        private int idTipoDocumento;
        private string valorDocumento;

        public PropietarioJuridico() { }

        public string PersonaResponsable { get => personaResponsable; set => personaResponsable = value; }
        public int IdTipoDocumento { get => idTipoDocumento; set => idTipoDocumento = value; }
        public string ValorDocumento { get => valorDocumento; set => valorDocumento = value; }
    }
}
