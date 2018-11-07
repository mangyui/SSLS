﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using SSLS.Domain.Concrete;
using SSLS.WebUI.Infrastructure.Binders;

namespace SSLS.WebUI
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            //设置Cart类  使用CartModelBinder进行绑定
            ModelBinders.Binders.Add(typeof(Cart), new CartModelBinder());
            //设置Reader类  使用ReaderModelBinder进行绑定
            ModelBinders.Binders.Add(typeof(Reader), new ReaderModelBinder());
        }
    }
}
