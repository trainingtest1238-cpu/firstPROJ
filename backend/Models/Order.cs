using System.ComponentModel.DataAnnotations;

namespace BackendAPI.Models
{
    public class Order
    {
        [Key]
        public int OrderID { get; set; }
        public decimal TotalPrice { get; set; }

        public DateTime OrderTime { get; set; }
    }
}
