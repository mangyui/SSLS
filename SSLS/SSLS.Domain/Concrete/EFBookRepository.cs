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
    }
}
