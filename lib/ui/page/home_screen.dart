import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/ui/page/search_screen.dart';

import '../../widgets/item_list_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Restaurant App', style: TextStyle(color: Colors.white)),
        backgroundColor: ThemeColors.PRIMARY_COLOR,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          )
        ],
      ),
      body: Consumer<RestaurantProvider>(builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return const Center(child: CircularProgressIndicator());
          case ResultState.noData:
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          case ResultState.error:
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          case ResultState.hasData:
            var data = state.restaurantListResult.restaurants;
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
        }
      }),
    );
  }
}

