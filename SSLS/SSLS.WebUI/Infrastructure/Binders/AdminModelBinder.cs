using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Infrastructure.Binders
{
    public class AdminModelBinder : IModelBinder
    {
        private const string sessionKey = "Admin";

        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            Admin Admin = null;
            if (controllerContext.HttpContext.Session != null)
            {
                Admin = controllerContext.HttpContext.Session[sessionKey] as Admin;
            }
            if (Admin == null)
            {
                Admin = new Admin();
                if (controllerContext.HttpContext.Session != null)
                {
                    controllerContext.HttpContext.Session[sessionKey] = Admin;
                }
            }
            return Admin;
        }
    }
}