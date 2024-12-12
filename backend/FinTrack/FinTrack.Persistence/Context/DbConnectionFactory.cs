using FinTrack.Application.Abstractions.Data;
using Npgsql;
using System.Data;

namespace FinTrack.Persistence.Context;

internal sealed class DbConnectionFactory(NpgsqlDataSource dataSource) : IDbConnectionFactory
{
    public async Task<IDbConnection> GetOpenConnectionAsync(CancellationToken cancellationToken = default)
    {
        NpgsqlConnection connection = await dataSource.OpenConnectionAsync(cancellationToken);

        return connection;
    }
}
