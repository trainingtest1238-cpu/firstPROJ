using Microsoft.AspNetCore.Mvc;
using BackendAPI.Data;
using BackendAPI.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using first.Models;

namespace BackendAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CartController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CartController(AppDbContext context)
        {
            _context = context;
        }

        [Authorize]
        [HttpPost("add")]
        public IActionResult AddrToCart([FromBody] CartItem item)
        { 
        var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
        var existing =_context.CartItems.FirstOrDefault(c=>c.UserID == userId && c.productID==item.productID);

        if (existing != null)
            {
                existing.Quantity+=item.Quantity;
            }
            else
            {
                item.UserID=userId;
                _context.CartItems.Add(item);
            }
            _context.SaveChanges();
            return Ok("added to cart");
        }
        [Authorize]
        [HttpGet]
        public IActionResult GetCart()
        {
            var userId= int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);

            var cart = _context.CartItems.Where(c => c.UserID == userId).Join(_context.Products, cart => cart.productID, product => product.ProductID, (cart, product) => new { 
            cartItemID=cart.CartItemID,
            productID=product.ProductID,
            productPrice=product.ProductPrice,
            productImage=product.ProductImage,
            quantity=cart.Quantity,
            }).ToList();

            return Ok(cart);

        }
        [Authorize]
        [HttpPut("update/{cartItemID}/{quantity}")]
        public async Task<IActionResult> UpdateQuantity(int cartItemID, int quantity)
        {
            var item = await _context.CartItems.FindAsync(cartItemID);
            if (item == null)
                return NotFound("item not found ");
            if (quantity <= 0)
                return BadRequest("Quantity must be greater than 0");

            item.Quantity = quantity;
            await _context.SaveChangesAsync();

            return Ok(item);
        }
        [Authorize]
        [HttpDelete("remove/{cartItemID}")]
        public async Task<IActionResult> RemoveFromCart(int cartItemID) {
            var item = await _context.CartItems.FindAsync(cartItemID);
            if (item == null)
                return NotFound("item not found ");

            _context.CartItems.Remove(item);
            await _context.SaveChangesAsync();

            return Ok("Item removed");
                }
        [Authorize]
        [HttpDelete("clear")]
        public async Task<IActionResult> ClearCart() {

            var items = _context.CartItems.ToList;
            _context.CartItems.RemoveRange();
            await _context.SaveChangesAsync();

            return Ok("Cart Cleared");
        }
        [Authorize]
        [HttpPost("checkout")]
        public async Task<IActionResult> Checkout()
        {
            var cartItems = _context.CartItems.ToList();

            if (!cartItems.Any())
                return BadRequest("the cart is empty");

            decimal total = 0;

            foreach (var item in cartItems)
            {
                var product = await _context.Products.FindAsync(item.productID);
                if (product == null)
                    return NotFound($"Product with ID {item.productID} not found");

                total += product.ProductPrice * item.Quantity;
            }

            var order = new Order
            {
                TotalPrice = total,
                OrderTime = DateTime.Now,
            };

            _context.Orders.Add(order);
            await _context.SaveChangesAsync();

            foreach (var item in cartItems)
            {
                var product = await _context.Products.FindAsync(item.productID);

                var orderItem = new OrderItem
                {
                    OrderID = order.OrderID,
                    ProductID = item.productID,
                    Quantity = item.Quantity,
                    ProductPrice = product.ProductPrice
                };

                _context.OrderItems.Add(orderItem);
            }

            _context.CartItems.RemoveRange(cartItems);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Order Placed Successfully",
                orderID = order.OrderID,
                total = total
            });
        }
    }
}