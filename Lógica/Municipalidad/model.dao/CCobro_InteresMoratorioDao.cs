using model.entity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.dao
{
    public class CCobro_InteresMoratorioDao : TemplateCRUD<CCobro_InteresMoratorio>
    {
        private Conexion objConexion;
        private SqlCommand comando;
        public CCobro_InteresMoratorioDao() { }

        public void create(CCobro_InteresMoratorio objeto)
        {
            throw new NotImplementedException();
        }

        public void delete(CCobro_InteresMoratorio objeto)
        {
            throw new NotImplementedException();
        }

        public bool find(CCobro_InteresMoratorio objeto)
        {
            throw new NotImplementedException();
        }

        public List<CCobro_InteresMoratorio> findAll()
        {
            List<CCobro_InteresMoratorio> listaCobrosInteresMoratorio = new List<CCobro_InteresMoratorio>();

            try
            {
                comando = new SqlCommand("spObtenerCCobroInteresMoratorio", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    CCobro_InteresMoratorio objetoCobro = new CCobro_InteresMoratorio();
                    objetoCobro.Nombre = read[0].ToString();
                    objetoCobro.TasaInteresesMoratorios = (float)Convert.ToDecimal(read[1].ToString());
                    objetoCobro.DiaEmisionRecibo = Convert.ToByte(read[2].ToString());
                    objetoCobro.QDiasVencimiento = Convert.ToByte(read[2].ToString());
                    objetoCobro.EsImpuesto = Convert.ToBoolean(read[3]);
                    objetoCobro.EsRecurrente = Convert.ToBoolean(read[4]);
                    objetoCobro.EsFijo = Convert.ToBoolean(read[5]);
                    objetoCobro.TipoCCobro = read[6].ToString();
                    objetoCobro.Activo = Convert.ToBoolean(read[7].ToString());
                    objetoCobro.ValorPorcentual = Convert.ToDecimal(read[8].ToString());
                    listaCobrosInteresMoratorio.Add(objetoCobro);
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
            return listaCobrosInteresMoratorio;
        }

        public void update(CCobro_InteresMoratorio objeto)
        {
            throw new NotImplementedException();
        }
    }
}
