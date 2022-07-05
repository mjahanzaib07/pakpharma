
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/Models/Transaction.dart';
import 'package:pak_pharma/api/api_checker.dart';

import '../api/api_client.dart';


class CashController extends GetxController {
  final prof = Get.put(ProfileController());
  List<Transaction>? receivedcashSummary;
  List<Transaction>? paidcashSummary;

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
    Response response = await api.getData("api/Dashboard/CashSummary",query: {"organizationId":id});

    if (response.statusCode == 200) {
      Map<String, dynamic> Data = response.body;
      List<dynamic> paiddata = Data["CashTransactionsPaid"];
      List<dynamic> recedata = Data["CashTransactionsReceived"];
      List<Transaction> paidcashdata = paiddata
          .map(
            (dynamic item) => Transaction.fromJson(item),
      ).toList();
      List<Transaction> rececashdata = recedata
          .map(
            (dynamic item) => Transaction.fromJson(item),
      ).toList();
      paidcashSummary =  paidcashdata;
      receivedcashSummary = rececashdata;

      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get cash summary data');

    }
  }

}
