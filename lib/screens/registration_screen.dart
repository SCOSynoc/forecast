import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast/globals/constants.dart';
import 'package:forecast/models/user_register_model.dart';
import 'package:forecast/screens/login_screen.dart';
import 'package:forecast/services/registration_service.dart';
import 'package:forecast/widgets/CommonTextFeild.dart';
import 'package:forecast/widgets/auth_button.dart';
import 'package:forecast/widgets/drop_down.dart';
import 'package:forecast/widgets/text_widgets.dart';

import '../globals/global.dart';
import '../widgets/common_head.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> items = ["India", "USA", "United Kingdom", "Australia", "Germany"];
  String? itvalue;
  String country = "";
  bool showPass = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:Container(
        width: Global.getSizeWidth(context),
        height: Global.getSizeHeight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 92, bottom: 45, left: 44, right: 44),
                    child: CommonHead(),
                  ),

                  Container(
                    child: Column(
                      children: [
                        CommonTextFeild(hint: "Full Name", textEditingController:nameController ),
                        CommonTextFeild(hint: "Phone Number", textEditingController:phoneController , keyboardType: TextInputType.phone, length: 10,),
                        DropDownWidget(itemsList: items, itemValue: itvalue, changed: (value) {
                          setState(() {
                            itvalue = value;
                            if(itvalue != null){
                              country = itvalue!;
                            }
                          });
                        },),
                        CommonTextFeild(hint: "Email", textEditingController:emailController ),
                        CommonTextFeild(hint: "Password", textEditingController:passwordController , obscure: showPass, icon: InkWell(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                            child: Icon(CupertinoIcons.eye_solid,color: showPass?prefixIconColor:kAppPrimaryColor,)
                        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
                          child: AuthButton(width: Global.getSizeWidth(context), pressed: () async{
                            UserRegisterModel addUser = UserRegisterModel(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                country: "India"
                            );

                            RegistrationService apiService = RegistrationService();
                            await apiService.registerUser(addUser).then((value) {
                                UserRegisterModel? model = value.userModel;
                                log("here value is ${value.status} and message is ${value.message} and data is ${model}");
                                if(model == null) {
                                  showPopUpDialog(context: context, textTitle: "Failed", msgText: value.message, pressed: () {
                                    Navigator.pop(context);
                                  });
                                }else{
                                  showPopUpDialog(context: context, textTitle: "Success", msgText: "Registration successful", pressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen(password: passwordController.text, email: model.email,)));
                                  });
                                }
                            }).onError((error, stackTrace){
                              log("here registration error  $error and $stackTrace");
                            });


                          }, color: buttonState(nameController.text, passwordController.text, phoneController.text, emailController.text)?
                          buttonDisabledColor  :kAppPrimaryColor ,text: 'Signup', ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 116, bottom: 50.0),
                          child: buildContainer(context: context),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ) ,
    );
  }
}

