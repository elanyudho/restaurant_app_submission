import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/res/colors.dart';

import '../../domain/provider/preferences_provider.dart';
import '../../domain/provider/scheduling_provider.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/platform_widget.dart';

class SettingScreen extends StatelessWidget {
  static const String settingsTitle = 'Setting';
  static const routeName = '/settingScreen';


  const SettingScreen({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: ThemeColors.primaryColor,
        title: const Text(settingsTitle, style: TextStyle(color: ThemeColors.whiteColor),),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: BackButton(
        color: Colors.white,
      ),
        backgroundColor: ThemeColors.primaryColor,
        middle: Text(settingsTitle, style: TextStyle(color: ThemeColors.whiteColor),),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Rekomendasikan Restoran'),
                subtitle: const Text('Aktifkan Notifikasi'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      activeTrackColor: ThemeColors.accentColor,
                      value: provider.isRecommendRestaurantActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableRecommendRestaurant(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}