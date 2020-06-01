using model.dao;
using model.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class UsuarioController : Controller
    {
        private UsuarioDao objetoUsuario;

        public UsuarioController()
        {
            objetoUsuario = new UsuarioDao();
        }

        // GET: Usuario
        public ActionResult Inicio()
        {
            List<Usuario> lista = objetoUsuario.findAll();
            return View(lista);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Usuario objUsuario)
        {
            objetoUsuario.create(objUsuario);
            return RedirectToAction("Inicio");
        }

        [HttpGet]
        public ActionResult Find(int ID)
        {
            Usuario objusuario = new Usuario(ID);
            objetoUsuario.find(objusuario);
            return View(objusuario);
        }

        [HttpPost]
        public ActionResult Find(string ID)
        {
            return RedirectToAction("Propiedades/" + ID);
        }

        [HttpGet]
        public ActionResult Update(int ID)
        {
            Usuario objusuario = new Usuario(ID);
            objetoUsuario.find(objusuario);
            return View(objusuario);
        }

        [HttpPost]
        public ActionResult Update(Usuario objusuario, int ID)
        {
            objusuario.IdUsuario = ID;
            objetoUsuario.update(objusuario);
            return RedirectToAction("Inicio");
        }

        public ActionResult Delete(Usuario objUsuario, int ID)
        {
            objUsuario.IdUsuario = ID;
            objetoUsuario.delete(objUsuario);
            return RedirectToAction("Inicio");
        }

        public ActionResult Propiedades(int ID)
        {
            List<Propiedad> lista = objetoUsuario.findAllPropiedades(ID);
            return View(lista);
        }
    }
}