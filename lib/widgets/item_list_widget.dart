import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/remote/api/api_service.dart';
import '../domain/model/restaurants.dart';
import '../domain/provider/restaurant_provider.dart';
import '../res/colors.dart';
import '../ui/page/detail_restaurant_screen.dart';

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    onTap: () {
      Provider.of<RestaurantProvider>(context, listen: false)
          .getRestaurantDetail(restaurant.id);
      Navigator.pushNamed(context, DetailRestaurant.routeName,
          arguments: restaurant.id);
    },
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: restaurant.name,
        child: Image.network(
          ApiService().getPathImageUrl(restaurant.picture),
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(restaurant.name),
    subtitle: Row(
      children: [
        const Icon(Icons.location_pin, color: ThemeColors.primaryColor),
        const SizedBox(width: 4),
        Text(restaurant.city),
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: ThemeColors.accentColor),
        const SizedBox(width: 2),
        Text(restaurant.rating.toString()),
      ],
    ),
  );
}