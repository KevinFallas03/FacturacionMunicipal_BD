using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public abstract class CCobro
    {
        protected int iD;
        protected string nombre;
        protected Decimal tasaInteresesMoratorios;
        protected byte diaEmisionRecibo;// tipo tinyint
        protected byte qDiasVencimiento;
        protected bool esImpuesto;
        protected bool esRecurrente;
        protected bool esFijo;
        protected string tipoCCobro;
        protected bool activo;

        public CCobro() { }
        public CCobro(int pID, string pNombre, Decimal pTasaInteresesMoratorios, byte pDiaEmisionRecibo,
                      byte pQDiasVencimiento, bool pEsImpuesto, bool pEsRecurrente, bool pEsFijo,
                      string pTipoCCobro, bool pActivo)
        {
            this.ID = pID;
            this.tasaInteresesMoratorios = pTasaInteresesMoratorios;
            this.diaEmisionRecibo = pDiaEmisionRecibo;
            this.QDiasVencimiento = pQDiasVencimiento;
            this.EsImpuesto = pEsImpuesto;
            this.EsRecurrente = pEsRecurrente;
            this.EsFijo = pEsFijo;
            this.Activo = pActivo;
        }

        public CCobro(int pId) { this.ID = pId; } //revisar si es necesario
        //getters and setters
        public int ID { get => iD; set => iD = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public Decimal TasaInteresesMoratorios { get => tasaInteresesMoratorios; set => tasaInteresesMoratorios = value; }
        public byte DiaEmisionRecibo { get => diaEmisionRecibo; set => diaEmisionRecibo = value; }
        public byte QDiasVencimiento { get => qDiasVencimiento; set => qDiasVencimiento = value; }
        public bool EsImpuesto { get => esImpuesto; set => esImpuesto = value; }
        public bool EsRecurrente { get => esRecurrente; set => esRecurrente = value; }
        public bool EsFijo { get => esFijo; set => esFijo = value; }
        public string TipoCCobro { get => tipoCCobro; set => tipoCCobro = value; }
        public bool Activo { get => activo; set => activo = value; }
    }
}
