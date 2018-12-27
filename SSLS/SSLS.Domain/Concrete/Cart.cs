using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSLS.Domain.Concrete
{
    public class Cart
    {
        private List<CartLine> lineCollection = new List<CartLine>();
        public bool AddItem(Book book)
        {
            CartLine line = lineCollection.Where(e => e.Book.Id == book.Id).FirstOrDefault();
            if (line == null)
            {
                using (var db = new LibraryEntities())
                {
                    Book bookEntry = db.Book.Find(book.Id);
                    if (bookEntry.Status == "在库")
                    {
                        lineCollection.Add(new CartLine { Book = book });
                        return true;
                    }

                }
                return false;
            }
            return false;
        }
        
        public IEnumerable<CartLine> Lines
        {
            get { return lineCollection; }
        }
        public void Removeline(Book book)
        {
            lineCollection.RemoveAll(e => e.Book.Id == book.Id);
        }
        public void Clear()
        {
            lineCollection.Clear();
        }
        public decimal ComputeTotalValue()
        {
            return lineCollection.Sum(e => e.Book.Price.Value);
        }
    }
}
