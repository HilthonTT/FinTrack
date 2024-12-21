using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;

namespace FinTrack.Application.Subscriptions.Update;

public sealed record UpdateSubscriptionCommand(
    Guid SubscriptionId, 
    string Name,
    Frequency Frequency, 
    Company Company) : ICommand;
