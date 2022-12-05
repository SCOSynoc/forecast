import 'package:forecast/models/weather_model.dart';

class UserRegisterModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String country;

  UserRegisterModel({required this.name,required this.email,
    required this.password,required this.phone,required this.country});


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "country": country
    };
    return map;
  }

 factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(name: json["name"], email: json["email"], password: json["password"], phone: json["phone"], country: json["country"]);
  }
}

class UserResponseModel {
  final String status;
  final String message;
  UserRegisterModel? userModel;
  UserResponseModel( {required this.status, required this.message,required this.userModel});
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(status:json["status"].toString()?? "",
        userModel:json["DATA"] == null ? null : UserRegisterModel.fromJson(json["DATA"]), message: json['message']??"");
  }
}

class LoginResponseModel {
  final bool? status;
  final String msg;
  final String token;
  final WeatherModel? weatherModel;

  LoginResponseModel( {required this.status, required this.msg, required this.weatherModel, required this.token,});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        msg: json['msg'] ?? "",
        weatherModel:json["liveWeather"] == null? null : WeatherModel.fromJson(json["liveWeather"]),
        status: json["status"], token: json['token'] ?? " "
    );
  }
}