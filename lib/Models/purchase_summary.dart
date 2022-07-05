class purchaseSummary {

  int TotalPurchaseOrders;
  int PendingPurchaseOrders;
  int CompletedPurchaseOrders;
  int TotalPurchaseInvoice;
  int PendingPurchaseInvoice;
  int CompletedPurchaseInvoice;
  int TotalDebitNotes;



  purchaseSummary({
    required this.TotalPurchaseOrders,
    required this.PendingPurchaseOrders,
    required this.CompletedPurchaseOrders,
  required this.CompletedPurchaseInvoice,
  required this.PendingPurchaseInvoice,
  required this.TotalPurchaseInvoice,
  required this.TotalDebitNotes,

  });



  factory purchaseSummary.fromJson(Map<String, dynamic> json) {
    return purchaseSummary(
      TotalPurchaseOrders: json['purchaseOrderSummary'] ['TotalPurchaseOrders'],
      PendingPurchaseOrders: json['purchaseOrderSummary'] ['PendingPurchaseOrders'],
        CompletedPurchaseOrders: json['purchaseOrderSummary']['CompletedPurchaseOrders'],
        CompletedPurchaseInvoice: json['purchaseInvoiceSummary']['CompletedPurchaseInvoice'],
        PendingPurchaseInvoice: json['purchaseInvoiceSummary']['PendingPurchaseInvoice'],
        TotalPurchaseInvoice: json['purchaseInvoiceSummary']['TotalPurchaseInvoice'],
        TotalDebitNotes: json['debitNoteSummary']['TotalDebitNotes'],
    );
  }
}
