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

        public ActionResult Index(Reader reader, int page = 1)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            IQueryable<Fine> FineList = repository.Fines.Where(b => b.Reader_ID == reader.Id);

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
                }
            });
        }
    }
}