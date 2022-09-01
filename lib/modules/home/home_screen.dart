import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Widget> tabsBody = NewsCubit.get(context).homeTabsBody;
        List<Widget> tabsLabels = NewsCubit.get(context).homeTabsLabel;

        return DefaultTabController(
            length: tabsLabels.length,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    child: TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: tabsLabels,
                      isScrollable: true,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabsBody,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
