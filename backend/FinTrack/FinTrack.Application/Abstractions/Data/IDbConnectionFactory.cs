using System.Data;

namespace FinTrack.Application.Abstractions.Data;

public interface IDbConnectionFactory
{
    Task<IDbConnection> GetOpenConnectionAsync(CancellationToken cancellationToken = default);
}
