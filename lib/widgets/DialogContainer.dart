import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:forecast/screens/login_screen.dart';
import 'package:forecast/services/registration_service.dart';
import 'package:forecast/widgets/text_widgets.dart';

import '../globals/global.dart';

class DialogContainer extends StatefulWidget {
  const DialogContainer({Key? key}) : super(key: key);

  @override
  _DialogContainerState createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Global.getSizeHeight(context),
      height:Global.getSizeHeight(context)*0.51,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: CircleAvatar(
              backgroundColor: kSignOutCircleColor,
              radius: 80,
              child: Icon(CupertinoIcons.power, color: kSignOutColor, size: 54,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: CommonTextWidget(text: "Log out", wght: FontWeight.w700, size: 20, colors: logoutBoldColor,),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 32, right: 32),
            child: CommonTextWidget(text: "Are you sure you want to logout from app", wght: FontWeight.w400, size: 13.5, colors: logOutText,),
          ),

          Padding(
            padding: const EdgeInsets.only(top:33.0, bottom: 33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap : () async{
                    RegistrationService apiService = RegistrationService();
                    bool off = await apiService.logoutUser();
                    if(off) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  },
                  child: Container(
                    width: 128,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kSignOutColor,
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Center(child: CommonTextWidget(text: "Logout", wght: FontWeight.w700, size: 18, colors: Colors.white,)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 128,
                    height: 60,
                    decoration: BoxDecoration(
                        color: cancelButton,
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Center(child: CommonTextWidget(text: "Cancel", wght: FontWeight.w700, size: 18, colors: logoutBoldColor,)),
                  ),
                ),

              ],
            ),
          )


        ],
      ),
    );
  }
}
