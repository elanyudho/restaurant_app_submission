import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/page/home_screen.dart';
import 'package:restaurant_app/ui/page/search_screen.dart';
import 'package:restaurant_app/ui/page/splash_screen.dart';

import 'page/detail_restaurant_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          DetailRestaurant.routeName: (context) => DetailRestaurant(id: ModalRoute.of(context)?.settings.arguments as String),
          SearchScreen.routeName: (context) => const SearchScreen()

        },
      ),
    );
  }
}
