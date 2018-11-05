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
                   new { Controller = "Book", action = "List", categoryId = 0, page = 1 }//默认控制器为Book，动作方法为List
               );
            routes.MapRoute(
                    null,//路由名称，不需要指定
                    "page{page}",//Url的形
                    new { Controller = "Book", action = "List", categoryId = 0 }//默认控制器为Book，动作方法为List
                );
            routes.MapRoute(
                   null,//路由名称，不需要指定
                   "cid{categoryId}",//Url的形
                   new { Controller = "Book", action = "List", page = 1 }//默认控制器为Book，动作方法为List
               );
            routes.MapRoute(
                   null,//路由名称，不需要指定
                   "cid{categoryId}/page{page}",//Url的形
                   new { Controller = "Book", action = "List" }//默认控制器为Book，动作方法为List
               );
            routes.MapRoute(
                name: null,
                url: "{controller}/{action}"
            );
        }
    }
}
