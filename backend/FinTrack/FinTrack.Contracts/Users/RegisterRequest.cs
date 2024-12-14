namespace FinTrack.Contracts.Users;

public sealed record RegisterRequest(string Email, string Name, string Password);
