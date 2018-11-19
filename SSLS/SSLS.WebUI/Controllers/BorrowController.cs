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
    public class BorrowController : Controller
    {
        private IBooksRepository repository;
        private IBorrowProcessor borrowProcessor;
        public BorrowController(IBooksRepository bookRepository, IBorrowProcessor proc)
        {
            this.repository = bookRepository;
            this.borrowProcessor = proc;
        }
        public ActionResult Index(Reader reader)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login","Reader");
            }
            IQueryable<Borrow> BorrowList = repository.Borrows.Where(b=>b.Reader_ID == reader.Id);
            return View(new BorrowViewModel { 
             Borrows=BorrowList
            });
        }
        public ActionResult MyBorrow(Reader reader)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            IQueryable<Borrow> BorrowList = repository.Borrows.OrderByDescending(b=>b.BorrowDate).Where(b => b.Reader_ID == reader.Id && b.State == "在借");
            return View(new BorrowViewModel
            {
                Borrows = BorrowList
            });
        }
        public ActionResult BorrowHistory(Reader reader)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            IQueryable<Borrow> BorrowList = repository.Borrows.Where(b => b.Reader_ID == reader.Id && b.State == "已归还").OrderByDescending(b => b.ReturnDate);
            return View(new BorrowViewModel
            {
                Borrows = BorrowList
            });
        }
        public RedirectToRouteResult ReturnBook(int id, Reader reader)
        {
            bool f= borrowProcessor.ProcessReturn(id, reader);
            return RedirectToAction("MyBorrow");
        }
        public RedirectToRouteResult Renew(int id, Reader reader)
        {
            bool f= borrowProcessor.Renew(id, reader);
            return RedirectToAction("MyBorrow");
        }
        public PartialViewResult Summary(Reader Reader)
        {
            return PartialView(Reader);
        }

    }
}