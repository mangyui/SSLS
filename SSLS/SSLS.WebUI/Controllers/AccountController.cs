using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;
using SSLS.WebUI.Infrastructure.Abstract;
using SSLS.WebUI.Models;

namespace SSLS.WebUI.Controllers
{
    public class AccountController : Controller
    {
        IAuthProvider authProvider;
        public AccountController(IAuthProvider auth)
        {
            this.authProvider = auth;
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Admin model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (authProvider.Authenticate(model.UserName, model.Password))
                {
                    return Redirect(returnUrl ?? Url.Action("Index", "Admin"));
                }
                else
                {
                    ModelState.AddModelError("", "用户名或密码错误！");
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

        public ActionResult Logout()
        {
            authProvider.ToOut();
            return RedirectToAction("Login");
        }
        public PartialViewResult Summary()
        {
            ViewBag.AdminName = authProvider.GetName();
            return PartialView();
        }
    }
}