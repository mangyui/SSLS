using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class BorrowViewModel
    {
        public IEnumerable<Borrow> Borrows { get; set; }
        public PagingInfo PagingInfo { get; set; }

        public int CurrentCategoryId { get; set; }

    }
}