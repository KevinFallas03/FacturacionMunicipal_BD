using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using model.entity;

namespace model.dao
{
    public class BitacoraDao
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public BitacoraDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public bool find(Bitacora objetoBitacora)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerBitacora", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoBitacora.IdBitacora);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objetoBitacora.IdBitacora = Convert.ToInt32(read[0].ToString());
                    objetoBitacora.Fecha = Convert.ToString(read[1].ToString()).Split(' ')[0];
                    objetoBitacora.Hora = Convert.ToString(read[1].ToString()).Split(' ')[1];
                    objetoBitacora.Usuario = read[2].ToString();
                    objetoBitacora.Ip = read[3].ToString();
                    objetoBitacora.IdTipo = Convert.ToInt32(read[4].ToString());
                    objetoBitacora.IdEntidad = Convert.ToInt32(read[5].ToString());
                    objetoBitacora.Jsonantes = read[6].ToString();
                    objetoBitacora.Jsondespues = read[7].ToString();
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
            return hayRegistros;
        }

        public List<Bitacora> findAll()
        {
            List<Bitacora> listaBitacora = new List<Bitacora>();

            try
            {
                comando = new SqlCommand("spObtenerBitacora", objConexion.getConexion())
                {
                    CommandType = CommandType.StoredProcedure
                };
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Bitacora objetoBitacora = new Bitacora
                    {
                        IdBitacora = Convert.ToInt32(read[0].ToString()),
                        Fecha = Convert.ToString(read[1].ToString()).Split(' ')[0],
                        Hora = Convert.ToString(read[1].ToString()).Split(' ')[1]
                    };
                    listaBitacora.Add(objetoBitacora);
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
            return listaBitacora;
        }
    }
}
