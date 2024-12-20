using SharedKernel;

namespace Api.FunctionalTests.Contracts;

internal sealed class CustomProblemDetails
{
    public required string Type { get; set; }

    public required string Title { get; set; }

    public required int Status { get; set; }

    public required string Detail { get; set; }

    public required List<Error> Errors { get; set; } = [];
}
