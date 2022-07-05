import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pak_pharma/Controllers/account_controller.dart';

import '../../Constants/constants.dart';
import '../../Models/account_model.dart';
import '../header.dart';

class AllAccountScreen extends StatelessWidget {
  const AllAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: GetBuilder<AccountController>(
          init: AccountController(),
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
                          width: MediaQuery.of(context).size.width -30,
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
                        const SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cont.foundAccounts!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Account acc = cont.foundAccounts![index];
                          return ListTile(
                            selected: cont.selectedAcc==acc,
                            selectedTileColor: primarydark,
                            onTap: (){
                              cont.setSelectedAccount(acc);
                            },
                            tileColor: index % 2 == 0
                                ? Colors.grey.shade200
                                : Colors.white,
                            title: Text(
                              acc.accounttitle.toUpperCase(),
                              style:  TextStyle(color:cont.selectedAcc==acc?Colors.white: Colors.black),
                            ),
                            subtitle: Text(acc.accountidcode,
                                style:  TextStyle(color:cont.selectedAcc==acc?Colors.white: Colors.black,fontSize: 12)),
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
