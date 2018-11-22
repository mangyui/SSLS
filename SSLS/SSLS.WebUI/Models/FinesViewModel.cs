using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class FinesViewModel
    {
        public IEnumerable<Fine> Fines { get; set; }
        public PagingInfo PagingInfo { get; set; }

        public int IsFinish { get; set; }
    }
}