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
                url: "{controller}/{action}/{author}",
                defaults: new { controller = "Usuario", action = "Inicio", author = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Propiedad",
                url: "{controller}/{action}/{author}",
                defaults: new { controller = "Propiedad", action = "Inicio", author = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Propietario",
                url: "{controller}/{action}/{author}",
                defaults: new { controller = "Propietario", action = "Inicio", author = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Consulta",
                url: "consulta",
                defaults: new { controller = "Consulta", action = "Inicio", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "PropiedadesVsPropietarios",
                url: "PropiedadesVsPropietarios",
                defaults: new { controller = "Propietario", action = "PropiedadesPorValor", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "AP",
                url: "ap",
                defaults: new { controller = "AP", action = "Inicio", id = UrlParameter.Optional }
            );
        }
    }
}
