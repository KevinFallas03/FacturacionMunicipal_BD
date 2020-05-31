﻿using System;
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
            throw new NotImplementedException();
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

    }
}
