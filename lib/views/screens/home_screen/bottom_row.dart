import "package:flutter/material.dart";
import 'package:sid_weather_app/views/constants/colors.dart';

class BottomRow extends StatelessWidget {
  final String pressure;
  final String wind;
  final String humidity;

  BottomRow({required this.pressure, required this.wind, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding:const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      margin:const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                 const Text(
                    "Pressure",
                    style: TextStyle(
                      color: CustomColors.gray,
                    ),
                  ),
                 const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    pressure,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                 const Text(
                    "Wind",
                    style: TextStyle(
                      color: CustomColors.gray,
                    ),
                  ),
                const  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    wind,
                    style:const TextStyle(
                      fontSize: 18.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                 const Text(
                    "Humidity",
                    style: TextStyle(
                      color: CustomColors.gray,
                    ),
                  ),
                 const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    humidity,
                    style:const TextStyle(
                      fontSize: 18.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
