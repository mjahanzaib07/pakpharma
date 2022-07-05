class COAsummary {
  double assets;
  double liability;
  double equity;
  double income;
  double expense;


  COAsummary({
    required this.assets,
    required this.equity,
    required this.expense,
    required this.income,
    required this.liability,

  });

  factory COAsummary.fromJson(Map<String, dynamic> json) {
    return COAsummary(

        assets:json['Assets'],
        liability:json['Liability'],
        equity: json['Equity'],
        income: json['Income'],
        expense: json['Expense'],
    );
  }
}