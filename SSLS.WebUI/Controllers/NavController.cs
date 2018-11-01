using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Controllers
{
    public class NavController : Controller
    {
        private IBooksRepository repository;
        public NavController(IBooksRepository BookRepository)
        {
            this.repository = BookRepository;
        }
        public PartialViewResult Menu(int categoryId = 0)
        {
            ViewBag.CurrentcategoryId = categoryId;
            IEnumerable<Category> categories = repository.Categories.ToList();
            return PartialView(categories);
        }
    }
}