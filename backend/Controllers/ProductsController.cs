using Microsoft.AspNetCore.Mvc;
using BackendAPI.Data;
using BackendAPI.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Authorization;

namespace BackendAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly AppDbContext _context;
        public ProductsController(AppDbContext context)
        {
            _context = context;
        }
        [Authorize]
        [HttpGet]
        public IActionResult
            GetProducts()
        {
            var products = _context.Products.Include(p => p.Category).ToList();
            return Ok(products);
        }
        [Authorize]
        [HttpGet("by-category/{categoryId}")]
        public IActionResult GetProductsByCategory(int categoryId)
        {
            var products = _context.Products
                .Where(p => p.CategoryID == categoryId)
                .Include(p => p.Category)
                .ToList();

            return Ok(products);
        }
        [Authorize]
        [HttpGet("home")]
        public IActionResult GetHomeData()
        {
            var result = _context.Sections
                .Where(s => s.isactive)
                .Select(s => new
                {
                    s.sectionID,
                    s.sectionname,
                    s.Sectiontybe,
                    Products = _context.SectionProducts
                        .Where(sp => sp.sectionid == s.sectionID)
                        .Join(
                            _context.Products,
                            sp => sp.productid,
                            p => p.ProductID,
                            (sp, p) => new
                            {
                                p.ProductID,
                                p.ProductName,
                                p.ProductPrice,
                                p.ProductImage
                            }
                        )
                        .ToList()
                })
                .ToList();

            return Ok(result);
        }
        [Authorize]
        [HttpGet("search")]
        public IActionResult Search(string query)
        {
            var products = _context.Products.Where(P => P.ProductName.Contains(query)||P.Category.CategoryName.Contains(query)).ToList();
            return Ok(products);
        }
        [Authorize]
        [HttpGet("{id}")]
        public IActionResult GetProductById(int id)
        {
            var product = _context.Products.Include(p => p.Category).FirstOrDefault(p => p.ProductID == id);

            if (product == null)
            {
                return NotFound("product not found");
            }
            return Ok(product);
        }
    }
}
