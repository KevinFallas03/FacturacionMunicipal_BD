using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Propiedad
    {
        private int idPropiedad; 
        private int numeroPropiedad;
        private Decimal valorPropiedad;
        private string direccionPropiedad;

        public Propiedad() {}
        public Propiedad(int pidPropiedad)
        {
            this.IdPropiedad = pidPropiedad;
        }
        public Propiedad(int pIdPropiedad, int pNumeroPropiedad, Decimal pValorPropiedad, string pDireccionPropiedad)
        {
            this.IdPropiedad = pIdPropiedad;
            this.NumeroPropiedad = pNumeroPropiedad;
            this.ValorPropiedad = pValorPropiedad;
            this.DireccionPropiedad = pDireccionPropiedad;
        }

        //Getters and Setters

        public int IdPropiedad { get => idPropiedad; set => idPropiedad = value; }
        public int NumeroPropiedad { get => numeroPropiedad; set => numeroPropiedad = value; }
        public Decimal ValorPropiedad { get => valorPropiedad; set => valorPropiedad = value; }
        public string DireccionPropiedad { get => direccionPropiedad; set => direccionPropiedad = value; }
    }
}
