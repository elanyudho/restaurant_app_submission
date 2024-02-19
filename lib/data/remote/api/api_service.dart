import 'dart:convert';

import 'package:restaurant_app/data/remote/response/restaurant_detail.dart';
import 'package:restaurant_app/data/remote/response/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/remote/response/restaurant_search.dart';


class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _restaurants = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _images = 'images/medium/';

  Future<RestaurantListResult> getRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + _restaurants));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<RestaurantSearchResult> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search result');
    }
  }

  String getPathImageUrl(String picture) => _baseUrl + _images + picture;
}