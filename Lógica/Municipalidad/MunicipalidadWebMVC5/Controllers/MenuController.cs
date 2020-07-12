using System.Collections.Generic;
using System.Web.Mvc;
using model.entity;
using model.dao;
using System;


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
                return RedirectToAction("/MenuAdmin/" + user.IdUsuario);
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

        public ActionResult MenuAdmin(int ID)
        {
            Usuario usuario = new Usuario(ID);
            objetoUsuario.find(usuario);
            return View(usuario);
        }

        [HttpGet]
        public ActionResult MenuProp(int ID)
        {
            List<Propiedad> lista = objetoUsuario.findAllPropiedades(ID);
            Usuario user = new Usuario(ID);
            string username = user.NombreUsuario;
            Console.WriteLine(username);
            return View(lista);
        }
    }
}