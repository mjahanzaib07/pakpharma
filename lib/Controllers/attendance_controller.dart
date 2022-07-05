import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:pak_pharma/Models/employee.dart';

import '../api/api_checker.dart';
import '../api/api_client.dart';

class AttendanceController extends GetxController {
  List<Employee>? presentEmp;
  List<Employee>? absentEmp;
  List<Employee>? foundemp = [];
  List<String>? departments;
  String selectedDep = "Department";
  List<Employee> get totalemp =>  [...?presentEmp,...?absentEmp].obs;
  ApiClient api = ApiClient();
  @override
  Future<void> onInit() async {
    await refreshAll();
    super.onInit();
  }

  Future refreshAll() async {
    await getEmployees();
    await getDepartments();
  }
  Future getPresent() async {
    Response response = await api.getData(
        "api/HRReport/DailyAttendance",
        query: {"date": DateFormat("yyyy-MM-dd").format(DateTime.now())});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> receivableData = response.body;
      List<dynamic> data = receivableData["Data"];
      List<Employee> receivabledata = data
          .map(
            (dynamic item) => Employee.fromJson(item,true),
          )
          .toList();
      presentEmp = receivabledata;
      print(presentEmp?.length);
      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get receivable data');
    }
  }
  Future getAbsent() async {
    Response response = await api.getData(
        "api/HRReport/DailyAbsentees",
        query: {"date": DateFormat("yyyy-MM-dd").format(DateTime.now())});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> receivableData = response.body;
      List<dynamic> data = receivableData["Data"];
      List<Employee> receivabledata = data
          .map(
            (dynamic item) => Employee.fromJson(item,false),
          )
          .toList();
      absentEmp = receivabledata;
      print(absentEmp?.length);
      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get receivable data');
    }
  }
  Future getEmployees() async {
    await getPresent();
    await getAbsent();
    foundemp = [...?presentEmp,...?absentEmp];
    update();
  }
  Future getDepartments() async {
    Response response = await api.getData(
        "api/Department/GetAll");
    print(response.statusCode);
    if (response.statusCode == 200) {

      Map<String, dynamic> Data = response.body;
      List<dynamic> data = Data["Data"];
      List<String> dep = data
          .map(
            (dynamic item) => item['DepName'].toString(),
      )
          .toList();
      departments = dep;
      print(departments?.length);
      update();
    } else {
      ApiChecker().checkApi(response);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get department data');
    }
  }

  void runFilter(String enteredKeyword) {
    List<Employee> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = totalemp;
    } else {
      results = totalemp
          .where((user) => user.employeeName
              .toUpperCase()
              .contains(enteredKeyword.toUpperCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundemp = results;
    update();
  }
  void runDesFilter(int ind) {

    List<Employee> results = [];
    if (ind==-1) {
      // if the search field is empty or only contains white-space, we'll display all users
      selectedDep = "Department";
      results = totalemp;
    } else {
      selectedDep = departments![ind];
      results = totalemp
          .where((user) => user.employeeDepartment
              .toUpperCase()
              .contains(selectedDep.toUpperCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundemp = results;
    update();
  }
}
