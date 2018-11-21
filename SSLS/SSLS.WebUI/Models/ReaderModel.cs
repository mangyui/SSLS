using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class ReaderModel
    {
        public Reader Reader { get; set; }
        public IEnumerable<Borrow> Borrows { get; set; }
        public IEnumerable<Fine> Fines { get; set; }
    }
}