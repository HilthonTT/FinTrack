using FinTrack.Application.Abstractions.Idempotency;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace FinTrack.Persistence.Idempotency;

internal sealed class IdempotencyService(
    AppDbContext dbContext, 
    IDateTimeProvider dateTimeProvider) : IIdempotencyService
{
    public async Task CreateRequestAsync(Guid requestId, string name, CancellationToken cancellationToken = default)
    {
        var idempotentRequest = new IdempotentRequest
        {
            Id = requestId,
            Name = name,
            CreatedOnUtc = dateTimeProvider.UtcNow,
        };

        dbContext.IdempotentRequests.Add(idempotentRequest);

        await dbContext.SaveChangesAsync(cancellationToken);
    }

    public Task<bool> RequestExistsAsync(Guid requestId, CancellationToken cancellationToken = default)
    {
        return dbContext.IdempotentRequests.AnyAsync(r => r.Id == requestId, cancellationToken);
    }
}
