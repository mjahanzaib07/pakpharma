class COASsummary {
  double assets;
  double liability;
  double equity;
  double income;
  double expense;


  COASsummary({
    required this.assets,
    required this.equity,
    required this.expense,
    required this.income,
    required this.liability,

  });

  factory COASsummary.fromJson(Map<String, dynamic> json) {
    return COASsummary(

        assets:json['Assets'],
        liability:json['Liability'],
        equity: json['Equity'],
        income: json['Income'],
        expense: json['Expense'],
    );
  }
}