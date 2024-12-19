using Bogus;
using FinTrack.Persistence.Context;
using MediatR;
using Microsoft.Extensions.DependencyInjection;

namespace Application.IntegrationTests.Abstractions;

public abstract class BaseIntegrationTest : IClassFixture<IntegrationTestWebAppFactory>, IDisposable
{
    private readonly IServiceScope _scope;

    private bool _disposed = false;

    protected BaseIntegrationTest(IntegrationTestWebAppFactory factory)
    {
        _scope = factory.Services.CreateScope();

        Sender = _scope.ServiceProvider.GetRequiredService<ISender>();
        AppDbContext = _scope.ServiceProvider.GetRequiredService<AppDbContext>();
        Faker = new();
    }

    protected ISender Sender { get; init; }

    protected AppDbContext AppDbContext { get; init; }

    protected Faker Faker { get; init; }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (!_disposed)
        {
            return;
        }

        if (disposing)
        {
            _scope.Dispose();
        }

        _disposed = true;
    }

    ~BaseIntegrationTest()
    {
        Dispose(false);
    }
}
