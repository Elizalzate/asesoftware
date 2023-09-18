using Core;
using Microsoft.EntityFrameworkCore;

namespace Data;

public class DatabaseConnection : DbContext
{
    public DatabaseConnection(DbContextOptions options) : base(options)
    {
    }

}
