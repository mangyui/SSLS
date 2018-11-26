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

        bool hasCode(string code);
        void SaveReader(Reader reader);

        void Recharge(Reader reader, decimal money);

    }
}
