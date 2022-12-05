import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:forecast/screens/registration_screen.dart';
import 'package:forecast/widgets/text_widgets.dart';

import '../globals/global.dart';
import '../widgets/auth_button.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  late Animation animate;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration:Duration(seconds: 3) );
    animation = CurvedAnimation(parent:controller , curve: Curves.bounceIn,);
    animate = ColorTween(begin: Colors.indigo, end:  kAppPrimaryColor).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
        animation.value;
        animate.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animate.value,
      body: Container(

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Global.getSizeHeight(context)*0.50, left: 32, right: 32),
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                curve: Curves.easeInSine,
                child: Container(
                  width: 350,
                  height:  361,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(animation.value *30.0)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 45, left: 22, right: 22),
                          child: InsideTextWidget(text: "Explore global map of wind, weather,and ocean conditions"),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 22, right: 22),
                        child: InsideLiteTextWidget(text: "Planing your trip become more easier with ideate weather app. you can instantly see the whole word weather within few second"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0,left: 43, right: 43 ),
                        child: AuthButton(width: 264, pressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                        }, color: kAppPrimaryColor, text: 'Get started'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildContainer(context: context),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

