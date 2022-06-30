class SalesSummary{
  int TotalSalesOrders;
  int PendingSalesOrders;
  int CompletedSaleInvoiceinvoice;
  int TotalSaleInvoice;
  int PendingSaleInvoice;
  int CompletedSaleInvoiceorder;
  int TotalCreditNotes;



  SalesSummary ({
    required this.CompletedSaleInvoiceorder,
  required this.PendingSaleInvoice,
  required this.PendingSalesOrders,
  required this.TotalCreditNotes,
  required this.TotalSaleInvoice,
  required this.TotalSalesOrders,
 required this.CompletedSaleInvoiceinvoice,
  });
  factory SalesSummary.fromJson(Map<String, dynamic> json) {
    return SalesSummary(

        TotalSalesOrders: json['saleOrderSummary']['TotalSalesOrders'],
        PendingSalesOrders: json['saleOrderSummary']['PendingSalesOrders'],
        CompletedSaleInvoiceinvoice:json['saleInvoiceSummary']['CompletedSaleInvoice'],
        TotalSaleInvoice: json['saleInvoiceSummary']['TotalSaleInvoice'],
        PendingSaleInvoice: json['saleInvoiceSummary']['PendingSaleInvoice'],
        CompletedSaleInvoiceorder: json['saleOrderSummary']['CompletedSaleInvoiceorder'],
        TotalCreditNotes: json['creditNoteSummary']['TotalCreditNotes'],
       );
  }
}