import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const recommendRestaurant = 'RECOMMEND_RESTAURANT';

  Future<bool> get isRecommendRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(recommendRestaurant) ?? false;
  }

  void setRestaurantRecommendationActive(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(recommendRestaurant, value);
  }
}