using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSLS.Domain.Abstract;

namespace SSLS.Domain.Concrete
{
    public class EFBookRepository : IBooksRepository
    {
        private LibraryEntities db = new LibraryEntities();

        public IQueryable<Book> Books
        {
            get { return db.Book; }
        }
        public IQueryable<Category> Categories
        {
            get { return db.Category; }
        }
        public IQueryable<Reader> Readers
        {
            get { return db.Reader; }
        }
        public IQueryable<Borrow> Borrows
        {
            get { return db.Borrow; }
        }
        public IQueryable<Fine> Fines
        {
            get { return db.Fine; }
        }
        public IQueryable<Admin> Admins
        {
            get { return db.Admin; }
        }
        public bool hasCode(string code)
        {
            if (db.Reader.Any(r => r.Code == code))
                return true;
            else
                return false;
        }
        public void SaveReader(Reader reader)
        {
            if (reader.Id == 0)
            {
                db.Reader.Add(reader);
            }
            else
            {
                //Find,通过主键来查找对应实体。对比FirstOrDefault方法效率要高一些。
                //Find,如果相应的实体已经被ObjectContent缓存,EF会在缓存中直接返回对应实体，而不会执行数据库访问。
                Reader dbEntry = db.Reader.Find(reader.Id);
                if (dbEntry != null)
                {
                    dbEntry.Name = reader.Name;
                    dbEntry.Class = reader.Class;
                    dbEntry.Email = reader.Email;
                    if (reader.Password != null || reader.Password!="")
                    dbEntry.Password = reader.Password;
                }
            }
            db.SaveChanges();
        }
        public void Recharge(Reader reader, decimal money)
        {
            Reader dbEntry = db.Reader.Find(reader.Id);
            dbEntry.Price = dbEntry.Price + money;
            db.SaveChanges();
        }

        public IQueryable<Borrow> GetBorrows(Reader reader,int isOver, int page, int PageSize,out IQueryable<Borrow> BorrowList)
        {
            BorrowList = Borrows.Where(b => b.Reader_ID == reader.Id && b.State != "在借");
            if (isOver == 1)
                BorrowList = BorrowList.Where(b => b.State == "超期");
            else if (isOver == 2)
                BorrowList = BorrowList.Where(b => b.State != "超期");

            return BorrowList.OrderByDescending(b => b.ReturnDate)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize);
        }
        public IQueryable<Fine> GetFines(Reader reader, int isFinish, int page, int PageSize,out IQueryable<Fine> FineList)
        {
            FineList = Fines.Where(f => f.Reader_ID == reader.Id);
            if (isFinish == 1)
                FineList = FineList.Where(f => f.State == "待缴纳");
            else if (isFinish == 2)
                FineList = FineList.Where(f => f.State == "已缴纳");

            return FineList.OrderByDescending(f => f.Id)
                            .Skip((page - 1) * PageSize)
                            .Take(PageSize);
        }

        public void SaveBook(Book book)
        {
            if (book.Id == 0)
            {
                db.Book.Add(book);
            }
            else
            {
                //Find,通过主键来查找对应实体。对比FirstOrDefault方法效率要高一些。
                //Find,如果相应的实体已经被ObjectContent缓存,EF会在缓存中直接返回对应实体，而不会执行数据库访问。
                Book dbEntry = db.Book.Find(book.Id);
                if (dbEntry != null)
                {
                    dbEntry.Name = book.Name;
                    dbEntry.Category_ID = book.Category_ID;
                    dbEntry.Price = book.Price;
                    dbEntry.Description = book.Description;
                    dbEntry.Code = book.Code;
                    dbEntry.ImageUrl = book.ImageUrl;
                    dbEntry.Authors = book.Authors;
                    dbEntry.Press = book.Press;
                    dbEntry.Status = book.Status;
                    dbEntry.PublishDate = book.PublishDate;
                }
            }
            db.SaveChanges();
        }

