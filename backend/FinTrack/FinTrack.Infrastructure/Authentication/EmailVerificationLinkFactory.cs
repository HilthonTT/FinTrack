using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Users;
using FinTrack.Domain.Users;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using SharedKernel;

namespace FinTrack.Infrastructure.Authentication;

internal sealed class EmailVerificationLinkFactory(
    IHttpContextAccessor httpContextAccessor,
    LinkGenerator linkGenerator) : IEmailVerificationLinkFactory
{
    public string Create(EmailVerificationToken emailVerificationToken)
    {
        string? verificationLink = linkGenerator.GetUriByName(
            httpContextAccessor.HttpContext!,
            UserEndpoints.VerifyEmail,
            new { token = emailVerificationToken.Id });

        Ensure.NotNullOrWhitespace(verificationLink, nameof(verificationLink));

        return verificationLink;
    }
}
