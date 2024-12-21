namespace FinTrack.Domain.Shared.ValueObjects;

public sealed record Currency
{
    public static readonly Currency None = new("");
    public static readonly Currency Usd = new("USD");
    public static readonly Currency Eur = new("EUR");
    public static readonly Currency Gbp = new("GBP"); // British Pound
    public static readonly Currency Jpy = new("JPY"); // Japanese Yen
    public static readonly Currency Aud = new("AUD"); // Australian Dollar
    public static readonly Currency Cad = new("CAD"); // Canadian Dollar
    public static readonly Currency Chf = new("CHF"); // Swiss Franc
    public static readonly Currency Cny = new("CNY"); // Chinese Yuan
    public static readonly Currency Inr = new("INR"); // Indian Rupee
    public static readonly Currency Zar = new("ZAR"); // South African Rand

    private Currency(string code) => Code = code;

    public string Code { get; init; }

    public static Currency? FromCode(string code)
    {
        return All.FirstOrDefault(x => x.Code.Equals(code, StringComparison.InvariantCultureIgnoreCase));
    }

    public static bool Any(string code)
    {
        return All.Any(x => x.Code.Equals(code, StringComparison.InvariantCultureIgnoreCase));
    }

    private static readonly IReadOnlyCollection<Currency> All =
    [
        Usd, Eur, Gbp, Jpy, Aud, Cad, Chf, Cny, Inr, Zar
    ];
}
