namespace BackendAPI.Models
{
    public class Product
    {
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public decimal ProductPrice { get; set; }
        public string ProductImage { get; set; }
        public int CategoryID { get; set; }
        public Category Category { get; set; }
        public bool isactive { get; set; }


    }
}
