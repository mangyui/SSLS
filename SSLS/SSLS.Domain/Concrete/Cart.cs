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
                 using(var db = new LibraryEntities()){
                    Book bookEntry = db.Book.Find(book.Id);
                    if (bookEntry.Status == "在库")
                    {
                        bookEntry.Status = "已选择";
                        db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                        lineCollection.Add(new CartLine { Book = book, Quantity = quantity });
                    }
                 }
            }
            //else
            //{
            //    line.Quantity += quantity;
            //}
        }
        public IEnumerable<CartLine> Lines
        {
            get { return lineCollection; }
        }
        public void Removeline(Book book)
        {
            using (var db = new LibraryEntities())
            {
                Book bookEntry = db.Book.Find(book.Id);
                bookEntry.Status = "在库";
                db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                lineCollection.RemoveAll(e => e.Book.Id == book.Id);
            }

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
