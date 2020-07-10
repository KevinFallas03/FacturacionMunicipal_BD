using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using model.entity;
using model.dao;

namespace MunicipalidadWebMVC5.Controllers
{
    public class BitacoraController : Controller
    {
        private BitacoraDao objetoBitacora;
        public BitacoraController()
        {
            objetoBitacora = new BitacoraDao();
        }
        // GET: Bitacora
        public ActionResult Inicio()
        {
            List<Bitacora> lista = objetoBitacora.findAll();
            return View(lista);
        }

        [HttpGet]
        public ActionResult Find(int ID)
        {
            Bitacora objpropietario = new Bitacora(ID);
            objetoBitacora.find(objpropietario);
            return View(objpropietario);
        }
    }
}