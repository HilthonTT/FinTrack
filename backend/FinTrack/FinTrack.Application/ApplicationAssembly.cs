using System.Reflection;

namespace FinTrack.Application;

public static class ApplicationAssembly
{
    public static readonly Assembly Instance = typeof(ApplicationAssembly).Assembly;
}
