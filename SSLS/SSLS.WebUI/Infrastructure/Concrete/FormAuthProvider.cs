using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using SSLS.WebUI.Infrastructure.Abstract;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;


namespace SSLS.WebUI.Infrastructure.Concrete
{
    public class FormAuthProvider : IAuthProvider
    {
        private LibraryEntities db = new LibraryEntities();
        public bool Authenticate(string userName, string password)
        {

            Admin AdminEntry = db.Admin.FirstOrDefault(c =>
                    c.UserName == userName && c.Password == password);
            bool result = AdminEntry==null?false:true;
            if (result)
            {
                FormsAuthentication.SetAuthCookie(userName, false);
            }
            return result;
        }
        public void ToOut()
        {
            FormsAuthentication.SignOut();
        }
        public string GetName()      //xxx
        {
            return FormsAuthentication.CookieDomain;
        }
    }
}