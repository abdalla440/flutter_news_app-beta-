import 'package:flutter/material.dart';
import 'package:news_app/modules/read_later/readlater_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Settings'),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Read later'),
                ),
              ),
              onTap: () {
                navigateTo(context, ReadLaterScreen());
              },
            ),
            sectionSeparator(),

          ],
        ),
      ),
    );
  }
}
