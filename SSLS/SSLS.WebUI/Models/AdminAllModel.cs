using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class AdminAllModel
    {
        public IEnumerable<Book> Books { get; set; }
        public IEnumerable<Category> Categorys { get; set; }
        public IEnumerable<Reader> Readers { get; set; }
        public IEnumerable<Borrow> Borrows { get; set; }
        public IEnumerable<Fine> Fines { get; set; }
    }
}