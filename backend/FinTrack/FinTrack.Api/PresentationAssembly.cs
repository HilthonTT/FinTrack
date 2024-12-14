using System.Reflection;

namespace FinTrack.Api;

public static class PresentationAssembly
{
    public static readonly Assembly Instance = typeof(Program).Assembly;
}
