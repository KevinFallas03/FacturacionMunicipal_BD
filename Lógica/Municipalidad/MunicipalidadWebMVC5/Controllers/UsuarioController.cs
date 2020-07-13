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
        private static int idUs = 0;
        private static string nombre = "";
        private UsuarioDao objetoUsuario;

        public UsuarioController()
        {
            objetoUsuario = new UsuarioDao();
        }

        // GET: Usuario
        public ActionResult Inicio(string name)
        {
            List<Usuario> lista = objetoUsuario.findAll();
            nombre = name;
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
            objetoUsuario.create(objUsuario, nombre);
            return RedirectToAction("Inicio");
        }

        [HttpGet]
        public ActionResult Find(int ID)
        {
            idUs = ID;
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
            objetoUsuario.update(objusuario, nombre);
            return RedirectToAction("Inicio/"+nombre);
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

        public ActionResult CreatePropiedad()
        {
            List<Propiedad> listaProp = objetoUsuario.createPropiedad(idUs);
            return View(listaProp);
        }

        public ActionResult AgregarPropiedad(int ID)
        {
            objetoUsuario.createPropiedad(idUs, ID, nombre);
            return RedirectToAction("Propiedades/" + idUs);
        }

        public ActionResult DeletePropiedad(int ID)
        {
            objetoUsuario.deletePropiedad(ID);
            return RedirectToAction("Propiedades/" + idUs);
        }

        public ActionResult PropiedadesVsUsuario()
        {
            string valorIngresado = Request["valor"];
            List<Propiedad> lista = objetoUsuario.findAllPropiedadesIngresado(@valorIngresado);
            return View(lista);
        }

    }
}