using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using model.entity;

namespace model.dao
{
    public class PropiedadDao : TemplateCRUD<Propiedad>
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public PropiedadDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public void create(Propiedad objetoPropiedad)
        {
            try
            {
                comando = new SqlCommand("spInsertarPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@NumFinca", objetoPropiedad.NumeroPropiedad);
                comando.Parameters.AddWithValue("@Valor", objetoPropiedad.ValorPropiedad);
                comando.Parameters.AddWithValue("@Direccion", objetoPropiedad.DireccionPropiedad);
                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
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
        }

        public void delete(Propiedad objetoPropiedad)
        {
            throw new NotImplementedException();
        }

        public bool find(Propiedad objetoPropiedad)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoPropiedad.IdPropiedad);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objetoPropiedad.IdPropiedad = Convert.ToInt32(read[0].ToString());
                    objetoPropiedad.NumeroPropiedad = Convert.ToInt32(read[1].ToString());
                    objetoPropiedad.ValorPropiedad = Convert.ToDecimal(read[2].ToString());
                    objetoPropiedad.DireccionPropiedad = read[3].ToString();
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

        public List<Propiedad> findAll()
        {
            List<Propiedad> listaPropiedades = new List<Propiedad>();

            try
            {
                comando = new SqlCommand("spObtenerPropiedades", objConexion.getConexion())
                {
                    CommandType = CommandType.StoredProcedure
                };
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propiedad objetoPropiedad = new Propiedad
                    {
                        IdPropiedad = Convert.ToInt32(read[0].ToString()),
                        NumeroPropiedad = Convert.ToInt32(read[1].ToString()),
                        ValorPropiedad = Convert.ToDecimal(read[2].ToString()),
                        DireccionPropiedad = read[3].ToString()
                    };
                    listaPropiedades.Add(objetoPropiedad);
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
            return listaPropiedades;
        }

        public void update(Propiedad objetoPropiedad)
        {
            try
            {
                comando = new SqlCommand("spEditarPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", objetoPropiedad.IdPropiedad);
                comando.Parameters.AddWithValue("@NumFinca", objetoPropiedad.NumeroPropiedad);
                comando.Parameters.AddWithValue("@Valor", objetoPropiedad.ValorPropiedad);
                comando.Parameters.AddWithValue("@Direccion", objetoPropiedad.DireccionPropiedad);
                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
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
        }
    }
}
