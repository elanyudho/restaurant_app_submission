import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/widgets/InvisibleExpandedHeader.dart';

import '../../data/response/restaurant_detail.dart';


class DetailRestaurant extends StatefulWidget {
  final String id;

  static const routeName = '/detailRestaurantScreen';

  const DetailRestaurant({Key? key, required this.id})
      : super(key: key);

  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  bool isBookmark = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<RestaurantProvider>(builder: (context, state, _) {
          switch(state.state) {
            case ResultState.loading:
              return const Center(child: CircularProgressIndicator());
            case ResultState.error:
              return Center(
                  child: Material(
                    child: Text(state.message),
                  ));
            case ResultState.hasData:
              var data = state.restaurantDetailResult.restaurant;
              return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: ThemeColors.PRIMARY_COLOR,
                        pinned: true,
                        expandedHeight: 200,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: false,
                          background: Hero(
                            tag: data.name,
                            child: Image.network(
                              ApiService().getPathImageUrl(data.pictureId),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: const InvisibleExpandedHeader(
                            child: Text(
                              'Detail Restaurant',
                            ),
                          ),
                          titlePadding: EdgeInsets.zero,
                        ),
                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 16.0),
                        child: Column(
                          children: [
                            Card(
                              elevation: 2,
                              shadowColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ThemeColors.ACCENT_COLOR, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_pin,
                                            color: ThemeColors.PRIMARY_COLOR),
                                        const SizedBox(width: 4),
                                        Text(data.city,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: ThemeColors.ACCENT_COLOR),
                                        const SizedBox(width: 4),
                                        Text(data.rating.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              elevation: 2,
                              shadowColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ThemeColors.ACCENT_COLOR, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "About",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(data.description,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.justify)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 400,
                              child: Card(
                                semanticContainer: true,
                                elevation: 2,
                                shadowColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ThemeColors.ACCENT_COLOR, width: 1.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Menu",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "Foods",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                          data.menus.foods.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return _buildFoodsItem(context,
                                                data.menus, index);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "Drinks",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                          data.menus.drinks.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return _buildDrinksItem(context,
                                                data.menus, index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            case ResultState.noData:
              return Center(
                  child: Material(
                    child: Text(state.message),
                  ));
          }

        })
    );
  }
}


Widget _buildFoodsItem(BuildContext context, Menus menus, int index) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 16, right: 16.0),
    title: Text(
      menus.foods[index].name,
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    trailing:
    const Icon(Icons.fastfood_rounded, color: ThemeColors.ACCENT_COLOR),
  );
}

Widget _buildDrinksItem(BuildContext context, Menus menus, int index) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 16, right: 16.0),
    title: Text(
      menus.drinks[index].name,
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    trailing:
    const Icon(Icons.fastfood_rounded, color: ThemeColors.ACCENT_COLOR),
  );
}

