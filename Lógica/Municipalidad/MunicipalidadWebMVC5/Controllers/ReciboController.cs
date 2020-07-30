using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using model.entity;
using model.dao;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

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
            ReciboDao idRecibo = new ReciboDao();
            if (ids == null || ids.Length == 0)
            {
                //throw error
                ModelState.AddModelError("", "No item selected to delete");
            }
            else
            {
                Console.WriteLine(ids[0]);
                List<string> jsonIds = new List<string>();
                jsonIds.Add("[");
                for(int i = 0; i<ids.Length; i++)
                {
                    Console.WriteLine(id);
                    
                    jsonIds.Add("{\"id\":");
                    //jsonIds.Add("\"");
                    jsonIds.Add(ids[i]);
                    jsonIds.Add("}");
                    if(i < ids.Length - 1)
                        jsonIds.Add(",");
                }
                jsonIds.Add("]");
                string jsonIdsToReturn = string.Join(" ", jsonIds);
                    
                idRecibo.pagaReciboUsuario(jsonIdsToReturn);
                
            }
            return RedirectToAction("Inicio");
        }
    }
}