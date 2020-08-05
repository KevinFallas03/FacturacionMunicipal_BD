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
    public class ReciboDao
    {
        private Conexion objConexion;
        private SqlCommand comando;

        public ReciboDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public List<Recibo> findAllRecibosPe(int id, int estado)
        {
            Console.Out.Write(id);
            List<Recibo> listaRecibos = new List<Recibo>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerRecibosPedePropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                comando.Parameters.AddWithValue("@estado", estado);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Recibo objetoRecibo = new Recibo
                    {
                        IdRecibo = Convert.ToInt32(read[0].ToString()),
                        FechaEm = read[1].ToString(),
                        NombreCC = read[2].ToString(),
                        Monto = Convert.ToDecimal(read[3].ToString())
                    };
                    listaRecibos.Add(objetoRecibo);
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
            return listaRecibos;
        }

        public List<Recibo> findAllRecibosPeconint(int id)
        {
            Console.Out.Write(id);
            List<Recibo> listaRecibos = new List<Recibo>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerRecibosdePropiedadConInteres", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Recibo objetoRecibo = new Recibo
                    {
                        IdRecibo = Convert.ToInt32(read[0].ToString()),
                        FechaEm = read[1].ToString(),
                        NombreCC = read[2].ToString(),
                        Monto = Convert.ToDecimal(read[3].ToString()),
                        MontoI = Convert.ToDecimal(read[4].ToString())
                    };
                    listaRecibos.Add(objetoRecibo);
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
            return listaRecibos;
        }

        public bool findReciboPe(Recibo objetoRecibo, int estado)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("spVerReciboPedePropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@ID", objetoRecibo.IdRecibo);
                comando.Parameters.AddWithValue("@estado", estado);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objetoRecibo.IdRecibo = Convert.ToInt32(read[0].ToString());
                    objetoRecibo.FechaEm = read[1].ToString();
                    objetoRecibo.FechaMx = read[2].ToString();
                    objetoRecibo.NumFinca = Convert.ToInt32(read[3].ToString());
                    objetoRecibo.NombreCC = read[4].ToString();
                    objetoRecibo.Monto = Convert.ToDecimal(read[5].ToString());
                    objetoRecibo.IdPropiedad = Convert.ToInt32(read[6].ToString());
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

        public List<Recibo> findAllComprobantes(int id)
        {
            Console.Out.Write(id);
            List<Recibo> listaRecibos = new List<Recibo>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerComprobantesPedePropiedad", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@id", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Recibo objetoRecibo = new Recibo
                    {
                        IdRecibo = Convert.ToInt32(read[0].ToString()),
                        FechaEm = read[1].ToString(),
                        Monto = Convert.ToDecimal(read[2].ToString()),
                    };
                    listaRecibos.Add(objetoRecibo);
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
            return listaRecibos;

        }
        public List<Recibo> procesaRecibosPorPagar(string pJsonRecibos)
        {
           
            List<Recibo> listaRecibosPendientes = new List<Recibo>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spProcesarPagosUsuario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@jsonRecibos", pJsonRecibos);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Recibo objetoRecibo = new Recibo
                    {
                        IdRecibo = Convert.ToInt32(read[0].ToString()),
                        NombreCC = read[1].ToString(),
                        Monto = Convert.ToDecimal(read[2].ToString())
                    };
                    listaRecibosPendientes.Add(objetoRecibo);
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
            return listaRecibosPendientes;
            
        }

        public void confirmaciónPago()
        {

        }

        public double findTasa()
        {
            bool hayRegistros;
            double result = 0;
            try
            {
                comando = new SqlCommand("spObtenerporcentajeAP", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    result = Convert.ToDouble(read[0].ToString());
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


        public void createAP(int idP, double montoO, double plazo, double cuota, string fecha, double tasaA)
        {
            try
            {
                comando = new SqlCommand("spCreateAP", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@IdP", idP);
                comando.Parameters.AddWithValue("@MontoO", montoO);
                comando.Parameters.AddWithValue("@Plazo", plazo);
                comando.Parameters.AddWithValue("@Cuota", cuota);
                comando.Parameters.AddWithValue("@Fecha", fecha);
                comando.Parameters.AddWithValue("@TasaA", tasaA);
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

        public List<Recibo> findAllRecibosCO(int id)
        {
            Console.Out.Write(id);
            List<Recibo> listaRecibos = new List<Recibo>();
            List<int> listaid = new List<int>();
            try
            {
                comando = new SqlCommand("spObtenerRecibos_Comprobante", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idc", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {
                    Recibo objetoRecibo = new Recibo
                    {
                        IdRecibo = Convert.ToInt32(read[0].ToString()),
                        FechaEm = read[1].ToString(),
                        FechaMx = read[2].ToString(),
                        NombreCC = read[3].ToString(),
                        Monto = Convert.ToDecimal(read[4].ToString())
                    };
                    listaRecibos.Add(objetoRecibo);
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
            return listaRecibos;
        }
    }
}
