using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using model.entity;
using model.dao;

namespace MunicipalidadWebMVC5.Controllers
{
    public class ReciboController : Controller
    {
        private ReciboDao objetoRecibo;
        public ReciboController()
        {
            objetoRecibo = new ReciboDao();
        }
        // GET: Recibo
        public ActionResult Inicio()
        {
            return View();
        }
        public ActionResult RecibosPendientes(int ID)
        {
            List<Recibo> lista = objetoRecibo.findAllRecibosPe(ID,0);
            return View(lista);
        }
        public ActionResult RecibosPagados(int ID)
        {
            List<Recibo> lista = objetoRecibo.findAllRecibosPe(ID,1);
            return View(lista);
        }
        public ActionResult ComprobantesPago(int ID)
        {
            List<Recibo> lista = objetoRecibo.findAllComprobantes(ID);
            return View(lista);
        }
        public ActionResult ReciboPendiente(int ID)
        {
            Recibo objusuario = new Recibo(ID);
            objetoRecibo.findReciboPe(objusuario, 0);
            return View(objusuario);
        }
        public ActionResult ReciboPagado(int ID)
        {
            Recibo objusuario = new Recibo(ID);
            objetoRecibo.findReciboPe(objusuario, 1);
            return View(objusuario);
        }
    }
}