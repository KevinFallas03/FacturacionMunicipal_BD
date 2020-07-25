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
        private static int id;
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
            id = ID;
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

        public ActionResult Selected(string[] ids)
        {
            if (ids == null || ids.Length == 0)
            {
                //throw error
                ModelState.AddModelError("", "No item selected to delete");
            }
            else
            {
                Console.WriteLine(ids[0]);
            }
 /*
            //bind the task collection into list
            List<int> TaskIds = ids.Select(x => Int32.Parse(x)).ToList();
            for (var i = 0; i<TaskIds.Count(); i++)
            {
                var todo = db.ToDoes.Find(TaskIds[i]);
                //remove the record from the database
                db.ToDoes.Remove(todo);
                //call save changes action otherwise the table will not be updated
                db.SaveChanges();
            }
            //redirect to index view once record is deleted*/
            return RedirectToAction("RecibosPendientes/"+id);
        }
    }
}