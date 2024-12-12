using MediatR;
using SharedKernel;

namespace FinTrack.Application.Abstractions.Messaging;

public interface IQuery<TResponse> : IRequest<Result<TResponse>>
{
}
