import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/models/user_register_model.dart';
import 'package:forecast/screens/home_screen.dart';
import 'package:forecast/screens/onboars_screen.dart';
import 'package:forecast/widgets/text_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
   late AnimationController controller;
   late Animation animation;
   Map<String, dynamic> decodeuserdata = {};


   Future<SharedPreferences> getShared() async{
     return await SharedPreferences.getInstance();
   }

   void getDecodedUserData()async {
     SharedPreferences prefs = await getShared();
     String encodeMap = prefs.getString("loginData") ?? "";
     if(encodeMap != "") {
       decodeuserdata = json.decode(encodeMap);
     }
     log("here decode user data is $decodeuserdata");

   }



  @override
  void initState() {

    super.initState();
    getDecodedUserData();

    controller = AnimationController(vsync: this,duration:Duration(seconds: 3) );
    animation = CurvedAnimation(parent:controller , curve: Curves.easeInCubic,);
    controller.forward();
    controller.addListener(() {
      setState(() {
        animation.value;
      });

    });
    Timer(Duration(seconds: 6),()
    => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => decodeuserdata["token"] == null ? OnBoardScreen()
        : HomeScreen(loginResponseModel: LoginResponseModel.fromJson(decodeuserdata)))));

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/images/logo_test.png",
                  width:  250,
                  height:animation.value * 94,
                ),
              ),
              AnimatedTextKit(
                  pause: Duration(seconds: 4),
                  animatedTexts: [
                    ColorizeAnimatedText("Forecasting",
                        textStyle:GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 46.0, color: kAppPrimaryColor), colors: [
                          kAppPrimaryColor,
                          kAppPrimaryColor.withOpacity(0.50),
                          kAppPrimaryColor.withAlpha(10)
                          ] )
              ])
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
