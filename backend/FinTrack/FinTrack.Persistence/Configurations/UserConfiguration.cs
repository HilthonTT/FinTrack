using FinTrack.Domain.Users;
using FinTrack.Domain.Users.ValueObjects;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FinTrack.Persistence.Configurations;

internal sealed class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasKey(u => u.Id);

        builder.OwnsOne(u => u.Email, emailBuilder =>
        {
            emailBuilder.WithOwner();

            emailBuilder.Property(e => e.Value)
                .HasColumnName("email")
                .HasMaxLength(Email.MaxLength)
                .IsRequired();

            emailBuilder.HasIndex(u => u.Value).IsUnique();
        });

        builder.OwnsOne(u => u.Name, nameBuilder =>
        {
            nameBuilder.WithOwner();

            nameBuilder.Property(e => e.Value)
                .HasColumnName("name")
                .HasMaxLength(Name.MaxLength)
                .IsRequired();
        });

        builder.Property(u => u.EmailVerified).HasDefaultValue(false);
    }
}
