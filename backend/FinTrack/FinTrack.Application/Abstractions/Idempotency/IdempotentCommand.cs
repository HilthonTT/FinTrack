using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Abstractions.Idempotency;

public abstract record IdempotentCommand(Guid RequestId) : ICommand;

public abstract record IdempotentCommand<TResponse>(Guid RequestId) : ICommand<TResponse>;
