import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:sid_weather_app/view_model/weather.dart';
import 'package:sid_weather_app/views/constants/colors.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: Consumer<WeatherProvider>(
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
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "This Week",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  child: ListView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  provider
                                      .weeklyWeather.weather[index].weekDay,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    color: CustomColors.black,
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  provider
                                      .weeklyWeather.weather[index].dayTemp,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: CustomColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  Image(
                                      image: NetworkImage(provider
                                          .weeklyWeather
                                          .weather[index]
                                          .weatherIconURL)),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    provider.weeklyWeather.weather[index]
                                        .weatherDescription,
                                    style: const TextStyle(
                                      color: CustomColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
