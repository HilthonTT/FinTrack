﻿using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Expenses.Create;

internal sealed class CreateExpenseCommandHandler(
    IUserContext userContext,
    IExpenseRepository expenseRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<CreateExpenseCommand, Guid>
{
    public async Task<Result<Guid>> Handle(CreateExpenseCommand request, CancellationToken cancellationToken)
    {
        if (request.UserId != userContext.UserId)
        {
            return Result.Failure<Guid>(UserErrors.Unauthorized);
        }

        Currency? currency = Currency.FromCode(request.CurrencyCode);
        if (currency is null)
        {
            return Result.Failure<Guid>(CurrencyErrors.NotFound(request.CurrencyCode));
        }

        var money = new Money(request.Amount, currency);

        ExpenseCategory category = ValidateEnumValue<ExpenseCategory>(request.ExpenseCategory);
        SubscriptionType subscription = ValidateEnumValue<SubscriptionType>(request.SubscriptionType);
        TransactionType transaction = ValidateEnumValue<TransactionType>(request.TransactionType);

        Result<Expense> expenseResult = Expense.Create(
            request.UserId, 
            request.Name, 
            money,
            category,
            subscription,
            transaction, 
            request.Date);

        if (expenseResult.IsFailure)
        {
            return Result.Failure<Guid>(expenseResult.Error);
        }

        Expense expense = expenseResult.Value;

        expenseRepository.Insert(expense);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return expense.Id;
    }

    private static TEnum ValidateEnumValue<TEnum>(int value) where TEnum : struct, Enum
    {
        if (Enum.IsDefined(typeof(TEnum), value))
        {
            return (TEnum)Enum.ToObject(typeof(TEnum), value);
        }

        throw new ArgumentException($"Invalid {typeof(TEnum).Name}: {value}");
    }
}
