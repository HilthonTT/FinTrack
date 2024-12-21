using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;

namespace FinTrack.Application.Subscriptions.Create;

public sealed record CreateSubscriptionCommand(
    Guid UserId,
    string Name, 
    decimal Amount, 
    string CurrencyCode,
    Frequency Frequency,
    Company Company,
    DateOnly StartDate,
    DateOnly EndDate) : ICommand<Guid>;
