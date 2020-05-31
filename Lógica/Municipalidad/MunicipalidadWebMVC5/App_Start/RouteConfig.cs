using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace MunicipalidadWebMVC5
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Menu", action = "Inicio", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Usuario",
                url: "usuario",
                defaults: new { controller = "Usuario", action = "Inicio", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Propiedad",
                url: "propiedad",
                defaults: new { controller = "Propiedad", action = "Inicio", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Propietario",
                url: "propietario",
                defaults: new { controller = "Propietario", action = "Inicio", id = UrlParameter.Optional }
            );

            
        }
    }
}
