using System.Web.Mvc;
using model.entity;
using model.dao;

namespace MunicipalidadWebMVC5.Controllers
{
    public class MenuController : Controller
    {
        private UsuarioDao objetoUsuario;
        public MenuController()
        {
            objetoUsuario = new UsuarioDao();
        }
        // GET: Menu
        [HttpGet]
        public ActionResult Inicio()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Inicio(Usuario user)
        {
            string tipo = objetoUsuario.verificar(user);
            if (tipo == "Administrador")
            {
                return RedirectToAction("/MenuAdmin");
            }
            else if (tipo == "Propietario")
            {
                user = new Usuario();
                return RedirectToAction("/MenuProp");
            }
            else
            {
                user = new Usuario();
                return View();
            }
        }

        public ActionResult MenuAdmin()
        {
            return View();
        }

        public ActionResult MenuProp()
        {
            return View();
        }
    }
}