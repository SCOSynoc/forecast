import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

class Global {

  static double  getSizeWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double  getSizeHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static String url = "https://hiring-test.a2dweb.com/";

  static IconData showIcons(String condition) {
    switch(condition) {
      case "sunny" : { return WeatherIcons.day_sunny;}
      case "partly-cloudy" : { return WeatherIcons.night_partly_cloudy;}
      case "cloudy" : { return WeatherIcons.cloudy;}
      case "thunder" : { return WeatherIcons.thunderstorm;}
      case "rainy" : { return WeatherIcons.rain;}
      case "snow" : { return WeatherIcons.snow;}
      case "stormy" : { return WeatherIcons.storm_showers;}
      default : {
        return WeatherIcons.refresh;
      }

    }
  }


}