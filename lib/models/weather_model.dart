class WeatherModel {
  final String time;
  final String temperature;
  final String maxTemperature;
  final String minTemperature;
  final String condition;
  final String windSpeed;
  final String humidity;
  final String cityId;

  WeatherModel({required this.time,required this.temperature,
    required this.maxTemperature,required this.minTemperature,
    required this.condition,required this.cityId,
    required this.humidity, required this.windSpeed});

 factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        humidity: json['humidity'].toString(),
        minTemperature: json['minTemperature'].toString(),
        temperature: json['temperature'].toString(),
        cityId: json['cityId'].toString(),
        time: json['time'].toString(),
        windSpeed: json['windSpeed'].toString(),
        condition: json['condition'].toString(),
        maxTemperature: json['maxTemperature'].toString()
    );
  }
}