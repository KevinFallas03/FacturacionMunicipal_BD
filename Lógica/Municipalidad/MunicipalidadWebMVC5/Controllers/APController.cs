using System;
using System.Collections.Generic;
using System.Web.Mvc;
using model.dao;
using model.entity;

namespace MunicipalidadWebMVC5.Controllers
{
    public class APController : Controller
    {
        private UsuarioDao objetoUsuario;
        private ReciboDao objetoRecibo;
        private static List<Recibo> listaRec;

        public APController()
        {
            objetoUsuario = new UsuarioDao();
            objetoRecibo = new ReciboDao();
        }

        // GET: AP
        public ActionResult Inicio()
        {
            return View();
        }

        public ActionResult Propiedades()
        {
            string valorIngresado = Request["valor"];
            List<Propiedad> lista = objetoUsuario.findAllPropiedadesIngresado(@valorIngresado);
            return View(lista);
        }

        public ActionResult RecibosPendientes(int ID)
        {
            listaRec = objetoRecibo.findAllRecibosPeconint(ID);
            return View(listaRec);
        }

        [HttpGet]
        public ActionResult Pago(int mes)
        {
            double total = 0;
            double cuota = 0;
            double tasa = 0.1;
            double meses = Convert.ToDouble(mes);
            foreach (var obj in listaRec)
            {
                total += Convert.ToDouble(obj.Monto + obj.MontoI);
            }
            cuota = total * ((tasa * Math.Pow(1 + tasa, meses)) / (Math.Pow(1 + tasa, meses) - 1));
            TempData["total"] = total;
            TempData["cuota"] = cuota;
            TempData["meses"] = meses;
            return View(listaRec);
        }

        public ActionResult PagoR()
        {
            string meses = Request["meses"];
            return RedirectToAction("Pago", "AP", new { @mes=  meses });
        }
    }
}