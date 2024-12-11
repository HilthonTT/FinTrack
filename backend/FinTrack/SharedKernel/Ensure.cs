﻿using System.Diagnostics.CodeAnalysis;
using System.Runtime.CompilerServices;

namespace SharedKernel;

public static class Ensure
{
    public static void NotNullOrWhitespace(
        [NotNull] string? value, 
        [CallerArgumentExpression(nameof(value))] string? paramName = default)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            throw new ArgumentNullException(paramName);
        }
    }

    public static void GreaterThanZero(
        decimal value,
        [CallerArgumentExpression(nameof(value))] string? paramName = default)
    {
        if (value <= 0)
        {
            throw new ArgumentOutOfRangeException(paramName);
        }
    }

    public static void StartDatePrecedesEndDate(
        DateTime start,
        DateTime end,
        [CallerArgumentExpression(nameof(end))] string? paramName = default)
    {
        if (start >= end)
        {
            throw new ArgumentOutOfRangeException(paramName);
        }
    }
}
