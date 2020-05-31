using System.Web.Mvc;

namespace MunicipalidadWebMVC5.Controllers
{
    public class MenuController : Controller
    {
        // GET: Menu
        public ActionResult Inicio()
        {
            return View();
        }
    }
}