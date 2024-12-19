using backend.Entities;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories.EntitiesRepo
{
    public class OrderItemRepo : GenericRepo<OrderItem>
    {
        public OrderItemRepo(EcommerceDBContext context) : base(context)
        {
        }

        public async Task<IEnumerable<OrderItem>> GetOrderItemsByOrderId(int orderId)
        {
            var orderItems = await _context.OrderItems
                .Include(o => o.ProductSize)
                .ThenInclude(ps => ps.Product)
                .Where(o => o.OrderID == orderId) 
                .ToListAsync();
            return orderItems;
        }


    }
}
