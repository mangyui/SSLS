﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSLS.Domain.Concrete;

namespace SSLS.Domain.Abstract
{
    public interface IBorrowProcessor
    {
        void ProcessBorrow(List<Book> books, Reader reader);
        bool ProcessReturn(int borrowId, Reader reader);
        int Renew(int borrowId, out string Timelimit);
        int PayMoney(int findId, out string msg);
    }
}
