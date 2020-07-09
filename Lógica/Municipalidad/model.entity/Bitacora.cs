using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Bitacora
    {
        private int idBitacora;
        private string fecha;
        private string hora;
        private int idTipo;
        private int idEntidad;
        private string jsonantes;
        private string jsondespues;
        private string usuario;
        private string ip;

        public Bitacora() { }
        public Bitacora(int pIdBitacora)
        {
            this.idBitacora = pIdBitacora;
        }
        public Bitacora(int pIdBitacora, string pFecha, string pHora)
        {
            this.idBitacora = pIdBitacora;
            this.fecha = pFecha;
            this.hora = pHora;
        }

        //getters and setters
        public int IdBitacora { get => idBitacora; set => idBitacora = value; }
        public string Fecha { get => fecha; set => fecha = value; }
        public string Hora { get => hora; set => hora = value; }
        public int IdTipo { get => idTipo; set => idTipo = value; }
        public int IdEntidad { get => idEntidad; set => idEntidad = value; }
        public string Jsonantes { get => jsonantes; set => jsonantes = value; }
        public string Jsondespues { get => jsondespues; set => jsondespues = value; }
        public string Usuario { get => usuario; set => usuario = value; }
        public string Ip { get => ip; set => ip = value; }
    }
}
