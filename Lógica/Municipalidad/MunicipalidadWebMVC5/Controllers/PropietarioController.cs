using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using model.entity;
using model.dao;

namespace MunicipalidadWebMVC5.Controllers
{
    public class PropietarioController : Controller
    {
        //private PropietarioNeg objetoAlumno;
        private PropietarioDao objetoPropietario;
        public PropietarioController()
        {
            objetoPropietario = new PropietarioDao();
            //objPropietarioNeg = new PropietarioNeg();
        }
        // GET: Propietario
        public ActionResult Inicio()
        {
            List<Propietario> lista = objetoPropietario.findAll();
            return View(lista);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Propietario objPropietario)
        {
            objetoPropietario.create(objPropietario);
            mensajeErrorRegistro(objPropietario);
            return View();
        }

        public void mensajeErrorRegistro(Propietario objPropietario)
        {
            switch (objPropietario.EstadoError)
            {
                case 20:
                    ViewBag.mensajeError = "Campo Nombre está vacío ";
                    break;
            }
        }
    }
}

