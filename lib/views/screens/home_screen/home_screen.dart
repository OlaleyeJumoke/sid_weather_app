import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:sid_weather_app/models/weather.dart';
import 'package:sid_weather_app/view_model/weather.dart';
import 'package:sid_weather_app/views/constants/colors.dart';
import 'package:sid_weather_app/views/widgets/custom_graph/custom_graph.dart';

import 'bottom_row.dart';

class HomeScreen extends StatelessWidget {
  String hintText = "Enter your city ...";
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<WeatherProvider>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        appBar: AppBar(
         centerTitle: true,
          title:const Text("Weather app"),
          elevation: 2.0,
        ),
        body: Container(
          margin:const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                //color: Colors.amber,
                padding: const EdgeInsets.only(top: 14.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      TextField(
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: CustomColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          hintText: hintText,
                        ),
                        onSubmitted: (value) {
                         // print("entered city $value");
                          provider.fetchWeatherAction(value);
                        },
                      )
                   
                  ],
                ),
              ),
              Expanded(
                child: Consumer<WeatherProvider>(
                  builder: (context, provider, child) {
                    if (!provider.isWeatherAvailable) {
                      return const Center(
                        child: Text(
                          "I don't have any information yet!",
                          style: TextStyle(
                            color: CustomColors.gray,
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    }
                    String suitableTemp = (() {
                      var partOfDay = provider.weeklyWeather.partOfDay;
                      if (partOfDay == PartOfDay.morning) {
                        return provider.weeklyWeather.weather[0].morningTemp;
                      }
                      if (partOfDay == PartOfDay.day) {
                        return provider.weeklyWeather.weather[0].dayTemp;
                      }
                      if (partOfDay == PartOfDay.evening) {
                        return provider.weeklyWeather.weather[0].eveningTemp;
                      }
                      return provider.weeklyWeather.weather[0].nightTemp;
                    })();
              
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // const SizedBox(
                          //   height: 10.0,
                          // ),
                          Text(
                            provider.weeklyWeather.currentTime,
                            style: const TextStyle(
                              fontSize: 30.0,
                              color: CustomColors.black,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5.0,
                          // ),
                          Text(
                            provider.weeklyWeather.date,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.black,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(provider
                                      .weeklyWeather.weather[0].bigWeatherIconURL),
                                ),
                                Text(
                                  suitableTemp,
                                  style: const TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.black,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  provider
                                      .weeklyWeather.weather[0].weatherDescription,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buildGraph(
                              dataY: [
                                provider.weeklyWeather.weather[0].morningTempValue
                                    .round(),
                                provider.weeklyWeather.weather[0].dayTempValue
                                    .round(),
                                provider.weeklyWeather.weather[0].eveningTempValue
                                    .round(),
                                provider.weeklyWeather.weather[0].nightTempValue
                                    .round(),
                              ],
                              labelTexts: [
                                "morning",
                                "afternoon",
                                "evening",
                                "night",
                              ],
                              labelImageUrls: [
                                provider.weeklyWeather.weather[0].weatherIconURL,
                                provider.weeklyWeather.weather[0].weatherIconURL,
                                provider.weeklyWeather.weather[0].weatherIconURL,
                                provider.weeklyWeather.weather[0].weatherIconURL,
                              ],
                              highlightedIndex: (() {
                                final partsOfDay = [
                                  PartOfDay.morning,
                                  PartOfDay.day,
                                  PartOfDay.evening,
                                  PartOfDay.night
                                ];
                                return partsOfDay
                                    .indexOf(provider.weeklyWeather.partOfDay);
                              })()),
                          BottomRow(
                            humidity: provider.weeklyWeather.weather[0].humidity,
                            pressure: provider.weeklyWeather.weather[0].pressure,
                            wind: provider.weeklyWeather.weather[0].wind,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
