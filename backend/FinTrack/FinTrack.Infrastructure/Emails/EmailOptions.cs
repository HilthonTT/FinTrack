namespace FinTrack.Infrastructure.Emails;

public class EmailOptions
{
    public const string ConfigurationSection = "Email";

    public required string SenderEmail { get; set; }

    public required string Host { get; set; }

    public required string Username { get; set; }

    public required string Password { get; set; }

    public required int Port { get; set; }
}
