using System.Reflection;

namespace FinTrack.Persistence;

public static class PersistenceAssembly
{
    public static readonly Assembly Instance = typeof(PersistenceAssembly).Assembly;
}
