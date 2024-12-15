using SharedKernel;

namespace FinTrack.Domain.Shared.ValueObjects;

public sealed record Money : IComparable<Money>
{
    public Money(decimal amount, Currency currency)
    {
        Ensure.NotNull(currency, nameof(currency));

        Amount = amount;
        Currency = currency;
    }

    public decimal Amount { get; init; }

    public Currency Currency { get; init; }

    public static Money operator +(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return new Money(first.Amount + second.Amount, first.Currency);
    }

    public static Money operator -(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return new Money(first.Amount - second.Amount, first.Currency);
    }

    public static bool operator >(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return first.Amount > second.Amount;
    }

    public static bool operator <(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return first.Amount < second.Amount;
    }

    public static bool operator >=(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return first.Amount >= second.Amount;
    }

    public static bool operator <=(Money first, Money second)
    {
        ValidateSameCurrency(first, second);
        return first.Amount <= second.Amount;
    }

    public int CompareTo(Money? other)
    {
        ArgumentNullException.ThrowIfNull(other, nameof(other));

        ValidateSameCurrency(this, other);

        return Amount.CompareTo(other.Amount);
    }

    public static Money Zero() => new(0, Currency.None);

    public static Money Zero(Currency currency) => new(0, currency);

    public bool IsZero() => Amount == 0;

    public Money ChangeAmount(decimal amount) => new(amount, Currency);

    private static void ValidateSameCurrency(Money first, Money second)
    {
        if (first.Currency != second.Currency)
        {
            throw new InvalidOperationException("Currencies must match for comparison or arithmetic operations.");
        }
    }
}
