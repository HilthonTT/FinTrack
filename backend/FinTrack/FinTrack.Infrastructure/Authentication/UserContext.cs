﻿using FinTrack.Application.Abstractions.Authentication;
using Microsoft.AspNetCore.Http;

namespace FinTrack.Infrastructure.Authentication;

internal sealed class UserContext(IHttpContextAccessor httpContextAccessor) : IUserContext
{
    public Guid UserId =>
        httpContextAccessor
            .HttpContext?
            .User
            .GetUserId() ?? throw new ApplicationException("User context is unavailable");
}