
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/Models/TaxSummary.dart';

import '../api/api_checker.dart';
import '../api/api_client.dart';



class TaxController extends GetxController {
  final prof = Get.put(ProfileController());
  TaxSummary? summary;
  List<ChartData> data = [];
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
    Response response = await api.getData("api/Dashboard/TaxSummary",query: {"organizationId":id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      summary =  TaxSummary.fromJson(response.body);
      data = [
        ChartData("Tax Paid", summary!.taxPaid),
        ChartData("Tax Payable", summary!.taxPayable),
        ChartData("Tax Receivable", summary!.taxReceivable),
        ChartData("Tax Received", summary!.taxReceived),
        ChartData("Waste Tax", summary!.wasteTax),
      ];

      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get tax data');
    }
  }

}
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}