using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class CCobro_MontoFijo : CCobro
    {
        private Decimal montoFijo;
       public CCobro_MontoFijo(){}

        public decimal MontoFijo { get => montoFijo; set => montoFijo = value; }
    }
}
