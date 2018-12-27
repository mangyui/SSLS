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
    [Authorize]
    public class AdminController : Controller
    {
        private IBooksRepository repository;
        public int PageSize = 6;
        public AdminController(IBooksRepository bookRepository)
        {
            this.repository = bookRepository;;
        }       
        // GET: Admin
        public ActionResult Index()
        {
            return View(new AdminAllModel { 
               Books=repository.Books,
               Categorys=repository.Categories,
               Borrows=repository.Borrows,
               Fines=repository.Fines,
               Readers=repository.Readers
            });
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

        public ActionResult BookEdit(int id)
        {
            Book book = repository.Books.FirstOrDefault(p => p.Id == id);

            ViewBag.CategoryList = Utils.GetCategorySelectListItem(repository);
            return View(book);
        }
        [HttpPost]
        public ActionResult BookEdit(Book book,HttpPostedFileBase file,Admin admin)
        {
            if(admin.UserName!="mangyu")
            {
                TempData["msg_error"] = "你没有该权限！";
                ViewBag.CategoryList = Utils.GetCategorySelectListItem(repository);
                return View(book);
            }
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
                TempData["msg_success"] = string.Format("《{0}》保存成功", book.Name);

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
        public ActionResult BookDelete(int id,Admin admin)
        {
            string msg;
            if (admin.UserName != "mangyu")
            {
                return Json(new
                {
                    result = false,
                    msg = "你没有该权限！"
                }); 
            }
            return Json(new
            {
                result = repository.DeleteBook(id, out msg),
                msg = msg
            }); 
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
        public ActionResult CategoryEdit(Category category,Admin admin)
        {
            if (admin.UserName != "mangyu")
            {
                TempData["msg_error"] = "你没有该权限！";
                return View(category);
            }
            if (ModelState.IsValid)
            {
                repository.SaveCategory(category);
                TempData["msg_success"] = string.Format("{0} 类别保存成功", category.Name);
                return RedirectToAction("CategoryList");
            }
            else
            {
                return View(category);
            }
        }
        [HttpPost]
        public ActionResult CategoryDelete(int id,Admin admin)
        {
            string msg;
            if (admin.UserName != "mangyu")
            {
                return Json(new
                {
                    result = false,
                    msg = "你没有该权限！"
                });
            }
            return Json(new {
                result=repository.DeleteCategory(id,out msg),
                msg=msg
            }); 
        }

        public ActionResult ReaderList(int page = 1)
        {
            IQueryable<Reader> ReadersList = repository.Readers;

            ReadersListModel viewModel = new ReadersListModel
            {
                Readers = ReadersList
                        .OrderBy(p => p.Id)
                        .Skip((page - 1) * PageSize)
                        .Take(PageSize),
                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = ReadersList.Count()
                }
            };
            return View(viewModel);
        }
        public ActionResult ReaderDetail(int id)
        {
            Reader reader = repository.Readers.Where(r => r.Id == id).FirstOrDefault();
            return View(reader);
        }

        public ActionResult BorrowStatistics()
        {
            return View(repository.Borrows);
        }
        public ActionResult FineStatistics()
        {
            return View(repository.Fines);
        }
        public ActionResult Analyze()
        {
            return View(repository.Borrows);
        }
        [HttpPost]
        public ActionResult GetBCChart()
        {
           return Json(repository.GetCatogoryChart());     
        }
        [HttpPost]
        public ActionResult GetBorrowChart()
        {
            return Json(repository.GetBorrowChart());
        }
        [HttpPost]
        public ActionResult GetBorrowCategory()
        {
            return Json(repository.GetBorrowCategory());
        }
        [HttpPost]
        public ActionResult GetBookTop()
        {
            return Json(repository.GetBookTop());
        }
        [HttpPost]
        public ActionResult GetReaderTop()
        {
            return Json(repository.GetReaderTop());
        }
        [HttpPost]
        public ActionResult GetFineChart()
        {
            return Json(repository.GetFineChart());
        }
	}
}