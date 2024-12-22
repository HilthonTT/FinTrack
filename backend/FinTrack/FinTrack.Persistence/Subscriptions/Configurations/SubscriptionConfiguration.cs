using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Users;
using FinTrack.Persistence.Constants;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Subscriptions.Configurations;

internal sealed class SubscriptionConfiguration : IEntityTypeConfiguration<Subscription>
{
    public void Configure(EntityTypeBuilder<Subscription> builder)
    {
        builder.ToTable(TableNames.Subscriptions);

        builder.HasKey(s => s.Id);

        builder.Property(s => s.Name).HasMaxLength(256).IsRequired();

        builder.OwnsOne(x => x.Amount, amountBuilder =>
        {
            amountBuilder.Property(money => money.Currency)
                .HasConversion(currency => currency.Code, code => Currency.FromCode(code) ?? Currency.None);
        });

        builder.HasOne<User>()
            .WithMany()
            .HasForeignKey(b => b.UserId)
            .IsRequired();

        builder.OwnsOne(x => x.SubscriptionPeriod);

        builder.HasIndex(b => new { b.Name })
            .HasMethod("GIN")
            .IsTsVectorExpressionIndex("english");

        // optimistic concurrency support
        builder.Property<uint>("Version").IsRowVersion();
    }
}
