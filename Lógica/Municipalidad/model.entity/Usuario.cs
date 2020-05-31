using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Usuario
    {
        private int idUsuario;
        private string nombreUsuario;
        private string password;
        private string tipoUsuario;
        public Usuario() {}
        public Usuario(int pIdUsuario) 
        {
            this.idUsuario = pIdUsuario;
        }
        public Usuario(int pIdUsuario, string pNombreUsuario, string pPassword, string pTipoUsuario)
        {
            this.idUsuario = pIdUsuario;
            this.NombreUsuario = pNombreUsuario;
            this.Password = pPassword;
            this.TipoUsuario = pTipoUsuario;
        }

        //getters and setters
        public int IdUsuario { get => idUsuario; set => idUsuario = value; }
        public string NombreUsuario { get => nombreUsuario; set => nombreUsuario = value; }
        public string Password { get => password; set => password = value; }
        public string TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
    }
}
