import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/remote/response/restaurant_list.dart';
import 'package:restaurant_app/domain/provider/restaurant_provider.dart';

import '../../data/local/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getRestaurants();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getRestaurants() async {
    _favorites = await databaseHelper.getFavoriteRestaurants();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurant article) async {
    try {
      await databaseHelper.insertFavorite(article);
      _getRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}