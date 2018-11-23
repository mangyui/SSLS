using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SSLS.WebUI.Models
{
    public class ReaderModifyModel
    {
        public string Code { get; set; }
        [Required(ErrorMessage = "请输入名称")]
        public string Name { get; set; }
        [Required(ErrorMessage = "请输入所在班级")]
        public string Class { get; set; }
        [Required(ErrorMessage = "请输入您的邮箱")]
        [RegularExpression(".+\\@.+\\..+", ErrorMessage = "请输入正确的电子邮件！")]
        public string Email { get; set; }
    }
}