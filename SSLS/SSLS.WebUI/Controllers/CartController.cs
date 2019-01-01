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
    public class CartController : Controller
    {
        private IBooksRepository repository;
        private IBorrowProcessor borrowProcessor;
        public CartController(IBooksRepository bookRepository, IBorrowProcessor proc)
        {
            this.repository = bookRepository;
            this.borrowProcessor = proc;
        }
        public RedirectToRouteResult AddToCart(Cart cart, int id, string returnUrl)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            if (book != null)
            {
                if(cart.AddItem(book))
                    TempData["msg_success"] = "添加成功！";
                else
                    TempData["msg_success"] = "已在暂存架！";
            }
            return RedirectToAction("Index", new { returnUrl });
        }
        public RedirectToRouteResult RemoveFromCart(Cart cart, int id, string returnUrl)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            if (book != null)
            {
                cart.Removeline(book);
                TempData["msg_success"] = "移除成功！";
            }
            return RedirectToAction("Index", new { returnUrl });
        }
        public ViewResult Index(Cart cart, string returnUrl="/")
        {
            return View(new CartIndexViewModel
            {
                Cart = cart,
                ReturnUrl = returnUrl
            });
        }

        public PartialViewResult Summary(Cart cart)
        {
            return PartialView(cart);
        }
        [HttpPost]
        public ActionResult Confirm(Cart cart, int[] Selected, Reader reader)
        {
            if (cart.Lines.Count() == 0)
            {
                TempData["msg_warning"] = "您的暂存架为空！";
                return RedirectToAction("Index");
            }
            if (reader.Id == 0)
            {
                TempData["msg_warning"] = "抱歉，请先登录！";
                return RedirectToAction("Index");
            }
            if (Selected==null || Selected.Length == 0)
            {
                TempData["msg_warning"] = "您还未勾选书籍！";
               return RedirectToAction("Index");
            }
            List<Book> books=new List<Book>();
            foreach(CartLine cl in cart.Lines)
            {
                if(Array.IndexOf(Selected,cl.Book.Id)!=-1)
                {
                    books.Add(cl.Book);
                }
            }
             Session["books"] = books;
            return RedirectToAction("Checkout");
        }

        public ViewResult Checkout(Reader reader)
        {
            List<Book> books = Session["books"] as List<Book>;
            return View(new CheckoutModel
            {
                Books = books,
                Reader=reader
            });
        }

        public ActionResult Completed(Cart cart, Reader reader)  
        {
            if(Session["books"]==null)
            {
                TempData["msg_warning"] = "您还未勾选书籍！";
                return RedirectToAction("Index");
            }
            if (repository.Fines.Where(f =>f.Reader_ID==reader.Id&&f.State == "待缴纳").Count() > 0)
            {
                TempData["msg_error"] = "您有未缴纳的罚金！暂时无法借阅操作";
                return RedirectToAction("Checkout");
            }
            List<Book> books = Session["books"] as List<Book>;
            int cc=repository.Borrows.Where(f => f.Reader_ID == reader.Id && f.State == "在借").Count();
            if ((books.Count() + cc) > 3)
            {
                TempData["msg_error"] = "已限制在借数，你借阅过多!";
                return RedirectToAction("Checkout");
            }
            borrowProcessor.ProcessBorrow(books, reader);
            cart.Clear();
            Session["books"] = null;
            return View(new CheckoutModel
            {
                Books = books,
                Reader = reader
            });
        }
    }
}