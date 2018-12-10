using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;
using SSLS.WebUI.Models;
using SSLS.WebUI.Infrastructure;

namespace SSLS.WebUI.Controllers
{
    public class AdminController : Controller
    {
        private IBooksRepository repository;
        public int PageSize = 10;
        public AdminController(IBooksRepository bookRepository)
        {
            this.repository = bookRepository;;
        }       
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult BookList(int categoryId = 0, int page = 1)
        {
            IQueryable<Book> BooksList = repository.Books;

            if (categoryId > 0)
            {
                BooksList = repository.Books.Where(p => p.Category_ID == categoryId);
            }
            BooksListViewModel viewModel = new BooksListViewModel
            {
                Books = BooksList
                        .OrderBy(p => p.Id)
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

        public ActionResult BookEdit(int id)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);

            //IEnumerable<SelectListItem> selectListItem =
            //    repository.Categories.ToList().Select(
            //    c => new SelectListItem { Value = c.Id.ToString(), Text = c.Name });

            ViewBag.CategoryList = Utils.GetCategorySelectListItem(repository);
            return View(book);
        }
        [HttpPost]
        public ActionResult BookEdit(Book book,HttpPostedFileBase file)
        {
            string imageFileName = string.Empty;
            if(ModelState.IsValid)
            {
                if(file!=null)
                {
                    try
                    {
                        imageFileName = Utils.GetImageSaveName(file.FileName);
                        string savePathAndName = string.Format("{0}/{1}", Server.MapPath("~/PImages"), imageFileName);
                        file.SaveAs(savePathAndName);
                        book.ImageUrl = string.Format("/PImages/{0}", imageFileName);
                    }
                    catch
                    {
                        ModelState.AddModelError("", "图片保存失败！");
                    }

                }
                repository.SaveBook(book);
                TempData["msg_success"] = string.Format("{0}保存成功", book.Name);

                return RedirectToAction("BookList");
            }
            else
            {
                ViewBag.CategoryList = Utils.GetCategorySelectListItem(repository);
                return View(book);
            }
        }

        public ActionResult BookCreate()
        {
            ViewBag.CategoryList = Utils.GetCategorySelectListItem(repository);
            return View("BookEdit",new Book());       
        }

        [HttpPost]
        public ActionResult BookDelete(int id)
        {
            Book deleteBook = repository.DeleteBook(id);
            if(deleteBook!=null)
            {
                TempData["msg_success"] = string.Format("{0}删除成功", deleteBook.Name);
            }
            return RedirectToAction("BookList");
        }

        public ActionResult CategoryList()
        {
            return View(repository.Categories.ToList());
        }
        public ActionResult CategoryCreate()
        {
            return View("CategoryEdit", new Category());
        }
        public ActionResult CategoryEdit(int id)
        {
            Category category = repository.Categories.FirstOrDefault(p => p.Id == id);
            return View(category);
        }
        [HttpPost]
        public ActionResult CategoryEdit(Category category)
        {
            if (ModelState.IsValid)
            {
                repository.SaveCategory(category);
                TempData["msg_success"] = string.Format("{0}保存成功", category.Name);
                return RedirectToAction("CategoryList");
            }
            else
            {
                return View(category);
            }
        }
        [HttpPost]
        public ActionResult CategoryDelete(int id)
        {
            Category deleteCategory = repository.DeleteCategory(id);
            if (deleteCategory != null)
            {
                TempData["msg_success"] = string.Format("{0}删除成功", deleteCategory.Name);
            }
            return RedirectToAction("CategoryList");
        }
	}
}