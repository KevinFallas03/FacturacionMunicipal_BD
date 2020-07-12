using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Recibo
    {
        //Atributos de la clase
        private int idRecibo; //pk
        private int idPropiedad;
        private int numFinca;
        private int idCCobro;
        private string nombreCC;
        private decimal monto;
        private Boolean estado;
        private string fechaEm;
        private string fechaMx;

        //Constructores
        public Recibo() { } // mapeo

        public Recibo(int pIdRecibo) // primary key
        {
            this.idRecibo = pIdRecibo;
        }

        public Recibo(int pIdRecibo, int pIdPropiedad, int pnumFinca, 
            int pIdCCobro, string pnombreCC, decimal pmonto, 
            Boolean pestado, string pfechaEm, string pfechaMx)
        {
            this.idRecibo = pIdRecibo;
            this.idPropiedad = pIdPropiedad;
            this.numFinca = pnumFinca;
            this.idCCobro = pIdCCobro;
            this.nombreCC = pnombreCC;
            this.monto = pmonto;
            this.estado = pestado;
            this.fechaEm = pfechaEm;
            this.fechaMx = pfechaMx;
    }

        //Getters and Setters
        public int IdRecibo { get => idRecibo; set => idRecibo = value; }
        public int IdPropiedad { get => idPropiedad; set => idPropiedad = value; }
        public int NumFinca { get => numFinca; set => numFinca = value; }
        public int IdCCobro { get => idCCobro; set => idCCobro = value; }
        public string NombreCC { get => nombreCC; set => nombreCC = value; }
        public decimal Monto { get => monto; set => monto = value; }
        public Boolean Estado { get => estado; set => estado = value; }
        public string FechaEm { get => fechaEm; set => fechaEm = value; }
        public string FechaMx { get => fechaMx; set => fechaMx = value; }
    }
}
