using System.Text.Json;
using System.Text.Json.Serialization;

namespace FinTrack.Api.Infrastructure;

internal sealed class DateOnlyJsonConverter : JsonConverter<DateOnly>
{
    private static readonly string[] SupportedFormats =
    {
        "yyyy-MM-dd", // Standard format
        "yyyy-M-d",   // Without leading zeroes
        "yyyy-MM-d",  // Mixed formats
        "yyyy-M-dd"   // Mixed formats
    };

    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        string? value = reader.GetString();
        if (string.IsNullOrWhiteSpace(value))
        {
            throw new JsonException("The date value is null.");
        }

        foreach (string format in SupportedFormats)
        {
            if (DateOnly.TryParseExact(value, format, null, System.Globalization.DateTimeStyles.None, out DateOnly date))
            {
                return date;
            }
        }

        throw new JsonException($"Unable to convert \"{value}\" to {nameof(DateOnly)}. Supported formats: {string.Join(", ", SupportedFormats)}.");
    }

    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString(SupportedFormats[0])); // Always output in "yyyy-MM-dd"
    }
}
