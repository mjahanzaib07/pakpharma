class Transaction{
  DateTime transactionDate;
  double ammount;
  String type;


  Transaction({
    required this.ammount,
  required this.transactionDate,
  required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(

        transactionDate: DateTime(json['TransactionDate']['Year'],json['TransactionDate']['Month'],json['TransactionDate']['Day']),
        ammount: json['TransData']['ammount'],
        type:json['TransData']['DebitOrCredit'],

    );
        }
        }