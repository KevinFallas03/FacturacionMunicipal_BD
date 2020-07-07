using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class ReciboController : Controller
    {
        // GET: Recibo
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult RecibosPendientes()
        {
            return View();
        }
        public ActionResult RecibosPagados()
        {
            return View();
        }
        public ActionResult ComprobantesPago()
        {
            return View();
        }
    }
}