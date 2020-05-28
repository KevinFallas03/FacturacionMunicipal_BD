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
            throw new NotImplementedException();
        }

        public void delete(Propiedad objetoPropiedad)
        {
            throw new NotImplementedException();
        }

        public bool find(Propiedad objetoPropiedad)
        {
            throw new NotImplementedException();
        }

        public List<Propiedad> findAll()
        {
            List<Propiedad> listaPropiedades = new List<Propiedad>();

            try
            {
                comando = new SqlCommand("spObtenerPropiedades", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Propiedad objetoPropiedad = new Propiedad();
                    objetoPropiedad.NumeroPropiedad = Convert.ToInt32(read[0].ToString());
                    objetoPropiedad.ValorPropiedad = Convert.ToDecimal(read[1].ToString());
                    objetoPropiedad.DireccionPropiedad = read[2].ToString();
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

        public void update(Propiedad objeto)
        {
            throw new NotImplementedException();
        }
    }
}
