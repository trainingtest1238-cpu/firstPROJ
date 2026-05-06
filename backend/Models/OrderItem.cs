using System.ComponentModel.DataAnnotations;

namespace first.Models
{
    public class OrderItem
    {
        [Key]
        public int OrderItemID { get; set; }

        public int OrderID { get; set; }

        public int  ProductID { get; set; }

        public int Quantity { get; set; }

        public decimal ProductPrice { get; set; }
    }
}
