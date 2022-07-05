import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:pak_pharma/Controllers/sales_controller.dart';
import '../header.dart';

class SalesSummaryScreen extends StatelessWidget {
  const SalesSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 150),
        child: SafeArea(
          child: Container(
            color: bgColor,
            padding: const EdgeInsets.all(8.0),
            child: Header(
              title: 'Sales Summary',
            ),
          ),
        ),
      ),
      body: GetBuilder<SalesController>(
        init: SalesController(),
        autoRemove: false,
        builder: (cont) => SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => {cont.refreshAll()},
              child: ListView(
                children: [
                  //Accounts Card
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20,),
                  if(cont.summary != null)
                    ...[
                      Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sales Orders",style: const TextStyle(color: secondaryGreen,fontSize: 22,fontWeight: FontWeight.bold),),
                                  Text(cont.summary!.TotalSalesOrders.toString(),style: TextStyle(color: secondaryGreen,fontSize: 22,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("Pending",style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                      Text(cont.summary!.PendingSalesOrders.toString(),style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Completed",style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                      Text(cont.summary!.CompletedSaleInvoiceorder.toString(),style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5,),
                              LinearProgressIndicator(
                                color: secondaryGreen,
                                value: cont.summary!.CompletedSaleInvoiceorder /
                                    cont.summary!.TotalSalesOrders,
                                minHeight: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sales Invoices",style: TextStyle(color: primarydark,fontSize: 22,fontWeight: FontWeight.bold),),
                                  Text(cont.summary!.TotalSaleInvoice.toString(),style: TextStyle(color: primarydark,fontSize: 22,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("Pending",style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                      Text(cont.summary!.PendingSaleInvoice.toString(),style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Completed",style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                      Text(cont.summary!.CompletedSaleInvoiceinvoice.toString(),style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5,),
                              LinearProgressIndicator(
                                color: primarydark,
                                value: cont.summary!.CompletedSaleInvoiceinvoice /
                                    cont.summary!.TotalSaleInvoice,
                                minHeight: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  else const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
