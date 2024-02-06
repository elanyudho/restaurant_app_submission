import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_restaurant_screen.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/res/colors.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App', style: TextStyle(color: Colors.white)),
        backgroundColor: ThemeColors.PRIMARY_COLOR,
      ),
      body: FutureBuilder<String>(
        future:
        DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurant = parseRestaurants(snapshot.data);

          return ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurant[index]);
              });
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    onTap: () {
      Navigator.pushNamed(context, DetailRestaurant.routeName,
          arguments: restaurant);
    },
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(restaurant.name),
    subtitle: Row(
      children: [
        const Icon(Icons.location_pin, color: ThemeColors.PRIMARY_COLOR),
        const SizedBox(width: 4),
        Text(restaurant.city),
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: ThemeColors.ACCENT_COLOR),
        const SizedBox(width: 2),
        Text(restaurant.rating.toString()),
      ],
    ),
  );
}
