import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:forecast/screens/home_screen.dart';
import 'package:forecast/services/registration_service.dart';
import 'package:forecast/widgets/text_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/constants.dart';
import '../globals/global.dart';
import '../progress_hud.dart';
import '../widgets/CommonTextFeild.dart';
import '../widgets/auth_button.dart';
import '../widgets/common_head.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key,  this.email, this.password}) : super(key: key);
  final String? email;
  final String? password;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isCheck = false;
  String? prefsEmail ;
  String? prefsPass;
  bool _isLoading = true;
  bool showPass = true;

  Future<SharedPreferences> getShared() async{
    return await SharedPreferences.getInstance();
  }

  void savePrefsData() async{
    SharedPreferences pRefs = await getShared();
    pRefs.setString("email", emailController.text);
    pRefs.setString("password", passwordController.text);
  }

  void getPrefsData() async{
    SharedPreferences pRefs = await getShared();
    var email = pRefs.getString("email");
    var pass = pRefs.getString("password");
    setState(() {
      prefsEmail = email;
      prefsPass = pass;
        if(prefsEmail!= null && prefsPass != null) {
          isCheck = true;
          emailController.text = prefsEmail!;
          passwordController.text= prefsPass!;
        }
      _isLoading = false;
    });
    log("here email is $prefsEmail and $prefsPass");
  }


  @override
  void initState() {
    super.initState();
      getPrefsData();
      getData();

  }

  void getData() {
    if(widget.password != null && widget.email != null) {
      log("here its working");
      setState(() {
        emailController.text = widget.email!;
        passwordController.text = widget.password!;
        _isLoading = false;
      });
    }else if(prefsEmail != null && prefsPass != null) {
      log("here its working prefrences ");
      log("here its working and ${emailController.text} ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(key: const Key('profile_screen_progress_hud'), child: Uisetup(context), inAsyncCall:_isLoading );
  }




  @override
  Widget Uisetup(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: Global.getSizeWidth(context),
        height: Global.getSizeHeight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 92, bottom: 45, left: 44, right: 44),
                child: CommonHead(),
              ),
              Container(
                child: Column(
                  children: [
                    CommonTextFeild(hint: "Email", textEditingController:emailController ),
                    CommonTextFeild(hint: "Password", textEditingController:passwordController , obscure: showPass,
                      icon:InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Icon(CupertinoIcons.eye_solid, color: !showPass? kAppPrimaryColor: prefixIconColor,)),),
                    Padding(
                      padding: EdgeInsets.only(top: 24, left: 32, right: 32),
                      child: Container(
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: kAppPrimaryColor,
                                side: BorderSide(width: 0.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                value: isCheck, onChanged: (bool? value) {
                              setState(() {
                                isCheck = value!;
                                if(isCheck) {
                                  savePrefsData();
                                }
                              });
                            }),
                            CommonTextWidget(text: "Remember me", wght: FontWeight.w600, size: 14,)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
                      child: AuthButton(width: Global.getSizeWidth(context), pressed: () async {
                            RegistrationService apiService = RegistrationService();
                            SharedPreferences shared = await SharedPreferences.getInstance();
                            await apiService.loginUser(emailController.text, passwordController.text).then((value) {
                               WeatherModel? liveModel = value.weatherModel;
                               if(liveModel  == null) {
                                 showPopUpDialog(context: context, textTitle: "Failed", msgText: value.msg, pressed: () {
                                   Navigator.pop(context);
                                 });
                               }else{
                                 showPopUpDialog(context: context, textTitle: "Success", msgText: value.msg, pressed: () {
                                   Map<String,dynamic> loginPrefsData = {
                                     "token": value.token,
                                     "liveWeather": {
                                       "time": value.weatherModel!.time,
                                       "temperature": value.weatherModel!.temperature,
                                       "maxTemperature": value.weatherModel!.maxTemperature,
                                       "minTemperature": value.weatherModel!.minTemperature,
                                       "condition": value.weatherModel!.condition,
                                       "windSpeed": value.weatherModel!.windSpeed,
                                       "humidity": value.weatherModel!.humidity,
                                       "cityId": value.weatherModel!.cityId
                                     }
                                   };
                                   String encodeMap = json.encode(loginPrefsData);
                                   shared.setString("loginData",encodeMap );
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(loginResponseModel: value,)));
                                 });
                               }
                              log("Here value is ${value.weatherModel} and msg is ${value.msg}");
                            }).onError((error, stackTrace) {
                              log("here I am in login an error with $error and $stackTrace");
                            });

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }, color: logInButtonState(passwordController.text, emailController.text)?
                      buttonDisabledColor  :kAppPrimaryColor ,text: 'Login', ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 116, bottom: 50.0),
                      child: buildContainer(context: context, text: "Don't have an account ?", sideText: "Signup"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
