import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forecast/globals/global.dart';
import 'package:forecast/models/user_register_model.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WeatherService {
/*  var headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmciOiJhMmQiLCJ1c2VySWQiOiI2Mzg4ZTFmYjk0OGRlYmExNTY3NGEyM2QiLCJhcHAiOiJ3ZWF0aGVyIiwiZGV2Ijoic3VtYW4iLCJpYXQiOjE2Njk5MTUxOTV9.SGbDiNeiyZNu0gwCAglmWllBcOpcSquOaSBXysW6AFc'
  };
  var request = http.Request('GET', Uri.parse('https://hiring-test.a2dweb.com/city-list/?query=1'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }*/

  Future<Map<String, dynamic>> getCityData(String token) async{
      String baseURl = Global.url + "city-list";
      var headers = {
         'Authorization': 'Bearer $token'
      };
      Response response;
      try {
         response = await http.get(Uri.parse(baseURl), headers: headers);
         if(response.statusCode == 200){
           log("Here response 200 is ${json.decode(response.body)}");
            return json.decode(response.body);
         }else if(response.statusCode == 400){
           log("Here response is ${json.decode(response.body)}");
            return json.decode(response.body);
         }else{
           log("Here response is ${json.decode(response.body)}");
            return json.decode(response.body);
         }
      }catch(e) {
         log("here I am in an exception $e");
         throw Exception(e);
      }

   }


   Future<Map<String, dynamic>> getWeatherForecast(String cityId, String token) async{
     String baseURl = Global.url + "view-other-forecast" +"/$cityId";
     var headers = {
       'Authorization': 'Bearer $token'
     };
     Response response;
     try {
       response = await http.get(Uri.parse(baseURl), headers: headers);
       if(response.statusCode == 200){
         log("Here response 200 is ${json.decode(response.body)}");
         return json.decode(response.body);
       }else if(response.statusCode == 400){
         log("Here response is ${json.decode(response.body)}");
         return json.decode(response.body);
       }else{
         log("Here response is ${json.decode(response.body)}");
         return json.decode(response.body);
       }
     }catch(e) {
       log("here I am in an exception $e");
       throw Exception(e);
     }
   }

   Future<LoginResponseModel> getLiveWeatherdata(String cityId, String token)async {
     String baseURl = Global.url + "live-weather" +"/$cityId";
     log("here error is ${baseURl}");
     var headers = {
       'Content-Type': 'application/json',
       'Authorization': 'Bearer $token'
     };
     Response response;
     try {
       response = await http.get(Uri.parse(baseURl), headers: headers);
       if(response.statusCode == 200){
         log("Here response 200 is ${json.decode(response.body)}");
         return LoginResponseModel.fromJson(json.decode(response.body));
       }else if(response.statusCode == 400){
         log("Here response is ${json.decode(response.body)}");
         return LoginResponseModel.fromJson(json.decode(response.body));
       }else{
         log("Here response is ${json.decode(response.body)}");
         return LoginResponseModel.fromJson(json.decode(response.body));
       }
     }catch(e) {
       log("here I am in an exception $e");
       throw Exception(e);
     }
   }


}