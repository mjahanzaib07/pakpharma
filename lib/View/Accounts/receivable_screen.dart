import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controllers/receivable_controller.dart';
import '../header.dart';

class ReceivableScreen extends StatelessWidget {
  const ReceivableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<ReceivableController>(
        init: ReceivableController(),
        builder: (cont) => SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => { cont.refreshAll() },
              child: ListView(
                children: [
                  //Accounts Card
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Header(title: "Receivable"),
                  ),
                  Divider(color: Colors.grey.shade400,),


                ],
              ),
            )
        ),
      ),
    );
  }
}
