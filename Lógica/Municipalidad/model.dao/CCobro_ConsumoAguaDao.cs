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
    class CCobro_ConsumoAguaDao : TemplateCRUD<CCobro_ConsumoAgua>
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public CCobro_ConsumoAguaDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public void create(CCobro_ConsumoAgua objeto)
        {
            throw new NotImplementedException();
        }

        public void delete(CCobro_ConsumoAgua objeto)
        {
            throw new NotImplementedException();
        }

        public bool find(CCobro_ConsumoAgua objeto)
        {
            throw new NotImplementedException();
        }

        public List<CCobro_ConsumoAgua> findAll()
        {
            List<CCobro_ConsumoAgua> listaCobrosConsumoAgua = new List<CCobro_ConsumoAgua>();

            try
            {
                comando = new SqlCommand("spObtenerCCobroConsumoAgua", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    CCobro_ConsumoAgua objetoCobro = new CCobro_ConsumoAgua();
                    objetoCobro.Nombre = read[0].ToString();
                    objetoCobro.TasaInteresesMoratorios = Convert.ToDecimal(read[1].ToString());
                    objetoCobro.DiaEmisionRecibo = Convert.ToByte(read[2].ToString());
                    objetoCobro.QDiasVencimiento = Convert.ToByte(read[2].ToString());
                    objetoCobro.EsImpuesto = Convert.ToBoolean(read[3]);
                    objetoCobro.EsRecurrente = Convert.ToBoolean(read[4]);
                    objetoCobro.EsFijo = Convert.ToBoolean(read[5]);
                    objetoCobro.TipoCCobro = read[6].ToString();
                    objetoCobro.Activo = Convert.ToBoolean(read[7].ToString());
                    objetoCobro.Consumo3 = Convert.ToInt32(read[8].ToString());
                    listaCobrosConsumoAgua.Add(objetoCobro);
                }
            }

            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
            return listaCobrosConsumoAgua;
        }

        public void update(CCobro_ConsumoAgua objeto)
        {
            throw new NotImplementedException();
        }
    }
}
