
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/response/restaurant_search.dart';

import '../data/response/restaurant_detail.dart';
import '../data/response/restaurant_list.dart';

enum ResultState {loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  RestaurantProvider ({required this.apiService}) {
    _getRestaurantList();
  }

  late RestaurantListResult _restaurantListResult;
  late RestaurantDetailResult _restaurantDetailResult;
  late RestaurantSearchResult _restaurantSearchResult;

  bool _isEmptyValue = true;

  ResultState _state = ResultState.noData;
  String _message = '';

  RestaurantListResult get restaurantListResult => _restaurantListResult;
  RestaurantDetailResult get restaurantDetailResult => _restaurantDetailResult;
  RestaurantSearchResult get restaurantSearch => _restaurantSearchResult;
  bool get isEmptyValue => _isEmptyValue;

  ResultState get state => _state;
  String get message => _message;

  Future <dynamic> _getRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurants();

      if (restaurants.error) {
        _state = ResultState.error;
        notifyListeners();
        return _message = restaurantListResult.message;
      }

      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = restaurantListResult.message;
      }

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantListResult = restaurants;

    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal Terhubung ke Server';
    }
  }

  Future <dynamic> getRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getRestaurantSearch(query);

      if (data.error == true) {
        _state = ResultState.error;
        notifyListeners();
        return _message = "Terjadi Kesalahan. Silahkan Coba Lagi Nanti";
      }

      if (data.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Data Tidak Ditemukan";
      }

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantSearchResult = data;

    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal Terhubung ke Server';
    }
  }

  Future <dynamic> getRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(id);

      if (restaurant.error) {
        _state = ResultState.error;
        notifyListeners();
        return _message = restaurant.message;
      }

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetailResult = restaurant;

    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal Terhubung ke Server';
    }
  }

  setSearchScreenViewState(bool isEmptyValue) {
      _isEmptyValue = isEmptyValue;
      notifyListeners();
  }

}