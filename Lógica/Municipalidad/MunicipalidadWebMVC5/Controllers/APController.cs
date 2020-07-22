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
            listaRec = objetoRecibo.findAllRecibosPe(ID, 0);
            return View(listaRec);
        }

        public ActionResult Pago()
        {
            return View(listaRec);
        }
    }
}