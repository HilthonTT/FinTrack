﻿using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public static class NameErrors
{
    public static readonly Error Empty = Error.Problem("Name.Empty", "The name is empty");

    public static readonly Error TooLong = Error.Problem("Name.TooLong", "The name is too long");
}
