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
        private IBooksRepository repository;
        public AccountController(IAuthProvider auth, IBooksRepository productsRepository)
        {
            this.authProvider = auth;
            this.repository = productsRepository;
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(AdminLoginModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                Admin AdminEntry = repository.Admins.FirstOrDefault(c =>
                    c.UserName == model.UserName && c.Password == model.Password);
                if (AdminEntry != null)
                {
                    authProvider.Authenticate(model.UserName,true);
                    HttpContext.Session["Admin"] = AdminEntry;
                    return Redirect(returnUrl ?? Url.Action("Index", "Admin"));
                }
                else
                {
                    authProvider.Authenticate(model.UserName,false);
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
            HttpContext.Session["Admin"] = null;
            return RedirectToAction("Login");
        }
        public PartialViewResult Summary(Admin admin)
        {
            ViewBag.AdminName = admin.UserName;
            return PartialView();
        }
    }
}