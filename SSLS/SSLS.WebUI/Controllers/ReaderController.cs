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
                //if(model.Vcode!=Session["vcode"].ToString())
                //{
                //    TempData["msg"] = "验证码不正确";
                //    return View();
                //}
                Reader ReaderEntry = repository.Readers.FirstOrDefault(c =>
                    c.Code == model.Code && c.Password == model.Password);
                if (ReaderEntry != null)
                {
                    HttpContext.Session["Reader"] = ReaderEntry;
                    return Redirect(returnUrl ?? Url.Action("List", "Book"));
                }
                else
                {
                    //ModelState.AddModelError("", "用户名或密码不正确！");
                    TempData["msg"] = "用户名或密码不正确";
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterModel registerModel)
        {
            if (ModelState.IsValid)
            {
                if(!repository.hasCode(registerModel.Code))
                {
                    Reader reader = new Reader
                    {
                        Code = registerModel.Code,
                        Name = registerModel.Name,
                        Class = registerModel.Class,
                        Email = registerModel.Email,
                        Password = registerModel.Password,
                    };
                    repository.SaveReader(reader);
                    TempData["msg1"] = string.Format("{0}注册成功", reader.Name);
                    return RedirectToAction("Login");
                }
                else
                {
                    TempData["msg1"] = string.Format("{0} 账号已占用", registerModel.Code);
                    return View();
                }
            }
            else
            {
                TempData["msg"] = "填写错误";
                return View();
            }

        }

        public ActionResult Logout()
        {
            HttpContext.Session["Reader"] = null;
            return RedirectToAction("Login");
        }
        public PartialViewResult Summary(Reader Reader)
        {
            return PartialView(Reader);
        }

        #region 验证码
        [OutputCache(Duration = 0)]
        public ActionResult VCode()
        {
            string code = ValidataCode.MyRandom(4);
            Session["vcode"] = code;
            byte[] bytes = ValidataCode.GetVerifyCode(code);
            //ValidateCode.CreateImage(code);
            return File(bytes, @"image/gif");
        }

        public string GetCode()
        {
            return Session["vcode"].ToString();
        }
        #endregion
    }
}