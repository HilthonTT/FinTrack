namespace FinTrack.Application.Expenses;

public static class ExpenseCacheKeys
{
    public static string GetUserExpenses(Guid userId)
    {
        return $"user-{userId}-expenses";
    }

    public static string GetById(Guid expenseId)
    {
        return $"expense-{expenseId}";
    }
}
