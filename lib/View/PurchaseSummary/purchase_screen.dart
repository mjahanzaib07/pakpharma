import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:pak_pharma/Controllers/purchase_controller.dart';
import 'package:pak_pharma/Controllers/tax_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../header.dart';

class PurchaseSummaryScreen extends StatelessWidget {
  PurchaseSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PurchaseController>(
        init: PurchaseController(),
        autoRemove: false,
        builder: (cont) => SafeArea(
            child: RefreshIndicator(
          onRefresh: () async => {cont.refreshAll()},
          child: ListView(
            children: [
              //Accounts Card
              const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8, top: 8),
                child: Header(title: "Purchase Summary"),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 20,),
              if(cont.summary != null)
                    ...[
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
                                Text("Purchase Orders",style: TextStyle(color: secondaryGreen,fontSize: 22,fontWeight: FontWeight.bold),),
                                Text(cont.summary!.TotalPurchaseOrders.toString(),style: TextStyle(color: secondaryGreen,fontSize: 22,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("Pending",style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                    Text(cont.summary!.PendingPurchaseOrders.toString(),style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Completed",style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                    Text(cont.summary!.CompletedPurchaseOrders.toString(),style: TextStyle(color: secondaryGreen,fontSize: 18,fontWeight: FontWeight.w600),),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            LinearProgressIndicator(
                              color: secondaryGreen,
                              value: cont.summary!.CompletedPurchaseOrders /
                                  cont.summary!.TotalPurchaseOrders,
                              minHeight: 12,
                            ),
                          ],
                        ),
                      ),
                  ),
                      SizedBox(height: 20,),
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
                                Text("Purchase Invoices",style: TextStyle(color: primarydark,fontSize: 22,fontWeight: FontWeight.bold),),
                                Text(cont.summary!.TotalPurchaseInvoice.toString(),style: TextStyle(color: primarydark,fontSize: 22,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("Pending",style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                    Text(cont.summary!.PendingPurchaseInvoice.toString(),style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Completed",style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                    Text(cont.summary!.CompletedPurchaseInvoice.toString(),style: TextStyle(color: primarydark,fontSize: 18,fontWeight: FontWeight.w600),),
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(height: 5,),
                            LinearProgressIndicator(
                              color: primarydark,
                              value: cont.summary!.CompletedPurchaseInvoice /
                                  cont.summary!.TotalPurchaseInvoice,
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
