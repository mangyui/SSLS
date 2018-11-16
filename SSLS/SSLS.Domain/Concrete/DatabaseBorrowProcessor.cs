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
                            borrow.ReturnDate = DateTime.Now.AddDays(10);
                            borrow.Renew = "否";
                            borrow.State = "在借";
                            db.Borrow.Add(borrow);   //添加订单对象到EF框架
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
    }
}
