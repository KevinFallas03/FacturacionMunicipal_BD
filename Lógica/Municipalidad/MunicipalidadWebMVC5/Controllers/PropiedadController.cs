using model.dao;
using model.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class PropiedadController : Controller
    {
        private PropiedadDao objetoPropiedad;
        public PropiedadController()
        {
            objetoPropiedad = new PropiedadDao();
            //objPropietarioNeg = new PropietarioNeg();
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

        public ActionResult Find(int ID)
        {
            Propiedad objPropiedad = new Propiedad(ID);
            objetoPropiedad.find(objPropiedad);
            return View(objPropiedad);
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
    }
}