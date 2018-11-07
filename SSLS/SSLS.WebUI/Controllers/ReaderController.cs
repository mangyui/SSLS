using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;
using SSLS.WebUI.Models;

namespace SSLS.WebUI.Controllers
{
    public class ReaderController : Controller
    {
        private IBooksRepository repository;
        public ReaderController(IBooksRepository productsRepository)
        {
            this.repository = productsRepository;
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                Reader ReaderEntry = repository.Readers.FirstOrDefault(c =>
                    c.Code == model.Code && c.Password == model.Password);
                if (ReaderEntry != null)
                {
                    HttpContext.Session["Reader"] = ReaderEntry;
                    return Redirect(returnUrl ?? Url.Action("List", "Book"));
                }
                else
                {
                    ModelState.AddModelError("", "用户名或密码不正确！");
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
            HttpContext.Session["Reader"] = null;
            return View("Login");
        }
        public PartialViewResult Summary(Reader Reader)
        {
            return PartialView(Reader);
        }
    }
}