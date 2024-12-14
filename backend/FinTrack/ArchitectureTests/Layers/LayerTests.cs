using FinTrack.Api;
using FinTrack.Application;
using FinTrack.Domain;
using FinTrack.Infrastructure;
using FinTrack.Persistence;
using FluentAssertions;
using NetArchTest.Rules;

namespace ArchitectureTests.Layers;

public class LayerTests
{
    [Fact]
    public void DomainLayer_ShouldNotHaveDependencyOn_ApplicationLayer()
    {
        TestResult result = Types.InAssembly(DomainAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(ApplicationAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void DomainLayer_ShouldNotHaveDependencyOn_InfrastructureLayer()
    {
        TestResult result = Types.InAssembly(DomainAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(InfrastructureAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void DomainLayer_ShouldNotHaveDependencyOn_PersistenceLayer()
    {
        TestResult result = Types.InAssembly(DomainAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PersistenceAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void DomainLayer_ShouldNotHaveDependencyOn_PresentationLayer()
    {
        TestResult result = Types.InAssembly(DomainAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PresentationAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void ApplicationLayer_ShouldNotHaveDependencyOn_PresentationLayer()
    {
        TestResult result = Types.InAssembly(ApplicationAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PresentationAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void ApplicationLayer_ShouldNotHaveDependencyOn_InfrastructureLayer()
    {
        TestResult result = Types.InAssembly(ApplicationAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(InfrastructureAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void ApplicationLayer_ShouldNotHaveDependencyOn_PersistenceLayer()
    {
        TestResult result = Types.InAssembly(ApplicationAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PersistenceAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void InfrastructureLayer_ShouldNotHaveDependencyOn_PresentationLayer()
    {
        TestResult result = Types.InAssembly(InfrastructureAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PresentationAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void PersistenceLayer_ShouldNotHaveDependencyOn_PresentationLayer()
    {
        TestResult result = Types.InAssembly(PersistenceAssembly.Instance)
            .Should()
            .NotHaveDependencyOn(PresentationAssembly.Instance.GetName().Name)
            .GetResult();

        result.IsSuccessful.Should().BeTrue();
    }
}
