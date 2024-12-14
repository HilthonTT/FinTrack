using SharedKernel;

namespace FinTrack.Domain.Shared.ValueObjects;

public sealed record Money
{
    public Money(decimal amount, Currency currency)
    {
        Ensure.GreaterThanZero(amount);
        Ensure.NotNull(currency, nameof(currency));

        Amount = amount;
        Currency = currency;
    }

    public decimal Amount { get; init; }

    public Currency Currency { get; init; }

    public static Money operator +(Money first, Money second)
    {
        if (first.Currency != second.Currency)
        {
            throw new InvalidOperationException("Currencies have to be equals");
        }

        return new Money(first.Amount + second.Amount, first.Currency);
    }

    public static Money Zero() => new(0, Currency.None);

    public static Money Zero(Currency currency) => new(0, currency);

    public bool IsZero() => this == Zero(Currency);

    public Money ChangeAmount(decimal amount)
    {
        return new(amount, Currency);
    }
}
