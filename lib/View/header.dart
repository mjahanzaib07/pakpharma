import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak_pharma/Constants/constants.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            Get.back();
          },
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
              child: Wrap(
                children: [
                  Icon(Icons.chevron_left,color: primarydark,size: 20,),
                  Text("back",style: TextStyle(color: primarydark),),
                ],
              ),
            ),
          ),
        ),
        Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primarydark),),
        SizedBox(width: 70,),
      ],
    );
  }
}
