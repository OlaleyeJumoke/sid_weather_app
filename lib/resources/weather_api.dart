import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:sid_weather_app/models/weather.dart';

///calls the weather endpoint and returns the data
Future<WeeklyWeather> fetchWeeklyWeather(String cityName) async {
  String newCity = cityName.trim();
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast/daily?q=$newCity&units=metric&appid=4d549679691769c85c1c782f4f20ce07'));
  if (response.statusCode == 200) {
    return WeeklyWeather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch weather data for $cityName");
  }
}
