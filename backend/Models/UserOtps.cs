
using System.ComponentModel.DataAnnotations;

namespace BackendAPI.Models
{
    public class UserOtps
    {
        [Key]
        public int OtpID { get; set; }
        public int UserID { get; set; }
        public required string OtpCode { get; set; }
        public DateTime CreatedAt { get; set; }
        public bool IsUsed { get; set; }
        

    }

    public class OtpRequest
    {
        public required string phone { get; set; }
    }
    }



