using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class ReadersListModel
    {
        public IEnumerable<Reader> Readers { get; set; }
        public PagingInfo PagingInfo { get; set; }
    }
}