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
        public int PageSize = 5;
        public FineController(IBooksRepository bookRepository)
        {
            this.repository = bookRepository;
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
    }
}