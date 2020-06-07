using model.dao;
using model.entity;
using System.Collections.Generic;
using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class PropiedadController : Controller
    {
        private PropiedadDao objetoPropiedad;
        private static int idUP = 0;
        public PropiedadController()
        {
            objetoPropiedad = new PropiedadDao();
        }
        // GET: Propiedad
        public ActionResult Inicio()
        {
            List<Propiedad> lista = objetoPropiedad.findAll();
            return View(lista);
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Propiedad objPropiedad)
        {
            objetoPropiedad.create(objPropiedad);
            return RedirectToAction("Inicio");
        }

        [HttpGet]
        public ActionResult Find(int ID)
        {
            idUP = ID;
            Propiedad objPropiedad = new Propiedad(ID);
            objetoPropiedad.find(objPropiedad);
            return View(objPropiedad);
        }


        [HttpPost]
        public ActionResult Find(string ID)
        {
            return RedirectToAction("/" + ID);
        }

        [HttpGet]
        public ActionResult Update(int ID)
        {
            Propiedad objPropiedad = new Propiedad(ID);
            objetoPropiedad.find(objPropiedad);
            return View(objPropiedad);
        }

        [HttpPost]
        public ActionResult Update(Propiedad objPropiedad, int ID)
        {
            objPropiedad.IdPropiedad = ID;
            objetoPropiedad.update(objPropiedad);
            return RedirectToAction("Inicio");
        }

        public ActionResult Delete(Propiedad objPropiedad, int ID)
        {
            objPropiedad.IdPropiedad = ID;
            objetoPropiedad.delete(objPropiedad);
            return RedirectToAction("Inicio");
        }

        public ActionResult Usuarios(int ID)
        {
            List<Usuario> lista = objetoPropiedad.findAllUsuarios(ID);
            return View(lista);
        }

        public ActionResult Propietarios(int ID)
        {
            List<Propietario> lista = objetoPropiedad.findAllPropietarios(ID);
            return View(lista);
        }

        public ActionResult CreateUsuario()
        {
            List<Usuario> listaProp = objetoPropiedad.createUsuario(idUP);
            return View(listaProp);
        }

        public ActionResult AgregarUsuario(int ID)
        {
            objetoPropiedad.createUsuario(ID, idUP);
            return RedirectToAction("Usuarios/" + idUP);
        }

        public ActionResult DeleteUsuario(int ID)
        {
            objetoPropiedad.deleteUsuario(ID);
            return RedirectToAction("Usuarios/" + idUP);
        }

        public ActionResult CreatePropietario()
        {
            List<Propietario> listaProp = objetoPropiedad.createPropietario(idUP);
            return View(listaProp);
        }

        public ActionResult AgregarPropietario(int ID)
        {
            objetoPropiedad.createPropietario(ID, idUP);
            return RedirectToAction("Propietarios/" + idUP);
        }
        public ActionResult DeletePropietario(int ID)
        {
            objetoPropiedad.deletePropietario(ID);
            return RedirectToAction("Propietarios/" + idUP);
        }

        public ActionResult PropietarioVsPropiedades()
        {
            string valorIngresado = Request["valor"];
            List<Propietario> lista = objetoPropiedad.findAllPropietariosIngresado(@valorIngresado);
            return View(lista);
        }
        public ActionResult UsuarioVsPropiedad()
        {
            string valorIngresado = Request["valor"];
            List<Usuario> lista = objetoPropiedad.findAllUsuariosIngresado(@valorIngresado);
            return View(lista);
        }
    }
}


