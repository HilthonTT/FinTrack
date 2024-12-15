using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinTrack.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class Added_Budget_Expense_Tables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "budgets",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    amount_amount = table.Column<decimal>(type: "numeric", nullable: false),
                    amount_currency = table.Column<string>(type: "text", nullable: false),
                    spent_amount = table.Column<decimal>(type: "numeric", nullable: false),
                    spent_currency = table.Column<string>(type: "text", nullable: false),
                    date_range_start = table.Column<DateOnly>(type: "date", nullable: false),
                    date_range_end = table.Column<DateOnly>(type: "date", nullable: false),
                    created_on_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    modified_on_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_budgets", x => x.id);
                    table.ForeignKey(
                        name: "fk_budgets_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "expenses",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    money_amount = table.Column<decimal>(type: "numeric", nullable: false),
                    money_currency = table.Column<string>(type: "text", nullable: false),
                    category = table.Column<int>(type: "integer", nullable: false),
                    subscription_type = table.Column<int>(type: "integer", nullable: false),
                    transaction_type = table.Column<int>(type: "integer", nullable: false),
                    date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    created_on_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    modified_on_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false, defaultValue: false),
                    deleted_on_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_expenses", x => x.id);
                    table.ForeignKey(
                        name: "fk_expenses_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_budgets_user_id",
                table: "budgets",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_expenses_user_id",
                table: "expenses",
                column: "user_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "budgets");

            migrationBuilder.DropTable(
                name: "expenses");
        }
    }
}
