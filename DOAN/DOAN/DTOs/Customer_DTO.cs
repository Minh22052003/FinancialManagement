namespace DOAN.DTOs
{
    public class Customer_DTO
    {
        public int CustomerId { get; set; }
        public string FullName { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string IdentityNumber { get; set; }

    }
}
