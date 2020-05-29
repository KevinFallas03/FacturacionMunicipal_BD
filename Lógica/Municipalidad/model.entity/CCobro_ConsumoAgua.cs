using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class CCobro_ConsumoAgua : CCobro
    {
        private int ConsumoM3;
        public CCobro_ConsumoAgua() { }
        public int Consumo3 { get => ConsumoM3; set => ConsumoM3 = value; }
    }
}
