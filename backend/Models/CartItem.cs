namespace BackendAPI.Models
{
public class CartItem {
    public int CartItemID { get; set; }
    public int UserID { get; set; }
    public int productID { get; set; }
    public int Quantity { get; set; }
}
}