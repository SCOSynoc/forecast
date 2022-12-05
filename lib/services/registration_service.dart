import 'dart:convert';

import 'package:forecast/globals/global.dart';
import 'package:forecast/models/user_register_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationService {


    Future<UserResponseModel>registerUser(UserRegisterModel userModel) async {
        String baseURl = Global.url + "create-user";
        var headers = {
            'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse(baseURl));

        request.body = json.encode(userModel.toJson());
        request.headers.addAll(headers);

        //try {
            http.StreamedResponse response = await request.send();
            if(response.statusCode == 201) {
                final responseData = await response.stream.bytesToString();
                return UserResponseModel.fromJson(json.decode(responseData));
            }else if(response.statusCode == 400 ) {
                final responseData = await response.stream.bytesToString();
                return UserResponseModel.fromJson(json.decode(responseData));
            }else{
                final responseData = await response.stream.bytesToString();
                return UserResponseModel.fromJson(json.decode(responseData));
            }
        /*}catch(e) {*/
        /*    throw Exception(e);*/
        /*}*/
    }

    Future<LoginResponseModel> loginUser(String email , String password)async {
        String baseURl = Global.url + "login";
        var headers = {
            'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse(baseURl));

        request.body = json.encode({
            "email": email,
            "password": password
        });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        if(response.statusCode == 200) {
            final responseData = await response.stream.bytesToString();

            print("here response is ${json.decode(responseData)}");


            return LoginResponseModel.fromJson(json.decode(responseData));
        }else if(response.statusCode == 400 ) {
            final responseData = await response.stream.bytesToString();
            return LoginResponseModel.fromJson(json.decode(responseData));
        }else{
            final responseData = await response.stream.bytesToString();
            return LoginResponseModel.fromJson(json.decode(responseData));
        }
    }

    Future<bool> logoutUser() async{
        SharedPreferences shared = await SharedPreferences.getInstance();
        shared.remove("loginData");
        return true;
    }

}