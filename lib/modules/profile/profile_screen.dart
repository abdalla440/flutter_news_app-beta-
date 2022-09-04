import 'package:flutter/material.dart';
import 'package:news_app/modules/favorites/favorites_screen.dart';
import 'package:news_app/modules/read_later/readlater_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/shared/components/components.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text('Settings'),
                ),
              ),
              onTap: () {
                navigateTo(context, SettingsScreen());
              },
            ),
            sectionSeparator(),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text('Read later'),
                ),
              ),
              onTap: () {
                navigateTo(context, const ReadLaterScreen());
              },
            ),
            sectionSeparator(),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Favorites'),
                ),
              ),
              onTap: () {
                navigateTo(context, const FavoritesScreen());
              },
            ),
            sectionSeparator(),

          ],
        ),
      ),
    );
  }
}
