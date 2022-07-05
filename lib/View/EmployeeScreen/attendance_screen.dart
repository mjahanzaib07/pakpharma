import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:pak_pharma/Models/employee.dart';
import 'package:pak_pharma/View/header.dart';

import '../../Controllers/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({Key? key}) : super(key: key);
  var cont = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
    }
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 150),
          child: SafeArea(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Header(
                title: 'Attendance',
              ),
            ),
          ),
        ),
        body: GetBuilder<AttendanceController>(
          init: AttendanceController(),
          autoRemove: false,
          builder: (cont) => SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => {cont.refreshAll()},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 0.5))
                              ]),
                          height: 40,
                          child: TextFormField(
                            onChanged: (val) {
                              cont.runFilter(val);
                            },
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: 5,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff7F7C82),
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primarydark
                              ),
                                onPressed: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: 25,
                                    // This is called when selected item is changed.
                                    onSelectedItemChanged: (int selectedItem) {
                                      cont.runDesFilter(selectedItem-1);
                                    },
                                    children:
                                    List<Widget>.generate(cont.departments!.length+1, (int index) {
                                      if(index==0) {
                                        return const Center(
                                          child: Text(
                                            "clear selection",
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: Text(
                                          cont.departments![index-1],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                child:  Text(cont.selectedDep)))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cont.foundemp!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Employee emp = cont.foundemp![index];
                          return ListTile(
                            tileColor: index % 2 == 0
                                ? Colors.grey.shade200
                                : Colors.white,
                            trailing: Text(
                              emp.present ? "Present" : "Absent",
                              style: TextStyle(
                                  color:
                                      emp.present ? Colors.green : Colors.red,
                                  fontSize: 12),
                            ),
                            title: Text(
                              emp.employeeName.toUpperCase(),
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(emp.employeeDepartment,
                                style: TextStyle(color: Colors.black)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
