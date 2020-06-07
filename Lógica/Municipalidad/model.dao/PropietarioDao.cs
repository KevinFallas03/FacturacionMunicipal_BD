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
        private static int IDPJ=0;

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
                SqlDataReader read = comando.ExecuteReader();
                if (read.Read())
                {
                    IDPJ = Convert.ToInt32(read[0].ToString());
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
        }

        public void createresponsable(Propietario Propietario, PropietarioJuridico Responsable)
        {
            create(Propietario);
            try
            {
                comando = new SqlCommand("spInsertarPropietario_Jud", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", IDPJ);
                comando.Parameters.AddWithValue("@Nombre", Responsable.PersonaResponsable);
                comando.Parameters.AddWithValue("@IdTipoDocumento", Responsable.TipoDocumento);
                comando.Parameters.AddWithValue("@ValorDocumento", Responsable.ValorDocumentoId);
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

        public bool responsable(PropietarioJuridico objpropietario)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerPropietario_Jud", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objpropietario.IdPropietario);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objpropietario.IdPropietario = Convert.ToInt32(read[0].ToString());
                    objpropietario.Nombre = read[1].ToString();
                    objpropietario.TipoDocumento = Convert.ToInt32(read[2].ToString());
                    objpropietario.ValorDocumentoId = read[3].ToString();
                    objpropietario.EstadoError = 99;
                }
                else
                {
                    objpropietario.EstadoError = 1;
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

        public void update(Propietario objPropietario)
        {
            try
            {
                comando = new SqlCommand("spEditarPropietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", objPropietario.IdPropietario);
                comando.Parameters.AddWithValue("@Nombre", objPropietario.Nombre);
                comando.Parameters.AddWithValue("@IdTipoDocumento", objPropietario.TipoDocumento);
                comando.Parameters.AddWithValue("@ValorDocumento", objPropietario.ValorDocumentoId);
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

        public void delete(Propietario objetoPropietario)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogPropietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoPropietario.IdPropietario);
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

        public bool find(Propietario objpropietario)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerPropietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objpropietario.IdPropietario);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objpropietario.IdPropietario = Convert.ToInt32(read[0].ToString());
                    objpropietario.Nombre = read[1].ToString();
                    objpropietario.TipoDocumento = Convert.ToInt32(read[2].ToString());
                    objpropietario.ValorDocumentoId = read[3].ToString();
                    objpropietario.EstadoError = 99;
                } 
                else
                {
                    objpropietario.EstadoError = 1;
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
                    Propietario objetoPropietario = new Propietario
                    {
                        IdPropietario = Convert.ToInt32(read[0].ToString()),
                        Nombre = read[1].ToString(),
                        TipoDocumento = Convert.ToInt32(read[2].ToString()),
                        ValorDocumentoId = read[3].ToString()
                    };
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

        public List<Propiedad> findAllPropiedades(int ID)

        {
            List<Propiedad> listaPropietarios = new List<Propiedad>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerPropiedades_Propietarios", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", ID);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propiedad objetoPropiedad = new Propiedad
                    {
                        IdPropiedad = Convert.ToInt32(read[0].ToString()),
                        NumeroPropiedad = Convert.ToInt32(read[1].ToString()),
                        ValorPropiedad = Convert.ToDecimal(read[2].ToString()),
                        DireccionPropiedad = read[3].ToString(),
                    };
                    listaPropietarios.Add(objetoPropiedad);
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

        public List<Propiedad> findAllPropiedadesIngresado(string valorIngresado)
        {
            List<Propiedad> listaPropietarios = new List<Propiedad>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerPropiedades_Propietarios_Ingresado", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ingresado", valorIngresado);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propiedad objetoPropiedad = new Propiedad
                    {
                        IdPropiedad = Convert.ToInt32(read[0].ToString()),
                        NumeroPropiedad = Convert.ToInt32(read[1].ToString()),
                        ValorPropiedad = Convert.ToDecimal(read[2].ToString()),
                        DireccionPropiedad = read[3].ToString(),
                    };
                    listaPropietarios.Add(objetoPropiedad);
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

        public void deletePropiedad(int ID)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogPropiedad_Propietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", ID);
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

        public List<Propiedad> createPropiedad(int id)
        {
            List<Propiedad> listaPropiedades = new List<Propiedad>();
            try
            {
                comando = new SqlCommand("spObtenerPropiedades_SinPropietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propiedad objetoPropiedad = new Propiedad
                    {
                        IdPropiedad = Convert.ToInt32(read[0].ToString()),
                        NumeroPropiedad = Convert.ToInt32(read[1].ToString()),
                        ValorPropiedad = Convert.ToDecimal(read[2].ToString()),
                        DireccionPropiedad = read[3].ToString(),
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

        public void createPropiedad(int idPropietario, int idPropiedad)
        {
            try
            {
                comando = new SqlCommand("spCreatePropiedad_Propietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idPropietario", idPropietario);
                comando.Parameters.AddWithValue("@idPropiedad", idPropiedad);
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
            return;
        }
    }
}
