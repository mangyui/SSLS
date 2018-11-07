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
        //private IOrderProcessor orderProcessor;
        public CartController(IBooksRepository bookRepository)
        {
            this.repository = bookRepository;
            //this.orderProcessor = proc;
        }
        public RedirectToRouteResult AddToCart(Cart cart, int id, string returnUrl)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            if (book != null)
            {
                cart.AddItem(book, 1);
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
    }
}