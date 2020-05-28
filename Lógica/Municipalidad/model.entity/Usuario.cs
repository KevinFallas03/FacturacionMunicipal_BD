using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.entity
{
    public class Usuario
    {
        private int ID;
        private string nombreUsuario;
        private string password;
        private string tipoUsuario;
        public Usuario() {}
        public Usuario(int pID) 
        {
            this.ID = pID;
        }
        public Usuario(string pNombreUsuario, string pPassword, string pTipoUsuario)
        {
            this.NombreUsuario = pNombreUsuario;
            this.Password = pPassword;
            this.TipoUsuario = pTipoUsuario;
        }

        //getters and setters
        public string NombreUsuario { get => nombreUsuario; set => nombreUsuario = value; }
        public string Password { get => password; set => password = value; }
        public string TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
    }
}
