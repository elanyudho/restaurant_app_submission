import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/preference_helper.dart';
import 'package:restaurant_app/data/remote/api/api_service.dart';
import 'package:restaurant_app/domain/provider/preferences_provider.dart';
import 'package:restaurant_app/domain/provider/restaurant_provider.dart';
import 'package:restaurant_app/domain/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/page/favorite_screen.dart';
import 'package:restaurant_app/ui/page/home_screen.dart';
import 'package:restaurant_app/ui/page/search_screen.dart';
import 'package:restaurant_app/ui/page/setting_screen.dart';
import 'package:restaurant_app/ui/page/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local/database_helper.dart';
import 'domain/provider/database_provider.dart';
import 'ui/page/detail_restaurant_screen.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(create: (_) => PreferencesProvider(preferencesHelper: PreferencesHelper(sharedPreferences: SharedPreferences.getInstance())))
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(),
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          DetailRestaurant.routeName: (context) => DetailRestaurant(
              id: ModalRoute.of(context)?.settings.arguments as String),
          SearchScreen.routeName: (context) => const SearchScreen(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          SettingScreen.routeName: (context) => const SettingScreen()
        },
      ),
    );
  }
}
