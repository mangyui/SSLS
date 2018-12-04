using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSLS.Domain.Abstract;

namespace SSLS.Domain.Concrete
{
    public class DatabaseBorrowProcessor : IBorrowProcessor
    {
        private LibraryEntities db = new LibraryEntities();
        public void ProcessBorrow(List<Book> books, Reader reader)
        {
            using (var dbContextTransaction = db.Database.BeginTransaction())
            {                              //使用数据库事务
                try
                {
                        
                    foreach (var b in books)//根据购物车条目，添加订单明细对象到EF框架
                    {
                        Borrow borrow = new Borrow();
                        borrow.Book_ID = b.Id;
                        borrow.Reader_ID = reader.Id;
                        borrow.BorrowDate = DateTime.Now;
                        borrow.ShouldDate = DateTime.Now.AddMonths(1);
                        borrow.Renew = "否";
                        borrow.State = "在借";
                        db.Borrow.Add(borrow);   //添加订单对象到EF框架
                        Book bookEntry = db.Book.Find(b.Id);
                        bookEntry.Status = "外借";
                    }
                    db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                    dbContextTransaction.Commit();  //事务完成，提交
                }
                catch (Exception)
                {
                    dbContextTransaction.Rollback(); //出现异常，事务回滚，所有数据操作取消
                }
            }            
        }
        public bool ProcessReturn(int borrowId, Reader reader)
        {
            using (var dbContextTransaction = db.Database.BeginTransaction())
            {                              //使用数据库事务
                try
                {
                    Borrow borrowEntry = db.Borrow.Find(borrowId);
                    if (borrowEntry.Reader_ID==reader.Id&&borrowEntry.State == "在借")
                    {
                        int over=(DateTime.Now - borrowEntry.ShouldDate).Days;
                        if(over>0)
                        {
                            Fine fine = new Fine();
                            fine.Borrow_ID = borrowId;
                            fine.Reader_ID = reader.Id;
                            fine.OverDays = over;
                            fine.State = "待缴纳";
                            fine.Payment = (decimal)(over * 1);   // 1 默认每超期1天罚款1元
                            db.Fine.Add(fine);
                            borrowEntry.State = "超期";    //在借  超期  未超期
                        }
                        else
                        {
                            borrowEntry.State = "未超期";
                        }
                        borrowEntry.ReturnDate = DateTime.Now;

                        Book bookEntry = db.Book.Find(borrowEntry.Book_ID);
                        bookEntry.Status = "在库";
                        db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                        dbContextTransaction.Commit();  //事务完成，提交
                        return true;
                    }
                    return false;
                }
                catch (Exception)
                {
                    dbContextTransaction.Rollback(); //出现异常，事务回滚，所有数据操作取消
                    return false;
                }
            }
        }
        public int Renew(int borrowId,out string Timelimit)
        {
            Borrow borrowEntry = db.Borrow.Find(borrowId);
            if (borrowEntry.State == "在借" && borrowEntry.Renew=="否")
            {
                borrowEntry.ShouldDate = borrowEntry.ShouldDate.AddMonths(1);
                borrowEntry.Renew = "是";
                db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                int days = (borrowEntry.ShouldDate - DateTime.Now).Days;
                if(days>=0)
                {
                    Timelimit = days + "天到期";
                    return 0;
                }
                else
                {
                    days=-days;
                    Timelimit="超期"+days+"天";
                    return 1;
                }

            }
            Timelimit = "";
            return -1;      
        }
       public int PayMoney(int findId,out string msg)
        {
            using (var dbContextTransaction = db.Database.BeginTransaction())
            {                              //使用数据库事务
                try
                {
                    Fine fineEntry = db.Fine.Find(findId);
                    if (fineEntry.State=="待缴纳")
                    {
                        Reader readerEntity = db.Reader.Find(fineEntry.Reader_ID);
                        if (readerEntity.Price < fineEntry.Payment)
                        {
                            msg = "您的账户余额不足！";
                            return 0;
                        }
                        readerEntity.Price = readerEntity.Price - fineEntry.Payment;
                        fineEntry.State = "已缴纳";
                        db.SaveChanges();  //保存更改，EF框架的数据对象修改部分会同步更新到数据库
                        dbContextTransaction.Commit();  //事务完成，提交
                        msg = "缴纳成功！";
                        return 1;
                    }
                    msg = "缴纳失败！"; 
                    return -1;
                }
                catch (Exception)
                {
                    dbContextTransaction.Rollback(); //出现异常，事务回滚，所有数据操作取消
                    msg = "缴纳失败！"; 
                    return -1;
                }
            }
        }      
    }
}
