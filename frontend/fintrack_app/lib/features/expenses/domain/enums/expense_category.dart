enum ExpenseCategory {
  rent(1),
  utilities(2),
  groceries(3),
  transportation(4),
  insurance(5),
  healthcare(6),
  education(7),
  entertainment(8),
  diningOut(9),
  shopping(10),

  // Subcategories
  medicalBills(11),
  prescriptionDrugs(12),
  gymMembership(13),
  streamingServices(14),
  subscriptions(15),

  // Work-related expenses
  officeSupplies(16),
  businessTravel(17),
  professionalDevelopment(18),

  // Debt-related categories
  loanRepayment(19),
  creditCardPayment(20),
  savings(21),

  // Miscellaneous categories
  gifts(22),
  charitableDonations(23),
  taxes(24),
  emergencyFund(25);

  final int value;
  const ExpenseCategory(this.value);
}
