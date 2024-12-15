namespace FinTrack.Domain.Expenses;

public enum ExpenseCategory
{
    Rent = 1,
    Utilities = 2,
    Groceries = 3,
    Transportation = 4,
    Insurance = 5,
    Healthcare = 6,
    Education = 7,
    Entertainment = 8,
    DiningOut = 9,
    Shopping = 10,

    // Subcategories
    MedicalBills = 11,
    PrescriptionDrugs = 12,
    GymMembership = 13,
    StreamingServices = 14,
    Subscriptions = 15,

    // Work-related expenses
    OfficeSupplies = 16,
    BusinessTravel = 17,
    ProfessionalDevelopment = 18,

    // Debt-related categories
    LoanRepayment = 19,
    CreditCardPayment = 20,
    Savings = 21,

    // Miscellaneous categories
    Gifts = 22,
    CharitableDonations = 23,
    Taxes = 24,
    EmergencyFund = 25
}
