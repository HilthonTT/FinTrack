﻿namespace FinTrack.Persistence.Constants;

internal static class TableNames
{
    public const string EmailVerificationTokens = "email_verification_tokens";

    public const string Expenses = "expenses";

    public const string IdempotentRequests = "idempotent_requests";

    public const string OutboxMessages = "outbox_messages";

    public const string RefreshToken = "refresh_tokens";

    public const string Users = "users";

    public const string Budgets = "budgets";

    public const string Roles = "roles";

    public const string RolePermissions = "role_permissions";

    public const string Permissions = "permissions";

    public const string Subscriptions = "subscriptions";
}
