namespace FinTrack.Contracts.Emails;

public sealed record EmailVerificationEmailRequest(string EmailTo, int Code);
