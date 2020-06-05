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
    public class UsuarioDao : TemplateCRUD<Usuario>
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public UsuarioDao()
        {
            objConexion = Conexion.saberEstado();
        }
        public void create(Usuario objetoUsuario)
        {
            try
            {
                comando = new SqlCommand("spInsertarUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Nombre", objetoUsuario.NombreUsuario);
                comando.Parameters.AddWithValue("@Password", objetoUsuario.Password);
                comando.Parameters.AddWithValue("@TipoUsuario", objetoUsuario.TipoUsuario);
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

        public void update(Usuario objUsuario)
        {
            try
            {
                comando = new SqlCommand("spEditarUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", objUsuario.IdUsuario);
                comando.Parameters.AddWithValue("@Nombre", objUsuario.NombreUsuario);
                comando.Parameters.AddWithValue("@Password", objUsuario.Password);
                comando.Parameters.AddWithValue("@TipoUsuario", objUsuario.TipoUsuario);
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

        public void delete(Usuario objetoUsuario)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoUsuario.IdUsuario);
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

        public void deletePropiedad(int ID)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogPropiedad_Usuario", objConexion.getConexion());
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

        public bool find(Usuario objetoUsuario)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoUsuario.IdUsuario);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objetoUsuario.IdUsuario = Convert.ToInt32(read[0].ToString());
                    objetoUsuario.NombreUsuario = read[1].ToString();
                    objetoUsuario.Password = read[2].ToString();
                    objetoUsuario.TipoUsuario = read[3].ToString();
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

        public List<Usuario> findAll()
        {
            List<Usuario> listaUsuarios = new List<Usuario>();

            try
            {
                comando = new SqlCommand("spObtenerUsuarios", objConexion.getConexion())
                {
                    CommandType = CommandType.StoredProcedure
                };
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Usuario objetoUsuario = new Usuario
                    {
                        IdUsuario = Convert.ToInt32(read[0].ToString()),
                        NombreUsuario = read[1].ToString(),
                        Password = read[2].ToString(),
                        TipoUsuario = read[3].ToString()
                    };
                    listaUsuarios.Add(objetoUsuario);
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
            return listaUsuarios;
        }

        public List<Propiedad> findAllPropiedades(int id)
        {
            List<Propiedad> listaPropietarios = new List<Propiedad>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerPropiedades_Usuarios", objConexion.getConexion());
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

        public List<Propiedad> createPropiedad(int id)
        {
            List<Propiedad> listaPropiedades = new List<Propiedad>();
            try
            {
                comando = new SqlCommand("spObtenerPropiedades_SinUsuario", objConexion.getConexion());
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
        public void createPropiedad(int idU, int idP)
        {
            try
            {
                comando = new SqlCommand("spCreatePropiedad_Usuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idU", idU);
                comando.Parameters.AddWithValue("@idP", idP);
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

        public string verificar(Usuario usuario)
        {
            string result;
            try
            {
                comando = new SqlCommand("spValidarUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Nombre", usuario.NombreUsuario);
                comando.Parameters.AddWithValue("@Password", usuario.Password);
                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
                SqlDataReader read = comando.ExecuteReader();
                bool hayRegistros = read.Read();
                if (hayRegistros)
                {
                    usuario.IdUsuario = Convert.ToInt32(read[0].ToString());
                    usuario.NombreUsuario = read[1].ToString();
                    usuario.Password = read[2].ToString();
                    usuario.TipoUsuario = read[3].ToString();
                    result = usuario.TipoUsuario;
                }
                else
                {
                    result = "";
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
            return result;
        }
    }
}
