using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class CheckoutModel
    {
        public List<Book> Books { get; set; }

        public Reader Reader { get; set; }

    }
}