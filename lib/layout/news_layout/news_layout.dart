import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          var index = cubit.currentNavBarIndex;
          return Scaffold(
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              width: 270.0,
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                   DrawerHeader(
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2540/2540832.png'),
                            fit: BoxFit.contain,
                          )
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('News App'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, const SearchScreen());
                    },
                    icon: const Icon(Icons.search_rounded)),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value ==0){
                      navigateTo(context, SettingsScreen());
                    }

                  },
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                     const PopupMenuItem(
                       value: 0,
                        child: Text(
                            'Settings',
                        ),

                    ),
                  ],
                ),
              ],
            ),
            body: cubit.screens[index],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navBarList,
              currentIndex: index,
              showUnselectedLabels: true,
              onTap: (value) => cubit.onChangeSelectedIndex(value),
            ),
          );
        });
  }
}