        public bool DeleteBook(int id,out string msg)
        {
            Book dbEntry = db.Book.Find(id);
            if (dbEntry == null)
            {
                msg = "不存在《" + dbEntry.Name + "》图书！";
                return false;
            }
            else
            {
                if (dbEntry.Status=="外借")
                {
                    msg ="《" + dbEntry.Name + "》图书外借，不能删除！";
                    return false;
                }
                else
                {
                    db.Book.Remove(dbEntry);
                    db.SaveChanges();
                    msg = "《" +dbEntry.Name + "》删除成功";
                    return true;
                }
            }
        }
        public void SaveCategory(Category category)
        {
            if (category.Id == 0)
            {
                db.Category.Add(category);
            }
            else
            {
                //Find,通过主键来查找对应实体。对比FirstOrDefault方法效率要高一些。
                //Find,如果相应的实体已经被ObjectContent缓存,EF会在缓存中直接返回对应实体，而不会执行数据库访问。
                Category dbEntry = db.Category.Find(category.Id);
                if (dbEntry != null)
                {
                    dbEntry.Name = category.Name;
                    dbEntry.Code = category.Code;
                    dbEntry.Description = category.Description;
                }
            }
            db.SaveChanges();
        }

        public bool DeleteCategory(int id,out string msg)
        {
            Category dbEntry = db.Category.Find(id);
            if (dbEntry == null)
            {
                msg = "不存在 " + dbEntry.Name + " 类别！";
                return false;
            }
            else
            {
                if (dbEntry.Book.Count() > 0)
                {
                    msg = "存在 " + dbEntry.Name + " 类别图书，不能删除！";
                    return false;
                }
                else
                {
                    db.Category.Remove(dbEntry);
                    db.SaveChanges();
                    msg = dbEntry.Name + "删除成功";
                    return true;
                }
            }
        }

        public object[] GetCatogoryChart()
        {
            int count = db.Category.Count();
            object[] obj = new object[count];
            int i = 0;
            foreach(var c in db.Category)
            {
                obj[i] = new
                {
                    value = c.Book.Count(),
                    name = c.Name
                };
                i++;
            }
            return obj;
        }
        public object[] GetBorrowChart()
        {
            string[] dates=new string[7];
            int[] values=new int[7];
            int i = 0;
            DateTime dt = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
            DateTime dt2 = Convert.ToDateTime(DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
            foreach (var c in db.Borrow)
            {
                dates[i]=dt.ToShortDateString().ToString();     
                values[i] = db.Borrow.Where(b => b.BorrowDate>=dt && b.BorrowDate<dt2).Count();
                dt = dt.AddDays(-1);
                dt2 = dt2.AddDays(-1);
                i++;
                if (i >= 7) break;
            }
            object[] obj = new object[]{
              dates.Reverse(),
              values.Reverse()
            };
            return obj;
        }
        public object[] GetBookTop()
        {
            string[] books=new string[6];
            int[] values=new int[6];
            int i = 0;
            var booksEntry = db.Book.OrderByDescending(b => b.Borrow.Count).Take(6);
            foreach (var c in booksEntry)
            {
                books[i] = c.Name;     
                values[i] = c.Borrow.Count();
                i++;
                if (i >= 6) break;
            }
            object[] obj = new object[]{
              books,
              values
            };
            return obj;
        }
        public object[] GetReaderTop()
        {
            string[] readers=new string[5];
            int[] values=new int[5];
            int[] values2 = new int[5];
            int i = 0;
            var readersEntry = db.Reader.OrderByDescending(b => b.Borrow.Count).Take(5);
            foreach (var c in readersEntry)
            {
                readers[i] = c.Name;     
                values[i] = c.Borrow.Count(b=>b.State=="在借");
                values2[i] = c.Borrow.Count(b => b.State != "在借");
                i++;
                if (i >= 5) break;
            }
            object[] obj = new object[]{
              readers.Reverse(),
              values.Reverse(),
              values2.Reverse()
            };
            return obj;
        }
        public object[] GetFineChart()
        {
            string[] readers=new string[5];
            int[] values=new int[5];
            int[] values2 = new int[5];
            int i = 0;
            var readersEntry = db.Reader.OrderByDescending(b => b.Fine.Count).Take(5);
            foreach (var c in readersEntry)
            {
                readers[i] = c.Name;     
                values[i] = c.Fine.Count(b=>b.State=="待缴纳");
                values2[i] = c.Fine.Count(b => b.State == "已缴纳");
                i++;
                if (i >= 5) break;
            }
            object[] obj = new object[]{
              readers.Reverse(),
              values.Reverse(),
              values2.Reverse()
            };
            return obj;
        }
    }
}
