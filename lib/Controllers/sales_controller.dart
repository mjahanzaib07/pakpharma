
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/Models/COASsummary.dart';
import 'package:pak_pharma/Models/Sales_Summary.dart';
import 'package:pak_pharma/Models/purchase_summary.dart';

import '../api/api_checker.dart';
import '../api/api_client.dart';



class SalesController extends GetxController {
  final prof = Get.put(ProfileController());
  SalesSummary? summary;
  String? token;
  int? number;
  ApiClient api = ApiClient();
  @override
  Future<void> onInit() async {
    await refreshAll();
    super.onInit();
  }
  Future refreshAll() async {
    await getSummary(prof.userDetail?.organization.organizationId);
  }
  Future getSummary(String? id) async {
    Response response = await api.getData("api/Dashboard/SalesSummary",query: {"organizationId":id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      summary =  SalesSummary.fromJson(response.body);

      print(summary?.CompletedSaleInvoiceinvoice);
      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get coa data');
    }
  }

}
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}