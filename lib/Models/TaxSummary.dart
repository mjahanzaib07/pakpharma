class TaxSummary {
  double taxPaid;
  double taxReceived;
  double taxPayable;
  double taxReceivable;
  double wasteTax;


  TaxSummary({
    required this.taxPaid,
    required this.taxPayable,
    required this.wasteTax,
    required this.taxReceivable,
    required this.taxReceived,

  });

  factory TaxSummary.fromJson(Map<String, dynamic> json) {
    return TaxSummary(

      taxPaid:json['TaxPaid'],
      taxReceived:json['TaxReceived'],
      taxPayable: json['TaxPayable'],
      taxReceivable: json['TaxReceivable'],
      wasteTax: json['WasteTax'],
    );
  }
}