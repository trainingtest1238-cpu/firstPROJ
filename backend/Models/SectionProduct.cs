namespace BackendAPI.Models
{
    public class SectionProduct
    {
        public int id { get; set; }
        public int sectionid { get; set; }
        public Section Section { get; set; }
        public int productid  { get; set; }
        public Product Product { get; set; }
    }

}