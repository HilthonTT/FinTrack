using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Subscriptions.Delete;

public sealed record DeleteSubscriptionCommand(Guid SubscriptionId) : ICommand;
