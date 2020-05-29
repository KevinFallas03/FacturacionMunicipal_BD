using model.entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace model.dao
{
    class CCobro_MontoFijoDao : TemplateCRUD<CCobro_MontoFijoDao>
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public CCobro_MontoFijoDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public void create(CCobro_MontoFijoDao objetoCobro)
        {
            throw new NotImplementedException();
        }

        public void delete(CCobro_MontoFijoDao objetoCobro)
        {
            throw new NotImplementedException();
        }

        public bool find(CCobro_MontoFijoDao objetoCobro)
        {
            throw new NotImplementedException();
        }

        public List<CCobro_MontoFijo> findAll()
        {
            List<CCobro_MontoFijo> listaCobrosFijos = new List<CCobro_MontoFijo>();

            try
            {
                comando = new SqlCommand("spObtenerCCobroMontoFijo", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    CCobro_MontoFijo objetoCobro = new CCobro_MontoFijo();
                    objetoCobro.Nombre = read[0].ToString();
                    objetoCobro.TasaInteresesMoratorios = (float)Convert.ToDecimal(read[1].ToString());
                    objetoCobro.DiaEmisionRecibo = Convert.ToByte(read[2].ToString());
                    objetoCobro.QDiasVencimiento = Convert.ToByte(read[2].ToString());
                    objetoCobro.EsImpuesto = Convert.ToBoolean(read[3]);
                    objetoCobro.EsRecurrente = Convert.ToBoolean(read[4]);
                    objetoCobro.EsFijo = Convert.ToBoolean(read[5]);
                    objetoCobro.TipoCCobro = read[6].ToString();
                    objetoCobro.Activo = Convert.ToBoolean(read[7].ToString());
                    objetoCobro.MontoFijo = Convert.ToDecimal(read[8].ToString());
                    listaCobrosFijos.Add(objetoCobro);
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
            return listaCobrosFijos;
        }

        public void update(CCobro_MontoFijoDao objetoCobro)
        {
            throw new NotImplementedException();
        }
    }
}
