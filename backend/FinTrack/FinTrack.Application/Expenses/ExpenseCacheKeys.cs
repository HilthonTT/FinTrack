namespace FinTrack.Application.Expenses;

public static class ExpenseCacheKeys
{
    public static string GetUserExpenses(Guid userId)
    {
        return $"user-{userId}-expenses";
    }
}
