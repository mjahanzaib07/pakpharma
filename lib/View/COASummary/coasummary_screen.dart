import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pak_pharma/Controllers/coa_controller.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../header.dart';

class COASummaryScreen extends StatelessWidget {
  COASummaryScreen({Key? key}) : super(key: key);


  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  final TrackballBehavior _trackball = TrackballBehavior(enable: true);
 var cont = Get.put(() => COAController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<COAController>(
        init:   COAController(),
        autoRemove: false,
        builder: (cont) => SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => {cont.refreshAll()},
              child: ListView(
                children: [
                  //Accounts Card
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 8, top: 8),
                    child: Header(title: "COA Summary"),
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  cont.summary != null
                      ? SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                      tooltipBehavior: _tooltip,
                      series: <ChartSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                            dataSource: cont.data,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: 'PKR',
                            color: Color.fromRGBO(8, 142, 255, 1))
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

