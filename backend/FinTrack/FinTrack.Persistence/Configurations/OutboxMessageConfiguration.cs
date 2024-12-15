using FinTrack.Persistence.Constants;
using FinTrack.Persistence.Outbox;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Configurations;

internal sealed class OutboxMessageConfiguration : IEntityTypeConfiguration<OutboxMessage>
{
    public void Configure(EntityTypeBuilder<OutboxMessage> builder)
    {
        builder.ToTable(TableNames.OutboxMessages);

        builder.Property(o => o.Content).HasColumnType("jsonb");

        builder.HasIndex(o => new { o.OccurredOnUtc, o.ProcessedOnUtc })
            .HasDatabaseName("idx_outbox_messages_unprocessed")
            .HasFilter("processed_on_utc IS NULL");
    }
}
