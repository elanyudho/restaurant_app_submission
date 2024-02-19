import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/domain/provider/database_provider.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/widgets/item_list_widget.dart';

import '../../domain/model/restaurants.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favoriteScreen';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.primaryColor,
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text("Restoran Favorite",
              style: TextStyle(color: Colors.white)),
        ),
        body: Consumer<DatabaseProvider>(builder: (context, state, _) {
          var data = state.favorites;
          if (data.isEmpty) {
            return const Center(child: Text('Tidak ada Restoran Favorite'));
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return buildRestaurantItem(
                    context,
                    Restaurant(
                        id: data[index].id,
                        name: data[index].name,
                        picture: data[index].pictureId,
                        city: data[index].city,
                        rating: data[index].rating));
              });
        }));
  }
}
