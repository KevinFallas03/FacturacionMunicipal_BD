using model.dao;
using model.entity;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class APController : Controller
    {
        private UsuarioDao objetoUsuario;
        private ReciboDao objetoRecibo;
        private static int idP;
        private static double montoO;
        private static double plazo;
        private static double cuota;
        private static double tasaA;
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
            idP = ID;
            listaRec = objetoRecibo.findAllRecibosPeconint(ID);
            return View(listaRec);
        }

        [HttpGet]
        public ActionResult Pago(int mes)
        {
            montoO = 0;
            cuota = 0;
            tasaA = objetoRecibo.findTasa()/100;
            plazo = Convert.ToDouble(mes);
            foreach (var obj in listaRec)
            {
                montoO += Convert.ToDouble(obj.Monto + obj.MontoI);
            }
            cuota = montoO * ((tasaA * Math.Pow(1 + tasaA, plazo)) / (Math.Pow(1 + tasaA, plazo) - 1));
            TempData["total"] = montoO;
            TempData["cuota"] = cuota;
            TempData["meses"] = plazo;
            return View(listaRec);
        }

        [HttpPost]
        public ActionResult Pago()
        {
            DateTime hoy = DateTime.Today;
            string fecha = hoy.ToString("yyyy-MM-dd");
            Console.WriteLine(fecha);
            objetoRecibo.createAP(idP, montoO, plazo, cuota, fecha, tasaA*100);
            return RedirectToAction("Inicio", "AP");
        }

        public ActionResult PagoR()
        {
            string meses = Request["meses"];
            return RedirectToAction("Pago", "AP", new { @mes=  meses });
        }

    }
}