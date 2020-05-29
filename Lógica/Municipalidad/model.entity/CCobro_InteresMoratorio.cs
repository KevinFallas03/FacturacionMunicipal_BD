using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class CCobro_InteresMoratorio : CCobro
    {
        private Decimal valorPorcentual;

        public CCobro_InteresMoratorio() { }

        public Decimal ValorPorcentual { get => valorPorcentual; set => valorPorcentual = value; }
    }
}
