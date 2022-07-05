import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pak_pharma/Controllers/cash_summary_controller.dart';
import 'package:pak_pharma/Models/Transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../header.dart';

class CashSummaryScreen extends StatelessWidget {
  CashSummaryScreen({Key? key}) : super(key: key);

  final List<SalesData> chartData = [
    SalesData(DateTime(2010), 35),
    SalesData(DateTime(2011), 28),
    SalesData(DateTime(2012), 34),
    SalesData(DateTime(2013), 32),
    SalesData(DateTime(2014), 40)
  ];
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  final TrackballBehavior _trackball = TrackballBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CashController>(
        init: CashController(),
        autoRemove: false,
        builder: (cont) => SafeArea(
            child: RefreshIndicator(
          onRefresh: () async => {cont.refreshAll()},
          child: ListView(
            children: [
              //Accounts Card
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
                child: const Header(title: "Cash Summary"),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              cont.receivedcashSummary != null && cont.paidcashSummary != null
                  ? SfCartesianChart(
                      legend: Legend(
                        isVisible: true,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          // fontSize: 12.5,
                          // fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.w600
                        ),
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        itemPadding: 10,
                      ),
                      tooltipBehavior: _tooltip,
                      trackballBehavior: _trackball,
                      primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<Transaction, DateTime>(
                              name: "Paid Cash",
                              dataSource: cont.paidcashSummary!,
                              xValueMapper: (Transaction cash, _) =>
                                  cash.transactionDate,
                              yValueMapper: (Transaction cash, _) =>
                                  cash.ammount),
                          LineSeries<Transaction, DateTime>(
                              name: "Received Cash",
                              dataSource: cont.receivedcashSummary!,
                              xValueMapper: (Transaction cash, _) =>
                                  cash.transactionDate,
                              yValueMapper: (Transaction cash, _) =>
                                  cash.ammount),
                        ])
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        )),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
