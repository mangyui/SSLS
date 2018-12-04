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
    }
}
