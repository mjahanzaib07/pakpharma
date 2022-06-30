class BalanceSummary {

  double cashBalance;
  double bankbBalance;
  double receivable;
  double payable;


  BalanceSummary({
    required this.receivable,
    required this.bankbBalance,
    required this.cashBalance,
    required this.payable,

  });

  factory BalanceSummary.fromJson(Map<String, dynamic> json) {
    return BalanceSummary(
      cashBalance: json['CashBalance'] as double,
      bankbBalance: json['BankBalance'] as double,
      receivable: json['Receivables'] as double,
      payable: json['Payables'] as double,
    );
  }
}
