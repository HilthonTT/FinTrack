﻿using FinTrack.Domain.Users.Events;
using FinTrack.Domain.Users.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class User : Entity, IAuditable
{
    private User(Guid id, Email email, Name name, string passwordHash)
        : base(id)
    { 
        Email = email;
        Name = name;
        PasswordHash = passwordHash;
        EmailVerified = false;
    }

    public Email Email { get; private set; }

    public Name Name { get; private set; }

    public string PasswordHash { get; private set; }

    public bool EmailVerified { get; private set; }

    public DateTime CreatedOnUtc { get; }

    public DateTime? ModifiedOnUtc { get; }

    public static User Create(Email email, Name name, string passwordHash)
    {
        var user = new User(Guid.NewGuid(), email, name, passwordHash);

        user.Raise(new UserCreatedDomainEvent(user.Id));

        return user;
    }
}
