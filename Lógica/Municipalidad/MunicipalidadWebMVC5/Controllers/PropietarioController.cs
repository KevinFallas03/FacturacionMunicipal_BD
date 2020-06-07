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
        private PropietarioDao objetoPropietario;
        private static Propietario PropietarioJud = new Propietario();
        private static int idPr = 0;
        public PropietarioController()
        {
            objetoPropietario = new PropietarioDao();
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
            if (objPropietario.TipoDocumento == 4)
            {
                PropietarioJud = objPropietario;
                return RedirectToAction("CreateResponsable");
            }
            else
            {
                objetoPropietario.create(objPropietario);
                mensajeErrorRegistro(objPropietario);
                return RedirectToAction("Inicio");
            }
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
            idPr = ID;
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
            objetoPropietario.deleteresponsable(ID);
            return RedirectToAction("Inicio");     
        }

        [HttpGet]
        public ActionResult CreateResponsable()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateResponsable(PropietarioJuridico responsable)
        {
            objetoPropietario.createresponsable(PropietarioJud, responsable);
            return RedirectToAction("Inicio");
        }

        [HttpGet]
        public ActionResult Responsable(int ID)
        {
            PropietarioJuridico objpropietario = new PropietarioJuridico(ID);
            objetoPropietario.responsable(objpropietario);
            return View(objpropietario);
        }

        [HttpPost]
        public ActionResult Responsable(string ID)
        {
            return RedirectToAction("Find/" + ID);
        }

        [HttpGet]
        public ActionResult Updateresponsable(int ID)
        {
            PropietarioJuridico objpropietario = new PropietarioJuridico(ID);
            objetoPropietario.responsable(objpropietario);
            return View(objpropietario);
        }

        [HttpPost]
        public ActionResult Updateresponsable(PropietarioJuridico objPropietario, int ID)
        {
            objPropietario.IdPropietario = ID;
            objetoPropietario.updateresponsable(objPropietario);
            return RedirectToAction("Inicio");
        }

        public ActionResult Propiedades(int ID)
        {
            List<Propiedad> lista = objetoPropietario.findAllPropiedades(ID);
            return View(lista);
        }

        public ActionResult PropiedadesPorValor()
        {
            string valorIngresado = Request["valor"];
            List<Propiedad> lista = objetoPropietario.findAllPropiedadesIngresado(@valorIngresado);
            return View(lista);
        }

        public ActionResult CreatePropiedad()
        {
            List<Propiedad> listaProp = objetoPropietario.createPropiedad(idPr);
            return View(listaProp);
        }

        public ActionResult AgregarPropiedad(int ID)
        {
            objetoPropietario.createPropiedad(idPr, ID);
            return RedirectToAction("Propiedades/" + idPr);
        }

        public ActionResult DeletePropiedad(int ID)
        {
            objetoPropietario.deletePropiedad(ID);
            return RedirectToAction("Propiedades/" + idPr);
        }
    }
}

