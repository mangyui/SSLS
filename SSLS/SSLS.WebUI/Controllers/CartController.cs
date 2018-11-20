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
                cart.AddItem(book);
            }
            return RedirectToAction("Index", new { returnUrl });
        }
        public RedirectToRouteResult RemoveFromCart(Cart cart, int id, string returnUrl)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            if (book != null)
            {
                cart.Removeline(book);
            }
            return RedirectToAction("Index", new { returnUrl });
        }
        public ViewResult Index(Cart cart, string returnUrl)
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
        public RedirectToRouteResult Confirm(Cart cart, int[] Selected, Reader reader)
        {
            if (cart.Lines.Count() == 0)
            {
                TempData["msg"] = "您的暂存架为空！";
                return RedirectToAction("Index");
            }
            if (reader.Id == 0)
            {
                TempData["msg"] = "抱歉，请先登录！";
                return RedirectToAction("Index");
            }
            if (Selected==null || Selected.Length == 0)
            {
                TempData["msg"] = "您还未勾选书籍！";
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

        public ActionResult Completed(Cart cart, Reader reader)   //ActionResult  可以RedirectToAction
        {
            if(Session["books"]==null)
            {
                TempData["msg"] = "您还未勾选书籍！";
                return RedirectToAction("Index");
            }
            List<Book> books = Session["books"] as List<Book>;
            borrowProcessor.ProcessBorrow(books, reader);
            cart.Clear();
            Session["books"] = null;
            return View(books);
        }
    }
}