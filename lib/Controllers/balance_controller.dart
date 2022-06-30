
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/Models/balance_summary.dart';
import 'package:pak_pharma/Models/receivable_model.dart';

import '../Models/payable_model.dart';
import '../api/api_client.dart';
import 'authcontroller.dart';


class BalanceController extends GetxController {
  final prof = Get.put(ProfileController());
  BalanceSummary? summary;

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
    Response response = await api.getData("api/Dashboard/BalanceSummary",query: {"organizationId":id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      summary =  BalanceSummary.fromJson(response.body);
      print(summary?.payable);
      update();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get payable data');
    }
  }

}
