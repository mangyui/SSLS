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
        public void ProcessBorrow(List<Book> books, Reader reader)
        {
            using (var db = new LibraryEntities())
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
        }
        public bool ProcessReturn(int borrowId, Reader reader)
        {
            using (var db = new LibraryEntities())
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
        }
        public bool Renew(int borrowId, Reader reader)
        {
            using (var db = new LibraryEntities())
            {
                using (var dbContextTransaction = db.Database.BeginTransaction())
                {                              //使用数据库事务
                    try
                    {
                        Borrow borrowEntry = db.Borrow.Find(borrowId);
                        if (borrowEntry.Reader_ID==reader.Id&&borrowEntry.State == "在借" && borrowEntry.Renew=="否")
                        {
                            borrowEntry.ShouldDate = borrowEntry.ShouldDate.AddMonths(1);
                            borrowEntry.Renew = "是";
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
        }
    }
}
