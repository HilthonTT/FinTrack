﻿using FinTrack.Persistence.Constants;
using FinTrack.Persistence.Idempotency;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Idempotency.Configurations;

internal sealed class IdempotentRequestConfiguration : IEntityTypeConfiguration<IdempotentRequest>
{
    public void Configure(EntityTypeBuilder<IdempotentRequest> builder)
    {
        builder.ToTable(TableNames.IdempotentRequests);

        builder.HasKey(ir => ir.Id);

        builder.Property(ir => ir.Name).IsRequired();
    }
}
