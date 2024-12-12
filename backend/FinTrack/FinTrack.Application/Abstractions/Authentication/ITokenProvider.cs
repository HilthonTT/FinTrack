using FinTrack.Domain.Users;

namespace FinTrack.Application.Abstractions.Authentication;

public interface ITokenProvider
{
    string Create(User user);
}
