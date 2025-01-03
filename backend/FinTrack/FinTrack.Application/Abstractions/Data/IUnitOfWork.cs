﻿using Microsoft.EntityFrameworkCore;
using System.Data;

namespace FinTrack.Application.Abstractions.Data;

public interface IUnitOfWork
{
    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);

    Task<IDbTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default);

    DbContext Context { get; }
}
