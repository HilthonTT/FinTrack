using MediatR;
using Microsoft.Extensions.Logging;

namespace FinTrack.Application.Abstractions.Behaviors;

internal sealed class ExceptionHandlingPipelineBehavior<TRequest, TResponse>(
    ILogger<ExceptionHandlingPipelineBehavior<TRequest, TResponse>> logger)
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : class
{
    public Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        try
        {
            return next();
        }
        catch (Exception exception)
        {
            string requestName = typeof(TRequest).Name;
            logger.LogError(exception, "Unhandled exception for {RequestName}", requestName);

            throw;
        }
    }
}
