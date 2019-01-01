using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSLS.Domain.Concrete;

namespace SSLS.Domain.Abstract
{
    public interface IBooksRepository
    {
        IQueryable<Book> Books { get; }
        IQueryable<Category> Categories { get; }
        IQueryable<Reader> Readers { get; }
        IQueryable<Borrow> Borrows { get; }
        IQueryable<Fine> Fines { get; }

        IQueryable<Admin> Admins { get; }

        bool hasCode(string code);
        void SaveReader(Reader reader);

        void Recharge(Reader reader, decimal money);

        IQueryable<Borrow> GetBorrows(Reader reader, int isOver, int page, int PageSize, out IQueryable<Borrow> BorrowList);
        IQueryable<Fine> GetFines(Reader reader, int isFinish, int page, int PageSize,out IQueryable<Fine> FineList);


        void SaveBook(Book book);
        bool DeleteBook(int id, out string msg);
        void SaveCategory(Category category);
        bool DeleteCategory(int id, out string msg);


        object[] GetCatogoryChart();
        object[] GetBorrowChart();
        object[] GetBorrowCategory();
        object[] GetAllReader();
        object[] GetBookTop();
        object[] GetReaderTop();
        object[] GetFineChart();


    }
}
