import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/remote/response/restaurant_detail.dart';
import 'package:restaurant_app/data/remote/response/restaurant_list.dart';
import 'package:restaurant_app/data/remote/response/restaurant_search.dart';

import 'dummy_data.dart';


void main() {
  group('Parsing JSON Test', () {
    test('Should success parsing JSON for Restaurant List', () {
      var expectationResult = RestaurantListResult.fromJson(dummyListResult);

      expect(expectationResult.error, dummyListResult["error"]);
      expect(expectationResult.message, dummyListResult["message"]);
      expect(expectationResult.count, dummyListResult["count"]);
      expect(expectationResult.restaurants[0].id, "rqdv5juczeskfw1e867");
      expect(expectationResult.restaurants[0].name, "Melting Pot");
      expect(expectationResult.restaurants[0].city, "Medan");
      expect(expectationResult.restaurants[1].id, "s1knt6za9kkfw1e867");
      expect(expectationResult.restaurants[1].name, "Kafe Kita");
      expect(expectationResult.restaurants[1].city, "Gorontalo");
      expect(expectationResult.restaurants.length, 2);
    });

    test('Should success parsing JSON for Restaurant Detail', () {
      var expectationResult = RestaurantDetailResult.fromJson(dummyDetailResult);

      expect(expectationResult.error, dummyDetailResult["error"]);
      expect(expectationResult.message, dummyDetailResult["message"]);
      expect(expectationResult.restaurant.id, "rqdv5juczeskfw1e867");
      expect(expectationResult.restaurant.name, "Melting Pot");
    });

    test('Should success parsing JSON for Search Restaurant', () {
      var expectationResult = RestaurantSearchResult.fromJson(dummySearchResult);

      expect(expectationResult.error, dummySearchResult["error"]);
      expect(expectationResult.founded, dummySearchResult["founded"]);
      expect(expectationResult.error, dummySearchResult["error"]);
      expect(expectationResult.restaurants?[0]?.id, "rqdv5juczeskfw1e867");
      expect(expectationResult.restaurants?[0]?.name, "Melting Pot");
    });
  });

}