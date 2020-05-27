using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Propiedad
    {
        private int ID; 
        private int numeroPropiedad;
        private Decimal valorPropiedad;
        private string direccionPropiedad;

        public Propiedad() {}
        public Propiedad(int pID)
        {
            this.ID = pID;
        }
        public Propiedad(int pNumeroPropiedad, Decimal pValorPropiedad, string pDireccionPropiedad)
        {
            this.NumeroPropiedad = pNumeroPropiedad;
            this.ValorPropiedad = pValorPropiedad;
            this.DireccionPropiedad = pDireccionPropiedad;
        }

        //Getters and Setters

        public int NumeroPropiedad { get => numeroPropiedad; set => numeroPropiedad = value; }
        public Decimal ValorPropiedad { get => valorPropiedad; set => valorPropiedad = value; }
        public string DireccionPropiedad { get => direccionPropiedad; set => direccionPropiedad = value; }
    }
}
