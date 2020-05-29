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
    class PropietarioJuridicoDao : TemplateCRUD<PropietarioJuridico>
    {
        private Conexion objConexion;
        private SqlCommand comando;
        public void create(PropietarioJuridico objetoPropietarioJuridico)
        {
            throw new NotImplementedException();
        }

        public void delete(PropietarioJuridico objetoPropietarioJuridico)
        {
            throw new NotImplementedException();
        }

        public bool find(PropietarioJuridico objetoPropietarioJuridico)
        {
            throw new NotImplementedException();
        }

        public List<PropietarioJuridico> findAll()
        {
            List<PropietarioJuridico> listaPropietariosJuridicos = new List<PropietarioJuridico>();

            try
            {
                comando = new SqlCommand("spObtenerPropietariosJuridicos", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    PropietarioJuridico objetoPropietarioJuridico = new PropietarioJuridico();
                    objetoPropietarioJuridico.Nombre = read[0].ToString();
                    objetoPropietarioJuridico.TipoDocumento = Convert.ToInt32(read[1].ToString());
                    objetoPropietarioJuridico.ValorDocumentoId = read[2].ToString();
                    listaPropietariosJuridicos.Add(objetoPropietarioJuridico);
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
            return listaPropietariosJuridicos;
        }

        public void update(PropietarioJuridico objetoPropietarioJuridico)
        {
            throw new NotImplementedException();
        }
    }
}
