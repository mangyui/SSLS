using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;

namespace SSLS.WebUI.Models
{
    public class DetailViewModel
    {
        public Book Book { get; set; }
        public string category { get; set; }
    }
}