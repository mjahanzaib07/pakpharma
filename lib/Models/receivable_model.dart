class Receivable {
  String accId;
  String accountidcode;
  String accounttitle;
  String headcategory;
  String heading;
  double openingbalance;
  double currentbalance;


  Receivable({
    required this.accId,
    required this.accountidcode,
    required this.accounttitle,
    required this.headcategory,
    required this.heading,
    required this.openingbalance,
    required this.currentbalance,

  });

  factory Receivable.fromJson(Map<String, dynamic> json) {
    return Receivable(
      accId: json['AccountId'] as String,
      accountidcode: json['AccountIdCode'] as String,
      headcategory:json['HeadCategory']['HeadCategoryName'] as String,
      heading: json['ParentHeading']['HeadingTitle'] as String,
      currentbalance:  json['CurrentBalance'] as double,
      accounttitle:json['AccountTitle'] as String,
      openingbalance: json['OpeningBalance'] as double,
    );
  }
}
