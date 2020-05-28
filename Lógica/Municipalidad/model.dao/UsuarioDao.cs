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
            throw new NotImplementedException();
        }

        public void delete(Usuario objetoUsuario)
        {
            throw new NotImplementedException();
        }

        public bool find(Usuario objetoUsuario)
        {
            throw new NotImplementedException();
        }

        public List<Usuario> findAll()
        {
            List<Usuario> listaUsuarios = new List<Usuario>();

            try
            {
                comando = new SqlCommand("spObtenerUsuarios", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Usuario objetoUsuario = new Usuario();
                    objetoUsuario.NombreUsuario = read[0].ToString();
                    objetoUsuario.Password = read[1].ToString();
                    objetoUsuario.TipoUsuario = read[2].ToString();
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

        public void update(Usuario objeto)
        {
            throw new NotImplementedException();
        }
    }
}
