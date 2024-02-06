import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_restaurant_screen.dart';
import 'package:restaurant_app/home_screen.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(),

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
