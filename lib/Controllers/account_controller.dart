
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pak_pharma/Controllers/profilecontroller.dart';
import 'package:pak_pharma/Models/account_model.dart';
import '../api/api_checker.dart';
import '../api/api_client.dart';
import 'authcontroller.dart';


class AccountController extends GetxController {
  final auth = Get.put(AuthController());
  final prof = Get.put(ProfileController());
  List<Account>? accounts;
  Account? selectedAcc;



  List<Account>? foundAccounts = [];

  String? token;
  int? number;
  ApiClient api = ApiClient();
  @override
  Future<void> onInit() async {
    await refreshAll();
    super.onInit();
  }
  Future refreshAll() async {
    token = await auth.getToken();
    await getAccounts(prof.userDetail?.organization.organizationId);

  }
  Future getAccounts(String? id) async {
    Response response = await api.getData("api/Account/GetAll",query: {"internalOrganizationId":id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> payableData = response.body;
      List<dynamic> data = payableData["Data"];
      List<Account> payabledata = data
          .map(
            (dynamic item) => Account.fromJson(item),
      ).toList();
      accounts = payabledata.where((payabledata) => payabledata.currentbalance != 0||payabledata.currentbalance != 0).toList();
      foundAccounts = accounts;
      print(foundAccounts!.length);
      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get accounts');
    }
  }

  setSelectedAccount(Account acc){
    selectedAcc = acc;
    update();
  }

  void runFilter(String enteredKeyword) {
    List<Account> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = accounts!;
    } else {
      results = accounts!
          .where((user) => user.accounttitle
          .toUpperCase()
          .contains(enteredKeyword.toUpperCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundAccounts = results;
    update();

  }
}
