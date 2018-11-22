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
        public int PageSize = 5;
        public BorrowController(IBooksRepository bookRepository, IBorrowProcessor proc)
        {
            this.repository = bookRepository;
            this.borrowProcessor = proc;
        }
        public ActionResult MyBorrow(Reader reader, int page = 1)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            IQueryable<Borrow> BorrowList = repository.Borrows.Where(b => b.Reader_ID == reader.Id && b.State == "在借");

            return View(new BorrowViewModel
            {
                Borrows = BorrowList.OrderByDescending(b => b.BorrowDate)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = BorrowList.Count()
                }
            });
        }
        public ActionResult BorrowHistory(Reader reader, int isOver = 0, int page = 1)
        {
            if (reader.Id == 0)
            {
                TempData["msg"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            if (isOver < 0 || isOver > 2)
                isOver = 0;
            IQueryable<Borrow> BorrowList = repository.Borrows.Where(b => b.Reader_ID == reader.Id && b.State != "在借");
            if (isOver == 1)
                BorrowList=BorrowList.Where(b => b.State == "超期");
            else if (isOver == 2)
                BorrowList=BorrowList.Where(b => b.State != "超期");
            return View(new BorrowViewModel
            {
                Borrows = BorrowList.OrderByDescending(b => b.ReturnDate)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = BorrowList.Count()
                },
                IsOver = isOver
            });
        }
        public RedirectToRouteResult ReturnBook(int id, Reader reader)
        {
            bool f= borrowProcessor.ProcessReturn(id, reader);
            if(f)
                TempData["msg1"] = "归还成功！";
            return RedirectToAction("MyBorrow");
        }
        public RedirectToRouteResult Renew(int id, Reader reader)
        {
            bool f= borrowProcessor.Renew(id, reader);
            if (f)
                TempData["msg1"] = "续借成功！";
            return RedirectToAction("MyBorrow");
        }

    }
}