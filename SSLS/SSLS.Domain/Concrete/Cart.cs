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

        public void AddItem(Book book, int quantity)
        {
            CartLine line = lineCollection.Where(e => e.Book.Id == book.Id).FirstOrDefault();
            if (line == null)
            {
                lineCollection.Add(new CartLine { Book = book, Quantity = quantity });
            }
            else
            {
                line.Quantity += quantity;
            }
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
            return lineCollection.Sum(e => e.Book.Price.Value * e.Quantity);
        }
    }
}
