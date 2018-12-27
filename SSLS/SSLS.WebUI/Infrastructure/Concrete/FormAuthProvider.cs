using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using SSLS.WebUI.Infrastructure.Abstract;
using SSLS.Domain.Abstract;
using SSLS.Domain.Concrete;


namespace SSLS.WebUI.Infrastructure.Concrete
{
    public class FormAuthProvider : IAuthProvider
    {
        private LibraryEntities db = new LibraryEntities();
        public bool Authenticate(string userName,bool result)
        {
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
    }
}