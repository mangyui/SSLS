using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SSLS.WebUI.Infrastructure.Abstract
{
    public interface IAuthProvider
    {
        bool Authenticate(string userName, string password);
        void ToOut();
        string GetName();
    }
}