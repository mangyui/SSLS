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
    public class DetailController : Controller
    {
        private IBooksRepository repository;

        public DetailController(IBooksRepository bookRepository)
        {
            this.repository = bookRepository;
        }
        public ActionResult Index(int id)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            string category = repository.Categories.FirstOrDefault(p => p.Id == book.Category_ID).Name;
            return View(new DetailViewModel { 
               Book  =book,
               category=category
            });
        }
    }
}