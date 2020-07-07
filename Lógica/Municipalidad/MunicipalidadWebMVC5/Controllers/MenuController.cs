using System.Collections.Generic;
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
            else if (tipo == "Normal")
            {
                //user = new Usuario();
                return RedirectToAction("/MenuProp/" +user.IdUsuario);
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

        [HttpGet]
        public ActionResult MenuProp(int ID)
        {
            List<Propiedad> lista = objetoUsuario.findAllPropiedades(ID);
            return View(lista);
        }
    }
}