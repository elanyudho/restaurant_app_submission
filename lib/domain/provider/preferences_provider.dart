import 'package:flutter/cupertino.dart';

import '../../data/local/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getRecommendRestaurantPreferences();
  }

  bool _isRecommendRestaurantActive = false;
  bool get isRecommendRestaurantActive => _isRecommendRestaurantActive;

  void _getRecommendRestaurantPreferences() async {
    _isRecommendRestaurantActive = await preferencesHelper.isRecommendRestaurantActive;
    notifyListeners();
  }

  void enableRecommendRestaurant(bool value) {
    preferencesHelper.setRestaurantRecommendationActive(value);
    _getRecommendRestaurantPreferences();
  }
}