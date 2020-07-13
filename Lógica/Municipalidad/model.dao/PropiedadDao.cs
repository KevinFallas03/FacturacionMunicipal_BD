using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using model.entity;

namespace model.dao
{
    public class PropiedadDao : TemplateCRUD<Propiedad>
    {
        private Conexion objConexion;
        private SqlCommand comando;
        private string ip;
        private string host;

        public PropiedadDao()
        {
            host = obtenerIP()[0];
            ip = obtenerIP()[1];
            objConexion = Conexion.saberEstado();
        }

        private string[] obtenerIP()
        {
            string Host = Dns.GetHostName();
            IPAddress[] Ip = Dns.GetHostAddresses(Host);
            string[] result = { Host, Ip[1].ToString() };
            return result;
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
            try
            {
                comando = new SqlCommand("spBorradoLogPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoPropiedad.IdPropiedad);
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

        public List<Usuario> findAllUsuariosIngresado(string valorIngresado)
        {
            List<Usuario> listaUsuarios = new List<Usuario>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerUsuarios_Propiedades_PorFinca", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@finca", Convert.ToInt32(valorIngresado));
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Usuario objetoUsuario = new Usuario
                    {
                        IdUsuario = Convert.ToInt32(read[0].ToString()),
                        NombreUsuario = read[1].ToString(),
                        Password = read[2].ToString(),
                        TipoUsuario = read[3].ToString(),
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

        public List<Propietario> findAllPropietariosIngresado(string valorIngresado)
        {
            List<Propietario> listaPropietarios = new List<Propietario>();
            int aux = Convert.ToInt32(valorIngresado.ToString());
            try
            {
                comando = new SqlCommand("spObtenerPropietarios_Propiedades_PorFinca", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@finca", aux);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propietario objetoPropietario = new Propietario
                    {
                        IdPropietario = Convert.ToInt32(read[0].ToString()),
                        Nombre = read[1].ToString(),
                        TipoDocumento = Convert.ToInt32(read[2].ToString()),
                        ValorDocumentoId = read[3].ToString(),
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

        public List<Usuario> findAllUsuarios(int id)
        {
            List<Usuario> listaUsuarios = new List<Usuario>();
            try
            {
                comando = new SqlCommand("spObtenerUsuarios_Propiedades", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Usuario objetoUsuario = new Usuario
                    {
                        IdUsuario = Convert.ToInt32(read[0].ToString()),
                        NombreUsuario = read[1].ToString(),
                        Password = read[2].ToString(),
                        TipoUsuario = read[3].ToString(),
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

        public List<Propietario> findAllPropietarios(int id)
        {
            List<Propietario> listaPropietarios = new List<Propietario>();
            try
            {
                comando = new SqlCommand("spObtenerPropietarios_Propiedades", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propietario objetoPropietario = new Propietario
                    {
                        IdPropietario = Convert.ToInt32(read[0].ToString()),
                        Nombre= read[1].ToString(),
                        TipoDocumento = Convert.ToInt32(read[2].ToString()),
                        ValorDocumentoId = read[3].ToString(),
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

        public void deleteUsuario(int ID)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogUsuario_Propiedad", objConexion.getConexion());
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

        public void deletePropietario(int ID)
        {
            try
            {
                comando = new SqlCommand("spBorradoLogPropietario_Propiedad", objConexion.getConexion());
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

        public List<Propietario> createPropietario(int id)
        {
            List<Propietario> listaPropietarios = new List<Propietario>();
            try
            {
                comando = new SqlCommand("spObtenerPropietario_SinPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propietario objetoPropietario = new Propietario
                    {
                        IdPropietario = Convert.ToInt32(read[0].ToString()),
                        Nombre = read[1].ToString(),
                        TipoDocumento = Convert.ToInt32(Convert.ToDecimal(read[2].ToString())),
                        ValorDocumentoId = read[3].ToString(),
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
        public void createPropietario(int idPropietario, int idPropiedad)
        {
            try
            {
                comando = new SqlCommand("spCreatePropiedad_Propietario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idPropietario", idPropietario);
                comando.Parameters.AddWithValue("@idPropiedad", idPropiedad);
                comando.Parameters.AddWithValue("@UsuarioACargo", host);
                comando.Parameters.AddWithValue("@IPusuario", ip);
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

        public List<Usuario> createUsuario(int id)
        {
            List<Usuario> listaUsuarios = new List<Usuario>();
            try
            {
                comando = new SqlCommand("spObtenerUsuarios_SinPropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Usuario objetoUsuario = new Usuario
                    {
                        IdUsuario = Convert.ToInt32(read[0].ToString()),
                        NombreUsuario =read[1].ToString(),
                        Password = read[2].ToString(),
                        TipoUsuario = read[3].ToString(),
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
        public void createUsuario(int idU, int idP)
        {
            try
            {
                comando = new SqlCommand("spCreatePropiedad_Usuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idU", idU);
                comando.Parameters.AddWithValue("@idP", idP);
                comando.Parameters.AddWithValue("@UsuarioACargo", host);
                comando.Parameters.AddWithValue("@IPusuario", ip);
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

        public string Host { get => host; set => host = value; }
    }
}
