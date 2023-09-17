import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sid_weather_app/providers/weather.dart';
import 'package:sid_weather_app/ui/screens/details_screen/details_screen.dart';
import 'package:sid_weather_app/ui/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
 final PageController _pageController = PageController(initialPage: 0);

   @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherProvider>(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            padEnds: false,
            children: [
              HomeScreen(),
              DetailsScreen(),
            ],
          ),
      ),
    );
  }
}

