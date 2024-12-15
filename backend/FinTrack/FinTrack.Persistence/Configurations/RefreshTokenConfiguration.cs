using FinTrack.Domain.Users;
using FinTrack.Persistence.Constants;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Configurations;

internal sealed class RefreshTokenConfiguration : IEntityTypeConfiguration<RefreshToken>
{
    public void Configure(EntityTypeBuilder<RefreshToken> builder)
    {
        builder.ToTable(TableNames.RefreshToken);

        builder.HasKey(r => r.Id);

        builder.Property(r => r.Token).HasMaxLength(200);

        builder.HasOne(r => r.User)
            .WithMany()
            .HasForeignKey(r => r.UserId);

        builder.HasIndex(r => r.Token).IsUnique();
    }
}
