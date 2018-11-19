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
    public class BookController : Controller
    {

        private IBooksRepository repository;
        public int PageSize = 8;

        public BookController(IBooksRepository BookRepository)
        {
            this.repository = BookRepository;
        }

        public ActionResult List(int categoryId = 0, int page = 1)
        {
            IQueryable<Book> BooksList = repository.Books;

                if (categoryId > 0)
                {
                    BooksList = repository.Books.Where(p => p.Category_ID == categoryId);
                }
                BooksListViewModel viewModel = new BooksListViewModel
                {
                    Books = BooksList
                            .OrderByDescending(p => p.Id)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize),
                    PagingInfo = new PagingInfo
                    {
                        CurrentPage = page,
                        ItemsPerPage = PageSize,
                        TotalItems = BooksList.Count()
                    },
                    CurrentCategoryId = categoryId
                };
                return View(viewModel);
        }

        public ActionResult Search(string searchString)
        {
            ViewBag.searchString = searchString;
            IQueryable<Book> BooksList = repository.Books;
            BooksListViewModel viewModel;
            if (!String.IsNullOrEmpty(searchString))
            {
                viewModel = new BooksListViewModel
                {
                    Books = BooksList.Where(s => s.Name.Contains(searchString))  // || s.Description.Contains(searchString))
                };
                return View(viewModel);
            }
            else
            {
                viewModel = new BooksListViewModel
                {
                    Books = BooksList
                };
                return View(viewModel);
            }
        }

        public ActionResult Detail(int id)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);
            return View(book);
        }
    }
}