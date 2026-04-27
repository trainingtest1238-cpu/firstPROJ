using BackendAPI.Data;
using BackendAPI.Models;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.AspNetCore.Authorization;
namespace BackendAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]

    public class UsersController :
        ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly AppDbContext _context;
        public UsersController(AppDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }
        private string GenerateJwtToken(User user)
        {
            var jwtSettings = _configuration.GetSection("Jwt");

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(jwtSettings["Key"])
            );

            var claims = new[]
            {
        new Claim(ClaimTypes.NameIdentifier, user.UserID.ToString()),
        new Claim(ClaimTypes.MobilePhone, user.phone ?? "")
    };

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtSettings["Issuer"],
                audience: jwtSettings["Audience"],
                claims: claims,
                expires: DateTime.Now.AddDays(int.Parse(jwtSettings["DurationInDays"])),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
        [Authorize]
        [HttpGet]
        public IActionResult GetUsers()
        {
            var users = _context.Users.ToList();
            return Ok(users);
        }
        
        [HttpPost("register")]
        public IActionResult Register(User user)
        {
            _context.Users.Add(user);
            _context.SaveChanges();

            return Ok(user);
        }
        
        [HttpPost("login")]
        public IActionResult Login([FromBody] User user)
        {
            var existingUser = _context.Users.FirstOrDefault(u => u.phone == user.phone);

            if (existingUser == null)
            {
                return NotFound("Invalid phone number");
            }


            var existingOtp = _context.UserOtps.FirstOrDefault(o => o.UserID == existingUser.UserID && o.IsUsed == false);
            var otp = new Random().Next(1000,9999).ToString();
            if (existingOtp == null)
            {
                var userOtp = new UserOtps
                {
                    UserID = existingUser.UserID,
                    OtpCode = otp,
                    CreatedAt = DateTime.Now,
                    IsUsed = false
                };
                _context.UserOtps.Add(userOtp);
            }
            else {
                existingOtp.OtpCode = otp;
                existingOtp.CreatedAt = DateTime.Now;
                existingOtp.IsUsed = false;
            }
            _context.SaveChanges();
            return Ok(new
            {
                message = "OTP sent",
                otp = otp, 
                userId = existingUser.UserID,
                firstName =existingUser.FirstName,
                lastName =existingUser.LastName
            });
        }
        
        [HttpPost("verify-otp")]
        public IActionResult VerifyOtp([FromBody] UserOtps request)
        {
            var otpRecord = _context.UserOtps
                .Where(o => o.UserID == request.UserID && o.OtpCode == request.OtpCode && o.IsUsed == false)
                .OrderByDescending(o => o.CreatedAt)
                .FirstOrDefault();

            if (otpRecord == null)
            {
                return BadRequest("Invalid OTP");
            }
            if (DateTime.Now > otpRecord.CreatedAt.AddMinutes(5)) {
                return BadRequest("Otp expired");
            }
            otpRecord.IsUsed = true;
            _context.SaveChanges();

            var user = _context.Users.FirstOrDefault(u => u.UserID == request.UserID);
            var token = GenerateJwtToken(user);
            return Ok(new
            { 
            token =token,
            userid=user.UserID,
            firstName=user.FirstName,
            lastName=user.LastName,
            phone=user.phone
            }
                );
        }
        
        [HttpPost("resend-otp")]
        public IActionResult ResendOtp([FromBody] OtpRequest req)
        {
            if (req == null || string.IsNullOrEmpty(req.phone))
                return BadRequest("Phone is required");

            var existingUser = _context.Users
                .FirstOrDefault(u => u.phone == req.phone);

            if (existingUser == null)
                return NotFound("Invalid phone number");

            var existingOtp = _context.UserOtps
                .Where(o => o.UserID == existingUser.UserID && !o.IsUsed)
                .OrderByDescending(o => o.CreatedAt)
                .FirstOrDefault();

            
            if (existingOtp != null && DateTime.UtcNow < existingOtp.CreatedAt.AddMinutes(2))
            {
                return BadRequest("Please wait 2 minutes before requesting a new OTP");
            }

            
            var otp = new Random().Next(1000, 9999).ToString();

            if (existingOtp == null)
            {
                var userOtp = new UserOtps
                {
                    UserID = existingUser.UserID,
                    OtpCode = otp,
                    CreatedAt = DateTime.UtcNow,
                    IsUsed = false
                };

                _context.UserOtps.Add(userOtp);
            }
            else
            {
                existingOtp.OtpCode = otp;
                existingOtp.CreatedAt = DateTime.UtcNow;
                existingOtp.IsUsed = false;
            }

            _context.SaveChanges();

           
            return Ok(new
            {
                message = "OTP resent",
                otp = otp,
                userId = existingUser.UserID
            });
        }
        [Authorize]
        [HttpGet("{id}")]
        public IActionResult GetUserById(int id)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserID == id);

            if (user == null) {
                return NotFound("User not found");
            }
            return Ok(user);
        }
        [Authorize]
        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserID == id);
            if (user == null)
            {
                return Unauthorized("Invalid phone number");
            }
            _context.Users.Remove(user);
            _context.SaveChanges();

            return Ok("user deleted successfully");
        }
        [Authorize]
        [HttpPut("{id}")]
        public IActionResult UpadateUser(int id, User updatesUser)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserID == id);

            if (user == null) {
                return NotFound("user not found");
            }
            user.FirstName= updatesUser.FirstName;
            user.LastName= updatesUser.LastName;
            user.phone = updatesUser.phone;

            _context.SaveChanges();

            return Ok(user);
        }
       
    }

}
