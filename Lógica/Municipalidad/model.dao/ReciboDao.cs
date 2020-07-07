using model.entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.dao 
{
    public class ReciboDao
    {
        private Conexion objConexion;
        private SqlCommand comando;
        private static int IDPJ = 0;

        ReciboDao()
        {
            objConexion = Conexion.saberEstado();
        }
    }
}
