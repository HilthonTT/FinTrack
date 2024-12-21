using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using MediatR;
using Microsoft.Extensions.Logging;
using System.Data;

namespace FinTrack.Application.Abstractions.Behaviors;

internal sealed class TransactionalPipelineBehavior<TRequest, TResponse>(
    ILogger<TransactionalPipelineBehavior<TRequest, TResponse>> logger,
    IUnitOfWork unitOfWork) : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IBaseCommand
{
    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        string requestName = typeof(TRequest).Name;

        logger.LogInformation("Beginning transaction for {RequestName}", requestName);

        using IDbTransaction transaction = await unitOfWork.BeginTransactionAsync(cancellationToken);

        try
        {
            TResponse response = await next();

            transaction.Commit();

            logger.LogInformation("Committed transaction for {RequestName}", requestName);

            return response;
        }
        catch (Exception)
        {
            transaction.Rollback();
            throw;
        }
    }
}
