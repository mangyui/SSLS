//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace SSLS.Domain.Concrete
{
    using System;
    using System.Collections.Generic;
    
    public partial class Reader
    {
        public Reader()
        {
            this.Borrow = new HashSet<Borrow>();
            this.Fine = new HashSet<Fine>();
        }
    
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Class { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public decimal Price { get; set; }
    
        public virtual ICollection<Borrow> Borrow { get; set; }
        public virtual ICollection<Fine> Fine { get; set; }
    }
}
