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
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            if (isFinish < 0 || isFinish > 2)
                isFinish = 0;
            IQueryable<Fine> FineList = repository.Fines.Where(f => f.Reader_ID == reader.Id);
            if (isFinish == 1)
                FineList = FineList.Where(f => f.State == "待缴纳");
            else if (isFinish == 2)
                FineList = FineList.Where(f => f.State == "已缴纳");
            return View(new FinesViewModel
            {
                Fines = FineList.OrderByDescending(f => f.Id)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = FineList.Count()
                },
                IsFinish=isFinish
            });
        }
        public ActionResult PayMoney(Reader reader,int id)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            Fine fine = repository.Fines.Where(f => f.Id == id).FirstOrDefault();
            return View(fine);
        }
        public ActionResult ToPay(Reader reader,int id)
        {
            int result = borrowProcessor.PayMoney(id);
            if(result==0)
            {
                TempData["msg1"] = "您的账户余额不足！";
                return RedirectToAction("PayMoney", new { id});
            }
            else if(result ==1)
            {
                reader.Price = repository.Readers.Where(r => r.Id == reader.Id).FirstOrDefault().Price;
                TempData["msg1"] = "缴纳成功！";
                return RedirectToAction("PayMoney", new { id });
            }
            else
            {
                TempData["msg1"] = "缴纳失败！";
                return RedirectToAction("PayMoney", new { id });
            }
        }
    }
}