

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/screens/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/login_screen.dart';
import '../widgets/text_widgets.dart';

const kAppPrimaryColor = Color(0xff47BFDF);
const prefixIconColor = Color(0xff292D32);
const buttonDisabledColor = Color(0xffD9D9D9);
const kCommonIconColor = Color(0xffFFFFFF);
const kSignOutColor = Color(0xffFF6D6D);
const kSignOutCircleColor = Color(0xffFFD6D6);
const kHomeContainerColor = Color(0xffFFFFFF);
const kViewReportContainerColor = Color(0xff444E72);
const kDialogContainerColor = Color(0xffFFFFFF);
const logoutBoldColor = Color(0xff080713);
const blackBold = Color(0xff080713);
const cancelButton = Color(0xffF1EFEF);
const logOutText = Color(0xff6B6A71);
const searchBarIconCOlors = Color(0xff444E72);
const searchTextColor = Color(0xff444E72);
const hintColor = Color(0xff808080);

bool buttonState(String name, String password, String phone, String email){
  if(name.isNotEmpty && password.isNotEmpty && phone.isNotEmpty && email.isNotEmpty){
    return false;
  }else{
    return true;
  }
}

bool logInButtonState( String password, String email){
  if( password.isNotEmpty && email.isNotEmpty){
    return false;
  }else{
    return true;
  }
}

Container buildContainer({String? text , String? sideText, required BuildContext context}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonTextWidget(text: text ?? 'Already have an account ?', wght: FontWeight.w400, size: 14,colors: Colors.black,),
        InkWell(
          onTap: () {
             if(sideText != null && sideText == "Signup"){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
             }else{
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
             }
          },
            child: CommonTextWidget(text: sideText == null?'Log in': sideText, wght: FontWeight.w700, size: 14,colors: kAppPrimaryColor,)),
      ],
    ),
  );
}





Future showPopUpDialog( {required BuildContext context, required String textTitle, required String msgText, required Function() pressed}) {
  return showDialog( //show confirm dialogue
//the return value will be from "Yes" or "No" options
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(textTitle,style:GoogleFonts.overpass(color: kAppPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600)),
      content: Text(msgText,style:GoogleFonts.overpass(color: searchTextColor, fontSize: 14, fontWeight: FontWeight.w400)),
      actions:[
        CupertinoButton(
          onPressed: pressed,
          //return true when click on "Yes"
          child:Text('ok',style:GoogleFonts.overpass(color: kAppPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}

Widget animatedDialog( {required BuildContext context, required String textTitle, required String msgText, required Function() pressed}) {
  return CupertinoAlertDialog(
    title: Text(textTitle,style:GoogleFonts.overpass(color: kAppPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600)),
    content: Text(msgText,style:GoogleFonts.overpass(color: searchTextColor, fontSize: 14, fontWeight: FontWeight.w400)),
    actions:[
      CupertinoButton(
        onPressed: pressed,
        //return true when click on "Yes"
        child:Text('ok',style:GoogleFonts.overpass(color: kAppPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    ],
  );
}



