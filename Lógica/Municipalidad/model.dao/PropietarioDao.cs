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
    public class PropietarioDao : TemplateCRUD<Propietario>
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public PropietarioDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public void create(Propietario objetoPropietario)
        {
            try
            {
                comando = new SqlCommand("spInsertarPropietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Nombre", objetoPropietario.Nombre);
                comando.Parameters.AddWithValue("@IdTipoDocumento", objetoPropietario.TipoDocumento);
                comando.Parameters.AddWithValue("@ValorDocumento", objetoPropietario.ValorDocumentoId);
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

        public void update(Propietario objetoPropietario)
        {

        }

        public void delete(Propietario objetoPropietario)
        {
            
        }

        public bool find(Propietario objetoPropietario)
        {
            bool existenRegistros;
            try
            {
                comando = new SqlCommand("[dbo].[ObtenerPropietariosSP]", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                existenRegistros = read.Read();
                if (existenRegistros)
                {
                    objetoPropietario.Nombre = read[0].ToString();
                    objetoPropietario.TipoDocumento = Convert.ToInt32(read[1].ToString());
                    objetoPropietario.ValorDocumentoId = read[2].ToString();

                    objetoPropietario.EstadoError = 99;
                }
                else
                {
                    objetoPropietario.EstadoError = -99;
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
            return existenRegistros;
        }

        public List<Propietario> findAll()
        {
            List < Propietario > listaPropietarios = new List<Propietario>();

            try
            {
                comando = new SqlCommand("spObtenerPropietarios", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propietario objetoPropietario = new Propietario();
                    objetoPropietario.Nombre = read[0].ToString();
                    objetoPropietario.TipoDocumento = Convert.ToInt32(read[1].ToString());
                    objetoPropietario.ValorDocumentoId = read[2].ToString();
                    listaPropietarios.Add(objetoPropietario);
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
            return listaPropietarios;
        }
    }
}
