using System.Collections.Generic;
using System.Web.Mvc;
using model.entity;
using model.dao;
using System.Text;

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
            Bitacora objbitacora = new Bitacora(ID);
            objetoBitacora.find(objbitacora);
            objbitacora.Jsonantes = objbitacora.Jsonantes.Replace("[{", "");
            objbitacora.Jsonantes = objbitacora.Jsonantes.Replace("}]", "");
            objbitacora.Jsonantes = objbitacora.Jsonantes.Replace("\"", "");
            objbitacora.Jsondespues = objbitacora.Jsondespues.Replace("[{", "");
            objbitacora.Jsondespues = objbitacora.Jsondespues.Replace("}]", "");
            objbitacora.Jsondespues = objbitacora.Jsondespues.Replace("\"", "");
            return View(objbitacora);
        }

        public ActionResult Consulta()
        {
            string fechainic = Request["startdate"];
            string fechafini = Request["enddate"];
            string tipo = Request["type"];
            List<Bitacora> lista = objetoBitacora.findAllConsulta(@fechainic, @fechafini, @tipo);
            return View(lista);
        }
    }
}