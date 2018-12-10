using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using SSLS.Domain.Abstract;
using System.Web.Mvc;
using System.Text;
using System.IO;

namespace SSLS.WebUI.Infrastructure
{
    public static class Utils
    {
        public static string GetImageSaveName(string rawFileName)
        {
            Random TempInt = new Random();
            byte[] result = Encoding.Default.GetBytes(TempInt.Next().ToString());
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] output = md5.ComputeHash(result);
            string randomString = BitConverter.ToString(output).Replace("-", "").Substring(0, 4);

            string fileExtName = Path.GetExtension(rawFileName);
            string fileName = DateTime.Now.ToString("yyyyMMddhhmmss") + randomString;
            return fileName + fileExtName;
        }

        public static IEnumerable<SelectListItem> GetCategorySelectListItem(IBooksRepository repository)
        {
            return repository.Categories.ToList().Select(
                c => new SelectListItem { Value = c.Id.ToString(), Text = c.Name });
        }

    }
}