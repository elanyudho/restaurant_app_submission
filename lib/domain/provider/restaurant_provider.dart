import 'package:flutter/material.dart';
import 'package:restaurant_app/data/remote/api/api_service.dart';
import 'package:restaurant_app/data/remote/response/restaurant_detail.dart';
import 'package:restaurant_app/data/remote/response/restaurant_list.dart';
import 'package:restaurant_app/data/remote/response/restaurant_search.dart';


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

  ResultState _stateHome = ResultState.noData;
  ResultState _stateSearch = ResultState.noData;
  ResultState _stateDetail = ResultState.noData;

  String _messageHome = '';
  String _messageSearch = '';
  String _messageDetail = '';

  RestaurantListResult get restaurantListResult => _restaurantListResult;
  RestaurantDetailResult get restaurantDetailResult => _restaurantDetailResult;
  RestaurantSearchResult get restaurantSearch => _restaurantSearchResult;
  bool get isEmptyValue => _isEmptyValue;

  ResultState get stateHome => _stateHome;
  ResultState get stateSearch => _stateSearch;
  ResultState get stateDetail => _stateDetail;

  String get messageHome => _messageHome;
  String get messageSearch => _messageSearch;
  String get messageDetail => _messageDetail;

  Future <dynamic> _getRestaurantList() async {
    try {
      _stateHome = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurants();

      if (restaurants.error) {
        _stateHome = ResultState.error;
        notifyListeners();
        return _messageHome = restaurantListResult.message;
      }

      if (restaurants.restaurants.isEmpty) {
        _stateHome = ResultState.noData;
        notifyListeners();
        return _messageHome = restaurantListResult.message;
      }

      _stateHome = ResultState.hasData;
      notifyListeners();
      return _restaurantListResult = restaurants;

    } catch(e) {
      _stateHome = ResultState.error;
      notifyListeners();
      return _messageHome = 'Gagal Terhubung ke Server';
    }
  }

  Future <dynamic> getRestaurantSearch(String query) async {
    try {
      _stateSearch = ResultState.loading;
      notifyListeners();
      final data = await apiService.getRestaurantSearch(query);

      if (data.error == true) {
        _stateSearch = ResultState.error;
        notifyListeners();
        return _messageSearch = "Terjadi Kesalahan. Silahkan Coba Lagi Nanti";
      }

      if (data.restaurants?.isEmpty == true) {
        _stateSearch = ResultState.noData;
        notifyListeners();
        return _messageSearch = "Data Tidak Ditemukan";
      }

      _stateSearch = ResultState.hasData;
      notifyListeners();
      return _restaurantSearchResult = data;

    } catch(e) {
      _stateSearch = ResultState.error;
      notifyListeners();
      return _messageSearch = 'Gagal Terhubung ke Server';
    }
  }

  Future <dynamic> getRestaurantDetail(String id) async {
    try {
      _stateDetail = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(id);

      if (restaurant.error) {
        _stateDetail = ResultState.error;
        notifyListeners();
        return _messageDetail = restaurant.message;
      }

      _stateDetail = ResultState.hasData;
      notifyListeners();
      return _restaurantDetailResult = restaurant;

    } catch(e) {
      _stateDetail = ResultState.error;
      notifyListeners();
      return _messageDetail = 'Gagal Terhubung ke Server';
    }
  }

  setSearchScreenViewState(bool isEmptyValue) {
      _isEmptyValue = isEmptyValue;
      notifyListeners();
  }

  clearStateSearch() {
    _isEmptyValue = true;
    _stateSearch = ResultState.noData;
    notifyListeners();
  }

}