﻿using FinTrack.Domain.Users.Events;
using FinTrack.Domain.Users.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class User : Entity, IAuditable
{
    private readonly List<Role> _roles = [];

    private User(Guid id, Email email, Name name, string passwordHash)
        : base(id)
    { 
        Email = email;
        Name = name;
        PasswordHash = passwordHash;
        EmailVerified = false;
    }

    private User()
    {
    }

    public Email Email { get; private set; }

    public Name Name { get; private set; }

    public string PasswordHash { get; private set; }

    public bool EmailVerified { get; private set; }

    public DateTime CreatedOnUtc { get; set; }

    public DateTime? ModifiedOnUtc { get; set; }

    public IReadOnlyCollection<Role> Roles => _roles;

    public static User Create(Email email, Name name, string passwordHash)
    {
        var user = new User(Guid.NewGuid(), email, name, passwordHash);

        user.Raise(new UserCreatedDomainEvent(user.Id));

        return user;
    }

    public void VerifyEmail()
    {
        EmailVerified = true;
    }

    public void AddRole(Role role)
    {
        _roles.Add(role);
    }
}
