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
                TempData["msg_warning"] = "您还未登录！";
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
                TempData["msg_warning"] = "您还未登录！";
                return RedirectToAction("Login", "Reader");
            }
            if (isOver < 0 || isOver > 2)
                isOver = 0;
            IQueryable<Borrow> BorrowList;
            return View(new BorrowViewModel
            {
                Borrows = repository.GetBorrows(reader,isOver,page,PageSize,out BorrowList),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = BorrowList.Count()
                },
                IsOver = isOver
            });
        }
        public ActionResult BorrowDetail(int id)
        {
            Borrow borrow = repository.Borrows.Where(b => b.Id == id).FirstOrDefault();
            return View(borrow);
        }
        [HttpPost]
        public ActionResult Renew(int id)
        {
            string Timelimit = "";
            int result = borrowProcessor.Renew(id,out Timelimit);
            return Json(new {
                result = result,
                Timelimit = Timelimit
            });
        }
        [HttpPost]
        public ActionResult ReturnBook(int id, Reader reader)
        {
            return Json(borrowProcessor.ProcessReturn(id, reader));
        }
    }
}