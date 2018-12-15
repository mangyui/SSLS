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

        public ActionResult Index(Reader reader)  
        {
            if (reader.Id == 0)
            {
                TempData["msg_error"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            ReaderModel RM = new ReaderModel
            {
                Reader = reader,
                Borrows = repository.Borrows.Where(b => b.Reader_ID == reader.Id),
                Fines = repository.Fines.Where(f => f.Reader_ID == reader.Id)
            };
            return View(RM);
        }
        public ActionResult Recharge(Reader reader)
        {
            return View(reader);
        }
        [HttpPost]
        public ActionResult Recharge(Reader reader,decimal money=0)
        {
            if(money==0)
            {
                TempData["msg_error"] = "请输入正确金额！！";
            }
            else
            {
               repository.Recharge(reader, money);
               reader.Price += money;
               TempData["msg_success"] = "充值成功！";
            }
            return View(reader);
        }
        public ActionResult ModifyData(Reader reader)
        {
            return View(new ReaderModifyModel { 
             Class=reader.Class,
              Code=reader.Code,
              Email=reader.Email,
               Name=reader.Name
            });
        }
        [HttpPost]
        public ActionResult ModifyData(Reader reader,ReaderModifyModel model)
        {
            if (ModelState.IsValid)
            {
                reader.Name = model.Name;
                reader.Class = model.Class;
                reader.Email = model.Email;
                repository.SaveReader(reader);
                TempData["msg_success"] = "修改成功！";
                return RedirectToAction("Index");
            }
            else
            {
                return View(model);
            }
        }
        [HttpPost]
        public ActionResult ModifyPwd(Reader reader, string oldPwd ,string newPwd)
        {
            if (oldPwd == reader.Password)
            {
                reader.Password = newPwd;
                repository.SaveReader(reader);
                HttpContext.Session["Reader"] = null;
                return Json(true);
            }
            else
            {
                return Json(false);
            }
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
                //    TempData["msg_error"] = "验证码不正确";
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
                    TempData["msg_error"] = "用户名或密码不正确";
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
                    TempData["msg_success"] = string.Format("{0}({1}) 注册成功", reader.Name,reader.Code);
                    TempData["Register_code"] = registerModel.Code;
                    return RedirectToAction("Login");
                }
                else
                {
                    TempData["msg_error"] = string.Format("{0} 账号已占用", registerModel.Code);
                    return View();
                }
            }
            else
            {
                TempData["msg_error"] = "填写错误";
                return View();
            }

        }

        public ActionResult Logout()
        {
            HttpContext.Session["Reader"] = null;
            return RedirectToAction("Login");
        }
        public PartialViewResult Summary(Reader reader)
        {
            ReaderModel RM = new ReaderModel
            {
                Reader = reader,
                Borrows = repository.Borrows.Where(b => b.Reader_ID == reader.Id),
                Fines = repository.Fines.Where(f => f.Reader_ID == reader.Id)
            };
            return PartialView(RM);
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