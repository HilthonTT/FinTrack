using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;
using FinTrack.Domain.Users;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Users.GetCurrent;

internal sealed class GetCurrentUserQueryHandler(
    IUserContext userContext,
    IDbConnectionFactory factory) : IQueryHandler<GetCurrentUserQuery, UserResponse>
{
    public async Task<Result<UserResponse>> Handle(GetCurrentUserQuery request, CancellationToken cancellationToken)
    {
        const string sql =
            """
            SELECT 
                u.id AS Id,
                u.email AS Email,
                u.name AS Name
            FROM users u
            WHERE u.id = @UserId
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        UserResponse? user = await connection.QueryFirstOrDefaultAsync<UserResponse>(
            sql,
            new { UserId = userContext.UserId });

        if (user is null)
        {
            return Result.Failure<UserResponse>(UserErrors.NotFound(userContext.UserId));
        }

        return user;
    }
}
