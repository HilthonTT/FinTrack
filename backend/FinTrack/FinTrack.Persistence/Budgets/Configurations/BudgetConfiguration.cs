﻿using FinTrack.Domain.Budget;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Users;
using FinTrack.Persistence.Constants;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Budgets.Configurations;

internal sealed class BudgetConfiguration : IEntityTypeConfiguration<Budget>
{
    public void Configure(EntityTypeBuilder<Budget> builder)
    {
        builder.ToTable(TableNames.Budgets);

        builder.HasKey(b => b.Id);

        builder.Property(b => b.Name).HasMaxLength(256);

        builder.OwnsOne(x => x.Amount, amountBuilder =>
        {
            amountBuilder.Property(money => money.Currency)
                .HasConversion(currency => currency.Code, code => Currency.FromCode(code) ?? Currency.None);
        });

        builder.OwnsOne(x => x.Spent, spentBuilder =>
        {
            spentBuilder.Property(money => money.Currency)
                .HasConversion(currency => currency.Code, code => Currency.FromCode(code) ?? Currency.None);
        });

        builder.HasOne<User>()
            .WithMany()
            .HasForeignKey(b => b.UserId)
            .IsRequired();

        builder.OwnsOne(x => x.DateRange);

        builder.Ignore(b => b.Remaining);

        builder.HasIndex(b => new { b.Name })
            .HasMethod("GIN")
            .IsTsVectorExpressionIndex("english");
    }
}
