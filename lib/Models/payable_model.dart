class Payable {
  String accId;
  String accountidcode;
  String accounttitle;
  String headcategory;
  String heading;
  double openingbalance;
  double currentbalance;


  Payable({
    required this.accId,
    required this.accountidcode,
    required this.accounttitle,
    required this.headcategory,
    required this.heading,
    required this.openingbalance,
    required this.currentbalance,

  });

  factory Payable.fromJson(Map<String, dynamic> json) {
    return Payable(
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
