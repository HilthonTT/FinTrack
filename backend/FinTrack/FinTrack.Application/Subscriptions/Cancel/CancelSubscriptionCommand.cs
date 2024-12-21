using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Subscriptions.Cancel;

public sealed record CancelSubscriptionCommand(Guid SubscriptionId) : ICommand;
