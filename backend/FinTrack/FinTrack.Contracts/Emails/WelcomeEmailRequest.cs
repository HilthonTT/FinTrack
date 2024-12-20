namespace FinTrack.Contracts.Emails;

public sealed record WelcomeEmailRequest(string EmailTo, string name);
