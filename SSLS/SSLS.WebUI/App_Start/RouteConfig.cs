using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SSLS.WebUI
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                   null,//路由名称，不需要指定
                   "",
                   new { Controller = "Book", action = "List", categoryId = 0, page = 1 }
               );
            routes.MapRoute(
                    null,
                    "page{page}",
                    new { Controller = "Book", action = "List", categoryId = 0 }
                );
            routes.MapRoute(
                   null,
                   "cid{categoryId}",
                   new { Controller = "Book", action = "List", page = 1 }
               );
            routes.MapRoute(
                   null,
                   "cid{categoryId}/page{page}",
                   new { Controller = "Book", action = "List" }
               );
            routes.MapRoute(
                name: null,
                url: "{controller}/{action}"
            );
        }
    }
}
