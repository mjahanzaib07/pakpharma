import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

import '../../Constants/constants.dart';
import '../../Constants/loading_widget.dart';
import '../../controllers/authcontroller.dart';




class loginScreen extends StatefulWidget {
   loginScreen({Key? key,}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
   bool isLoading = true;
   String email = '';
   String pass = '';
   bool passwordVisible = true;
   final authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: !isLoading ?  const Center(child: CircularProgressIndicator()) :
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    const Text(
                      "PAK PHARMA",
                      style: TextStyle(
                        fontSize: 18,
                        color: bgColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 50,
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white24),
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  onChanged: (val)  {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    // helperText: 'Helper text',
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.white70,
                    ),
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white24),
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  style: TextStyle(color: Colors.white),
                  initialValue: '',
                  onChanged: (txt){
                    setState(() {
                      pass=txt;
                    });
                  },
                  obscureText: passwordVisible,
                  decoration:  InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    // helperText: 'Helper text',
                    suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: passwordVisible ? Colors.white70 : Colors.white,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        }),
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                constraints: BoxConstraints(maxWidth: 350,minWidth: 300),

                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: bgColor,
                ),
                child: TextButton(
                  onPressed: () async {
                    if(email == '' && pass == ''){
                      displayToast("Please fill email and password", context,);
                    }else if (email != '' && pass == ''){
                      displayToast("Please enter your password", context,);
                    }else if(email == '' && pass != ''){
                      displayToast("Please enter your email", context,);

                    }else{
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return Container(
                              height: MediaQuery.of(context).size.height,
                              width:  MediaQuery.of(context).size.width,
                              color:Colors.black26,
                              child: LoadingWidget());
                        },
                      );
                      await authcontroller.userLogin(email, pass,context);
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }


}
