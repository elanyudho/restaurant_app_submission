import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../../model/restaurants.dart';
import '../../res/colors.dart';
import '../../widgets/item_list_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/searchScreen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ThemeColors.ACCENT_COLOR,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: 'Search Restaurant',
                        ),
                        onChanged: (String value) {
                          if (value == '') {
                            Provider.of<RestaurantProvider>(context,
                                    listen: false)
                                .setSearchScreenViewState(true);
                          } else {
                            Provider.of<RestaurantProvider>(context,
                                    listen: false)
                                .setSearchScreenViewState(false);
                            Provider.of<RestaurantProvider>(context,
                                    listen: false)
                                .getRestaurantSearch(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<RestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.isEmptyValue) {
                        return const Center(
                          child: Material(
                            child: Text('Temukan Restoran Referensi Anda'),
                          ),
                        );
                      } else {
                        switch (state.state) {
                          case ResultState.loading:
                            return const Center(
                                child: CircularProgressIndicator());
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
                            var data = state.restaurantSearch.restaurants;
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                state.restaurantSearch.restaurants?.length,
                                itemBuilder: (context, index) {
                                  return buildRestaurantItem(
                                      context,
                                      Restaurant(
                                          id: data?[index]?.id ?? "",
                                          name: data?[index]?.name ?? "",
                                          picture:
                                          data?[index]?.pictureId ?? "",
                                          city: data?[index]?.city ?? "",
                                          rating: data?[index]?.rating ?? 0.0));
                                });
                        }
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
