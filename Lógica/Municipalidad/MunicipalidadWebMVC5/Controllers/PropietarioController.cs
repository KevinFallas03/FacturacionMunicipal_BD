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
            return RedirectToAction("Inicio");
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

        [HttpGet]
        public ActionResult Find(int ID)
        {
            Propietario objpropietario = new Propietario(ID);
            objetoPropietario.find(objpropietario);
            return View(objpropietario);
        }

        [HttpPost]
        public ActionResult Find(string ID)
        {
            return RedirectToAction("Propiedades/"+ID);
        }

        [HttpGet]
        public ActionResult Update(int ID)
        {
            Propietario objpropietario = new Propietario(ID);
            objetoPropietario.find(objpropietario);
            return View(objpropietario);
        }

        [HttpPost]
        public ActionResult Update(Propietario objPropietario, int ID)
        {
            objPropietario.IdPropietario = ID;
            objetoPropietario.update(objPropietario);
            return RedirectToAction("Inicio");
        }

        public ActionResult Delete(Propietario objPropietario, int ID)
        {
            objPropietario.IdPropietario = ID;
            objetoPropietario.delete(objPropietario);
            return RedirectToAction("Inicio");     
        }

        public ActionResult Propiedades(int ID)
        {
            List<Propiedad> lista = objetoPropietario.findAllPropiedades(ID);
            return View(lista);
        }
    }
}

