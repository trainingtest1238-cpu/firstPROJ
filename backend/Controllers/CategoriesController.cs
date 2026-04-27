using Microsoft.AspNetCore.Mvc;
using BackendAPI.Data;
using BackendAPI.Models;
using Microsoft.AspNetCore.Authorization;

namespace BackendAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CategoriesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CategoriesController(AppDbContext context)
        {
            _context = context;
        }
        [Authorize]
        [HttpGet]
        public IActionResult GetCategories()
        {
            var categories = _context.Categories.ToList();
            return Ok(categories);
        }
    }
}