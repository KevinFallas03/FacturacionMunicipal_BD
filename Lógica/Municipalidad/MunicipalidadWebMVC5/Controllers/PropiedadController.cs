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
    }
}