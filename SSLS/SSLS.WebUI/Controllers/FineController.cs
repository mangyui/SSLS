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
    public class FineController : Controller
    {
        private IBooksRepository repository;
        private IBorrowProcessor borrowProcessor;
        public int PageSize = 5;
        public FineController(IBooksRepository bookRepository, IBorrowProcessor proc)
        {
            this.repository = bookRepository;
            this.borrowProcessor = proc;
        }

        public ActionResult Index(Reader reader,int isFinish=0, int page = 1)
        {
            if (reader.Id == 0)
            {
                TempData["msg_warning"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            if (isFinish < 0 || isFinish > 2)
                isFinish = 0;
            IQueryable<Fine> FineList;
            return View(new FinesViewModel
            {
                Fines = repository.GetFines(reader,isFinish, page, PageSize, out FineList),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = FineList.Count()
                },
                IsFinish=isFinish
            });
        }
        public ActionResult PayMoney(int id)
        {
            Fine fine = repository.Fines.Where(f => f.Id == id).FirstOrDefault();
            return View(fine);
        }
        [HttpPost]
        public ActionResult PayMoney(Reader reader, int id)
        {
            string msg;
            int result = borrowProcessor.PayMoney(id,out msg);
            if(result==1)
            {  
                reader.Price = repository.Readers.Where(r => r.Id == reader.Id).FirstOrDefault().Price;
            }
            return Json(new
            {
                result = result,
                msg = msg
            });
        }
    }
}